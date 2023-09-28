using PowerDynamics: _find_operationpoint_rootfind
using PowerDynamics: rhs#, symbolsof
using NLsolve: nlsolve, converged
using IfElse
#include("PowerFlow.jl") # for NodalAdmittanceMatrice

function InitializeInternalDynamics(pg::PowerGrid,ic_lf::Array{Float64,1}) # ,I_c::Matrix{Complex{Float64}})
   Ykk = NodalAdmittanceMatrice(pg)
   Uc  = getComplexBusVoltage(pg,ic_lf)
   I_c = Ykk*Uc

   ind_offset = 1
   pg_new = deepcopy(pg)
   ic0 = deepcopy(ic_lf)
   for (ind,val) in enumerate(pg.nodes)
      len_node_dynamics = length(symbolsof(val[2]))
       if len_node_dynamics != 2
          ic0[ind_offset:ind_offset+len_node_dynamics-1],node = InitNode(val[2],ind,I_c,ic_lf,ind_offset)
          pg_new.nodes[val[1]] = node #Update powergrid
       end
       ind_offset += len_node_dynamics
   end
   return pg_new,ic0
end

function InitNode(SM::FourthOrderEq,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]
   #Rotor angle
   δ = angle(v_d_temp+1im*v_q_temp+(+1im*(SM.X_q - SM.X_q_dash))*I_c[ind])

   v   = v_d_temp +1im*v_q_temp
   v   = 1im*v*exp(-1im*δ)
   v_d = real(v)
   v_q = imag(v)
   i   = 1im*I_c[ind]*exp(-1im*δ)
   i_d = real(i)
   i_q = imag(i)

   V_f = v_q + (SM.X_d - SM.X_d_dash) * i_d
   pe = SM.P + (SM.X_q_dash - SM.X_d_dash)*i_d*i_q
   node_temp = FourthOrderEq(H=SM.H, P=pe, D=SM.D, Ω=SM.Ω, E_f=V_f, T_d_dash=SM.T_d_dash ,T_q_dash=SM.T_q_dash ,X_q_dash =SM.X_q_dash ,X_d_dash=SM.X_d_dash,X_d=SM.X_d, X_q=SM.X_q)
   return [v_d_temp, v_q_temp, δ, 0.], node_temp
end

function InitNode(MC::MatchingControlRed,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]
   U0 = v_d_temp+1im*v_q_temp
   θ = angle(U0)

   s = U0 * conj(I_c[ind])/ (MC.Srated/MC.Sbase)
   p = real(s)
   q = imag(s)

   #The current of the capacitor has to be related, since rf,xlf and xcf are related to Sbase!!!
   i1 = I_c[ind] / (MC.Srated/MC.Sbase) + U0/(-1im*MC.xcf) #/(MC.Srated/MC.Sbase)
   E = U0 + (MC.rf + 1im*MC.xlf) * i1

   idqmeas = I_c[ind]*(cos(-θ)+1im*sin(-θ)) / (MC.Srated/MC.Sbase) #1im*
   idmeas = real(idqmeas)
   iqmeas = imag(idqmeas)

   idq = i1*(cos(-θ)+1im*sin(-θ)) #1im*
   id = real(idq)
   iq = imag(idq)

   P_before = real(conj(i1) * E)
   Q_before = imag(conj(i1) * E)
   dP =  P_before - p
   idc0 = MC.gdc + MC.p0set/ (MC.Srated/MC.Sbase) + dP
   p0_new = idc0 - MC.gdc - dP
   udc = 0.0 #ist hier nur das delta

   U0 = U0*(cos(-θ)+1im*sin(-θ))
   udmeas = real(U0) #should be equal to abs(U0)
   uqmeas = imag(U0) #should be zero

   E0 = E*(cos(-θ)+1im*sin(-θ))
   umd = real(E0)
   umq = imag(E0)

   e_id = (umd - udmeas + iq * MC.xlf ) #- id*MC.rf
   e_iq = (umq - uqmeas - id * MC.xlf )#- iq*MC.rf

   e_ud = (id - idmeas + uqmeas / MC.xcf)#/ MC.Ki_u #hier müsste es ohne idmeas und iqmeas sein
   e_uq = (iq - iqmeas - udmeas / MC.xcf) #/ MC.Ki_u #passt das überhaupt mit dem Srated/Sbase???

      MC_new = MatchingControlRed(
      Sbase = MC.Sbase,
      Srated = MC.Srated,
      p0set = p0_new, #new
      u0set = MC.u0set,
      Kp_uset = MC.Kp_uset,
      Ki_uset = MC.Ki_uset,
      Kdc = MC.Kdc,
      gdc = MC.gdc,
      cdc = MC.cdc,
      xlf = MC.xlf,
      rf = MC.rf,
      xcf =  MC.xcf,
      Tdc = MC.Tdc,
      Kp_u = MC.Kp_u,
      Ki_u = MC.Ki_u,
      Kp_i = MC.Kp_i,
      Ki_i = MC.Ki_i,
      imax_csa = MC.imax_csa,
      imax_dc = MC.imax_dc,
      p_red = MC.p_red,
      LVRT_on = MC.LVRT_on,
      p_ind = MC.p_ind,
      )

    return [v_d_temp, v_q_temp,θ,udc,idc0,abs(U0),e_ud,e_uq,e_id,e_iq,dP,abs(i1),0.0], MC_new #P_before,Q_before,p,q,abs(idq)
