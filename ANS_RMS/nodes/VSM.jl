@DynamicNode VSM(Sbase,Srated,p0set,u0set,J,Dp,Kp_uset,Ki_uset,Kdc,gdc,cdc,xlf,rf,xcf,Tdc,Kp_u,Ki_u,Kp_i,Ki_i,imax_csa,imax_dc,p_red,LVRT_on,p_ind) begin
    MassMatrix(m_int =[true,true,true,true,true,true,true,true,true,true,true,false,true])#,false,false,false,false
end begin
    @assert Sbase > 0 "Base apparent power of the grid in VA, should be >0"
    @assert Srated > 0 "Rated apperent power of the machine in VA, should be >0"
    @assert p0set >= 0 "Set point for active power in p.u, should be >0"
    @assert u0set > 0 "Set point for voltage in p.u, should be >0"
    @assert J > 0 "Inertia, should be >0" #Jbase = #Srated/(w_base) = 5300e6/(100*pi)^2
    @assert Dp >= 0 "Damping constant, should be >0"
    @assert Kp_uset >= 0 "P-Gain for voltage control, should be >=0"
    @assert Ki_uset >= 0 "I-Gain for voltage control.u, should be >=0"
    @assert Kdc >= 0 "Droop constant for current control in p.u, should be >=0"
    @assert gdc >=0 "Conductance of DC-circuit in global p.u., should be >=0"
    @assert cdc >0 "Capacitance of DC-circuit in global p.u., should be >=0"
    @assert xlf >= 0 "filter inductive reactance in p.u., should be >=0"
    @assert rf >= 0 "filter resistance in p.u., should be >=0"
    @assert xcf >= 0 "filter capacitive reactance in p.u., should be >=0"
    @assert Tdc >= 0 "DC control time constant in s, should be > 0"
    @assert Kp_u >= 0 "Proportional gain for voltage control loop, should be >0"
    @assert Ki_u >= 0 "Integral gain for voltage control loop, should be >0"
    @assert Kp_i >= 0 "Proportional gain for current control loop, should be >0"
    @assert Ki_i >= 0 "Integral gain for current control loop, should be >0"
    @assert imax_csa >= 0 "max. current for current saturation algorithm (CSA) in p.u., should be >=0"
    @assert imax_dc >= 0 "max. current of dc source in p.u., should be >=0"
    @assert p_red == 0 || p_red == 1 "Boolean value vor activating or deactivating power reduction in case of limited current"