end

function InitNode(VOC::dVOC,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]
   U0 = v_d_temp+1im*v_q_temp
   θ = angle(U0)

   s = U0 * conj(I_c[ind]) / (VOC.Srated/VOC.Sbase)
   p = real(s)
   q = imag(s)

   #The current of the capacitor has to be related, since rf,xlf and xcf are related to Sbase!!!
   i1 = I_c[ind] / (VOC.Srated/VOC.Sbase) + U0/(-1im*VOC.xcf) #/(VOC.Srated/VOC.Sbase)
   E = U0 + (VOC.rf + 1im*VOC.xlf) * i1

   idqmeas = I_c[ind]*(cos(-θ)+1im*sin(-θ)) / (VOC.Srated/VOC.Sbase) #1im*
   idmeas = real(idqmeas)
   iqmeas = imag(idqmeas)

   idq = i1*(cos(-θ)+1im*sin(-θ)) #1im*
   id = real(idq)
   iq = imag(idq)

   P_before = real(conj(i1) * E)
   Q_before = imag(conj(i1) * E)
   dP =  P_before - p
   idc0 = VOC.gdc + VOC.p0set/ (VOC.Srated/VOC.Sbase)  + dP
   p0_new = idc0 - VOC.gdc - dP
   udc = 0.0 #ist hier nur das delta

   U0 = U0*(cos(-θ)+1im*sin(-θ))
   udmeas = real(U0) #should be equal to abs(U0)
   uqmeas = imag(U0) #should be zero

   qset = VOC.q0set
   x1 = (qset + VOC.u0set^2) * VOC.alpha/ (2 * VOC.alpha) + sqrt(((-qset - VOC.u0set^2*VOC.alpha) / (2 * VOC.alpha))^2 - qset * VOC.u0set / VOC.alpha)
   vd_int = sqrt(x1) - VOC.ϵ
   E0 = E*(cos(-θ)+1im*sin(-θ))
   umd = real(E0)
   umq = imag(E0)


   e_id = (umd - udmeas + iq * VOC.xlf ) #- id*VOC.rf
   e_iq = (umq - uqmeas - id * VOC.xlf )#- iq*VOC.rf

   e_ud = (id - idmeas + uqmeas / VOC.xcf)#/ VOC.Ki_u #hier müsste es ohne idmeas und iqmeas sein
   e_uq = (iq - iqmeas - udmeas / VOC.xcf) #/ VOC.Ki_u #passt das überhaupt mit dem Srated/Sbase???

   VOC_new = dVOC(
          Sbase = VOC.Sbase,
          Srated = VOC.Srated,
          p0set = p0_new, #new
          q0set = q,
          u0set = VOC.u0set,
          eta = VOC.eta,
          alpha = VOC.alpha,
          Kdc = VOC.Kdc,
          gdc = VOC.gdc,
          cdc = VOC.cdc,
          xlf = VOC.xlf,
          rf = VOC.rf,
          xcf =  VOC.xcf,
          Tdc = VOC.Tdc,
          Kp_u = VOC.Kp_u,
          Ki_u = VOC.Ki_u,
          Kp_i = VOC.Kp_i,
          Ki_i = VOC.Ki_i,
          imax_csa = VOC.imax_csa,
          imax_dc = VOC.imax_dc,
          p_red = VOC.p_red,
          ϵ = VOC.ϵ,
          LVRT_on = VOC.LVRT_on,
          p_ind = VOC.p_ind,
          )

    return [v_d_temp, v_q_temp,θ,udc,idc0,vd_int,e_ud,e_uq,e_id,e_iq,p,q,dP,abs(i1),0.0,0.0], VOC_new #,idmeas,iqmeas,id,iq
end

function InitNode(DR::droop,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]
   U0 = v_d_temp+1im*v_q_temp
   θ = angle(U0)

   s = U0 * conj(I_c[ind]) / (DR.Srated/DR.Sbase)
   p = real(s)
   q = imag(s)

   #The current of the capacitor has to be related, since rf,xlf and xcf are related to Sbase!!!
   i1 = I_c[ind] / (DR.Srated/DR.Sbase) + U0/(-1im*DR.xcf) #/(DR.Srated/DR.Sbase)
   E = U0 + (DR.rf + 1im*DR.xlf) * i1

   idqmeas = I_c[ind]*(cos(-θ)+1im*sin(-θ)) / (DR.Srated/DR.Sbase) #1im*
   idmeas = real(idqmeas)
   iqmeas = imag(idqmeas)

   idq = i1*(cos(-θ)+1im*sin(-θ)) #1im*
   id = real(idq)
   iq = imag(idq)

   P_before = real(conj(i1) * E)
   Q_before = imag(conj(i1) * E)
   dP =  P_before - p
   idc0 = DR.gdc + DR.p0set/ (DR.Srated/DR.Sbase)  + dP
   p0_new = idc0 - DR.gdc - dP
   udc = 0.0 #ist hier nur das delta

   U0 = U0*(cos(-θ)+1im*sin(-θ))
   udmeas = real(U0) #should be equal to abs(U0)
   uqmeas = imag(U0) #should be zero

   E0 = E*(cos(-θ)+1im*sin(-θ))
   umd = real(E0)
   umq = imag(E0)

   e_id = (umd - udmeas + iq * DR.xlf ) #- id*DR.rf
   e_iq = (umq - uqmeas - id * DR.xlf )#- iq*DR.rf

   e_ud = (id - idmeas + uqmeas / DR.xcf)#/ DR.Ki_u #hier müsste es ohne idmeas und iqmeas sein
   e_uq = (iq - iqmeas - udmeas / DR.xcf) #/ DR.Ki_u #passt das überhaupt mit dem Srated/Sbase???

   droop_new = droop(
         Sbase = DR.Sbase,
         Srated = DR.Srated,
         p0set = p0_new, #new
         u0set = DR.u0set,
         Kp_droop = DR.Kp_droop,
         Kp_uset = DR.Kp_uset,
         Ki_uset = DR.Ki_uset,
         Kdc = DR.Kdc,
         gdc = DR.gdc,
         cdc = DR.cdc,
         xlf = DR.xlf,
         rf = DR.rf,
         xcf =  DR.xcf,
         Tdc = DR.Tdc,
         Kp_u = DR.Kp_u,
         Ki_u = DR.Ki_u,
         Kp_i = DR.Kp_i,
         Ki_i = DR.Ki_i,
         imax_csa = DR.imax_csa,
         imax_dc = DR.imax_dc,
         p_red = DR.p_red,
         LVRT_on = DR.LVRT_on,
         p_ind = DR.p_ind,
         )

    return [v_d_temp, v_q_temp,θ,udc,idc0,abs(U0),e_ud,e_uq,e_id,e_iq,p,dP,abs(i1),abs(i1),0.0,p,q], droop_new #,idc0,abs(E0),P_before,Q_before,p,q
end