end [[θ,dθ],[w,dw],[udc,dudc],[idc0,didc0],[x_uabs,dx_uabs],[e_ud,de_ud],[e_uq,de_uq],[e_id,de_id],[e_iq,de_iq],[Pf,dPf],[Pdelta,dPdelta],[iset_abs,diset_abs],[LVRT,dLVRT]] begin #,[Ps,dPs],[Qs,dQs],[P0,dP0],[Q0,dQ0]
    J = p[p_ind[1]]
    Dp = p[p_ind[2]]
    Kp_uset = p[p_ind[3]]
    Ki_uset = p[p_ind[4]]
    Kdc = p[p_ind[5]] #
    gdc = p[p_ind[6]] #
    cdc = p[p_ind[7]] #
    xlf = p[p_ind[8]]
    rf = p[p_ind[9]]
    xcf = p[p_ind[10]]
    Tdc = p[p_ind[11]] #
    Kp_u = p[p_ind[12]]
    Ki_u = p[p_ind[13]]
    Kp_i = p[p_ind[14]]
    Ki_i = p[p_ind[15]]
    imax_csa = p[p_ind[16]]
    imax_dc = p[p_ind[17]]
    p_red = p[p_ind[18]]
    LVRT_on = p[p_ind[19]]

    #after filter
    umeas = u*(cos(-θ)+1im*sin(-θ))
    udmeas = real(umeas)
    uqmeas = imag(umeas)
    imeas = i*(cos(-θ)+1im*sin(-θ))/(Srated/Sbase) #1im*
    idmeas = real(imeas)
    iqmeas = imag(imeas)
    pmeas = real(umeas * conj(imeas))
    qmeas = imag(umeas * conj(imeas))

    #before filter
    #The current of the capacitor has to be related, since rf,xlf and xcf are related to Sbase!!!
    idq =  imeas + umeas / (-1im * xcf) #/ (Srated/Sbase)
    id  = real(idq)
    iq  = imag(idq)

    E = umeas + (rf + 1im*xlf) * idq
    p_before_filter = real(conj(idq) * E)
    q_before_filter = imag(conj(idq) * E)
    ix  = p_before_filter   #AC/DC coupling

    #Voltage control
    Δuabs = u0set - abs(u)
    #dx_uabs = Ki_uset * Δuabs
    Mf = 1.0 # virtual mutual inductance, value taken from Doerfler et. al
    i_f = x_uabs + Kp_uset * Δuabs #field current

    #Building voltage reference
    udset = Mf * i_f * (w + 1.0)
    uqset = 0.0

    #Voltage control
    de_ud = (udset - udmeas) * Ki_u
    de_uq = (uqset - uqmeas) * Ki_u

    idset = idmeas - uqmeas / xcf + Kp_u * (udset - udmeas) + e_ud
    iqset = iqmeas + udmeas / xcf + Kp_u * (uqset - uqmeas) + e_uq

    #Current saturation algorithm
    diset_abs = iset_abs - hypot(idset,iqset)
    iset_lim = IfElse.ifelse(iset_abs >= imax_csa,imax_csa,iset_abs)
    ϕ1 = atan(iqset,idset)
    idset_csa = iset_lim*cos(ϕ1)
    iqset_csa = iset_lim*sin(ϕ1)

    #experimentell
    anti_windup = IfElse.ifelse(iset_abs >= imax_csa && p_red > 0,true,false)
    de_ud = IfElse.ifelse(anti_windup,0.0, (udset - udmeas) * Ki_u)
    de_uq = IfElse.ifelse(anti_windup,0.0, (uqset - uqmeas) * Ki_u)

    #Current control
    de_id = (idset_csa - id) * Ki_i
    de_iq = (iqset_csa - iq) * Ki_i

    umd = udmeas - iq * xlf + Kp_i * (idset_csa - id) + e_id
    umq = uqmeas + id * xlf + Kp_i * (iqset_csa - iq) + e_iq

    #Coupling with DC voltage
    um_abs = (udc + 1.0) * hypot(umd,umq)
    ϕm = atan(umq,umd)
    umds = um_abs * cos(ϕm)
    umqs = um_abs * sin(ϕm)

    #Back transformation to global reference systems
    um = umds + 1im * umqs
    um = um*(cos(θ)+1im*sin(θ))
    umd0 = real(um)
    umq0 = imag(um)

    idq = id + 1im*iq
    idq = idq*(cos(θ)+1im*sin(θ)) #-1im*
    id = real(idq) #* (Srated/Sbase)
    iq = imag(idq) #* (Srated/Sbase)
    I_abs = hypot(id,iq)
    #Voltage equations for filter
    u0d =  umd0 - rf * id + xlf * iq
    u0q =  umq0 - rf * iq - xlf * id
    u0 = u0d + 1im * u0q

    du = u - u0 #algebraic constraint

    #di_abs = i_abs - I_abs

    dx_uabs = IfElse.ifelse(iset_abs >= imax_csa  && p_red > 0,0.0,Ki_uset * Δuabs)
    #DC current control
    plim = idset_csa * udmeas + iqset_csa * uqmeas
    pmax = IfElse.ifelse(plim > p0set, p0set, IfElse.ifelse(plim < 0.0, 0.0, plim))
    dP = IfElse.ifelse(iset_abs >= imax_csa  && p_red > 0,p_red*(p0set -pmax), 0.0)

    dPdelta = 10.0*pi*(p_before_filter - pmeas - Pdelta)
    idc = -Kdc * udc + p0set - dP + (1.0+udc)*gdc + Pdelta
    didc0 = (idc - idc0) / Tdc

    idc0_lim = IfElse.ifelse(idc0 >= imax_dc, imax_dc, IfElse.ifelse(idc0 <= -imax_dc,-imax_dc,idc0))
    #DC circuit
    dudc = (idc0_lim - gdc * (1.0+udc) - ix) / cdc

    #VSM-based control
    #filtered power
    dPf = 10.0*pi*(pmeas - Pf)
    dw = (p0set - dP - Pf - w * Dp) / J
    dθ = w * 100 *pi

    #dPs = Ps - p_before_filter
    #dQs = Qs - q_before_filter
    #dP0 = P0 - pmeas
    #dQ0 = Q0 - qmeas
    dLVRT = LVRT_on
end

export VSM