function InitNode(VSM0::VSM,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]
   U0 = v_d_temp+1im*v_q_temp
   θ = angle(U0)

   s = U0 * conj(I_c[ind]) / (VSM0.Srated/VSM0.Sbase)
   p = real(s)
   q = imag(s)

   #The current of the capacitor has to be related, since rf,xlf and xcf are related to Sbase!!!
   i1 = I_c[ind] / (VSM0.Srated/VSM0.Sbase) + U0/(-1im*VSM0.xcf) #/(VSM0.Srated/VSM0.Sbase)
   E = U0 + (VSM0.rf + 1im*VSM0.xlf) * i1

   idqmeas = I_c[ind]*(cos(-θ)+1im*sin(-θ)) / (VSM0.Srated/VSM0.Sbase) #1im*
   idmeas = real(idqmeas)
   iqmeas = imag(idqmeas)

   idq = i1*(cos(-θ)+1im*sin(-θ)) #1im*
   id = real(idq)
   iq = imag(idq)

   P_before = real(conj(i1) * E)
   Q_before = imag(conj(i1) * E)
   
   dP =  P_before - p
   idc0 = VSM0.gdc + VSM0.p0set/ (VSM0.Srated/VSM0.Sbase) + dP
   p0_new = idc0 - VSM0.gdc - dP
   udc = 0.0 #ist hier nur das delta

   U0 = U0*(cos(-θ)+1im*sin(-θ))
   udmeas = real(U0) #should be equal to abs(U0)
   uqmeas = imag(U0) #should be zero

   E0 = E*(cos(-θ)+1im*sin(-θ))
   umd = real(E0)
   umq = imag(E0)

   e_id = (umd - udmeas + iq * VSM0.xlf ) #- id*VSM0.rf
   e_iq = (umq - uqmeas - id * VSM0.xlf )#- iq*VSM0.rf

   e_ud = (id - idmeas + uqmeas / VSM0.xcf)#/ VSM0.Ki_u #hier müsste es ohne idmeas und iqmeas sein
   e_uq = (iq - iqmeas - udmeas / VSM0.xcf) #/ VSM0.Ki_u #passt das überhaupt mit dem Srated/Sbase???

   vsm_new = VSM(
          Sbase = VSM0.Sbase,
          Srated = VSM0.Srated,
          p0set = p0_new, #new
          u0set = VSM0.u0set,
          J = VSM0.J,
          Dp = VSM0.Dp,
          Kp_uset = VSM0.Kp_uset,
          Ki_uset = VSM0.Ki_uset,
          Kdc = VSM0.Kdc,
          gdc = VSM0.gdc,
          cdc = VSM0.cdc,
          xlf = VSM0.xlf,
          rf = VSM0.rf,
          xcf =  VSM0.xcf,
          Tdc = VSM0.Tdc,
          Kp_u = VSM0.Kp_u,
          Ki_u = VSM0.Ki_u,
          Kp_i = VSM0.Kp_i,
          Ki_i = VSM0.Ki_i,
          imax_csa = VSM0.imax_csa,
          imax_dc = VSM0.imax_dc,
          p_red = VSM0.p_red,
          LVRT_on = VSM0.LVRT_on,
          p_ind = VSM0.p_ind,
          )

    return [v_d_temp, v_q_temp,θ,0.0,udc,idc0,abs(U0),e_ud,e_uq,e_id,e_iq,p,dP,abs(i1),0.0], vsm_new #,idmeas,iqmeas,id,iq
end

function InitNode(GP::gentpjAVROEL,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)

   #saturation function
   function sat_scaled_quadratic(x1)
       A = (1.2 - sqrt(1.2*GP.S_12/GP.S_10)) / (1.0 - sqrt(1.2*GP.S_12/GP.S_10))
       B = GP.S_10 / (1 - A)^2
       if x1 > A
           return B*(x1-A)^2/x1
       else
           return 0.0
       end
   end
   function sat_exponential(x1)
      q = log(GP.S_12/GP.S_10)/log(1.2)
      return GP.S_10*x1^q
  end
   
   #get inital values
   v_r_term = ic_lf[ind_offset]
   v_i_term = ic_lf[ind_offset+1]
   i_r = real(I_c[ind])/(GP.Srated/GP.Sbase)
   i_i = imag(I_c[ind])/(GP.Srated/GP.Sbase)

   #Calculate saturation
   E_l = norm([v_i_term + i_i * GP.R_a + i_r * GP.X_l,v_r_term + i_r * GP.R_a - i_i * GP.X_l]) #magnitude not changed by dq-transformation
   S_d = sat_exponential(E_l)
   S_q = (GP.X_q)/(GP.X_d) * S_d

   #Calulate Polradspannung
   Xdsatss = (GP.X_dss - GP.X_l) /  (1 + S_d) + GP.X_l
   Xqsatss = (GP.X_qss - GP.X_l) /  (1 + S_q) + GP.X_l   
   Vr = v_r_term + GP.R_a *i_r  - Xqsatss * i_i
   Vi = v_i_term + GP.R_a *i_i  + Xdsatss * i_r

   #calculate δ
   K_temp = (GP.X_q-GP.X_l)/(1 + S_q) + GP.X_l
   δ = atan((v_i_term+i_r*K_temp + GP.R_a *i_i)/(v_r_term - i_i*K_temp +GP.R_a *i_r))

   #terminal voltage transformation to local dq-system
   v = v_r_term+1im*v_i_term
   v = 1im*v*exp(-1im*δ)
   v_d = real(v)
   v_q = imag(v)

   #current transformation to dq-system
   i_c = 1im*I_c[ind]*exp(-1im*δ)/(GP.Srated/GP.Sbase)
   i_d = real(i_c)
   i_q = imag(i_c)

   #initial conditions as derivative has to be 0
   e_q2 = 0;
   e_d2 = 0;
   e_d1 = 0;

   #equations
   edqss = 1im*(Vr+1im*Vi)*exp(-1im*δ)
   
   e_q1 = v_q + i_q * GP.R_a + i_d * ((GP.X_d - GP.X_l) / (1 + S_d) + GP.X_l)
   e_qss = e_q1 + e_q2 - i_d * ((GP.X_d - GP.X_dss) / (1 + S_d))
  
   e_dss = e_d1 + e_d2 + i_q * ((GP.X_q - GP.X_qss) / (1 + S_q))

   e_qs = e_qss + i_d * ((GP.X_ds - GP.X_dss) / (1 + S_d))
   e_ds = e_dss - i_q * ((GP.X_qs - GP.X_qss) / (1 + S_q))

   #field voltage
   v_f = (1+S_d)*e_q1

   #AVR & OEL
   #Field current in a non-reciprocal system, otherwise would be: ifd = (E_f - T_d0s * de_qs) / (X_d - X-l)
   ifd = v_f  #due to: ifd = (E_f - T_d0s * de_qs) de_qs = (E_f - (1 + S_d) * e_q1) * 1 / T_d0s
   Vref = abs(v) + v_f/GP.G1

   #Pm also needs to be initialized
   Pm = (v_q + GP.R_a * i_q) * i_q + (v_d + GP.R_a * i_d) * i_d

   #Create new bus
   node_temp = gentpjAVROEL(Sbase=GP.Sbase,Srated=GP.Srated,H=GP.H, P=Pm, D=GP.D, Ω=GP.Ω,
                                           R_a=GP.R_a, T_d0s=GP.T_d0s, T_q0s=GP.T_q0s, T_d0ss=GP.T_d0ss,
                                           T_q0ss=GP.T_q0ss, X_d=GP.X_d, X_q=GP.X_q, X_ds=GP.X_ds, X_qs=GP.X_qs,
                                           X_dss=GP.X_dss, X_qss=GP.X_qss, X_l=GP.X_l, S_10=GP.S_10, S_12=GP.S_12, K_is = GP.K_is,
                                           V0 = Vref, Ifdlim = GP.Ifdlim, L1 = GP.L1, G1 = GP.G1, Ta = GP.Ta, Tb = GP.Tb,
                                           G2 = GP.G2, L2 = GP.L2);
return [v_r_term, v_i_term, δ, 0., e_ds, e_qs, e_dss, e_qss,E_l,ifd,GP.L1,v_f,v_f], node_temp
end

function InitNode(L::GeneralVoltageDependentLoad,ind::Int64,I_c::Vector{Complex{Float64}},ic_lf::Array{Float64,1},ind_offset::Int64)
   v_d_temp = ic_lf[ind_offset]
   v_q_temp = ic_lf[ind_offset+1]

   U0 = v_d_temp+1im*v_q_temp

   s = U0 * conj(I_c[ind]) 
   p = real(s)
   q = imag(s)
   return [v_d_temp, v_q_temp,p, q], L
end

