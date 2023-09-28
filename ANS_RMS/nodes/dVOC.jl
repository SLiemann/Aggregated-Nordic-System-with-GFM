#= Sebastian Liemann, ie3 TU Dortmund, based on F. Milano, Power System Modelling and Scripting, Springer Verlag, 2010
@doc doc"""
```Julia
GridFormingConverter(Sbase,Srated,p0set,u0set,Kp_droop,Kq_droop,ωf,xlf,rf,xcf,Kp_u,Ki_u,Kp_i,Ki_i)
```

A node type that applies..

The model has the following internal dynamic variables:
* ``u`` is here an algebraic constraint
* ``θ`` representing the angle of the rotor with respect to the voltage angle ``ϕ``.

# Keyword Arguments
- `Sbase`: "Base apparent power of the grid in VA, should be >0"
- `Srated`: "Rated apperent power of the machine in VA, should be >0"


"""
=#
@DynamicNode dVOC(Sbase,Srated,p0set,q0set,u0set,eta,alpha,Kdc,gdc,cdc,xlf,rf,xcf,Tdc,Kp_u,Ki_u,Kp_i,Ki_i,imax_csa,imax_dc,p_red,ϵ,LVRT_on,p_ind) begin
    MassMatrix(m_int =[true,true,true,true,true,true,true,true,true,true,true,false,false,true])#,false,false,false,false
end begin
    @assert Sbase > 0 "Base apparent power of the grid in VA, should be >0"
    @assert Srated > 0 "Rated apperent power of the machine in VA, should be >0"
    @assert p0set >= 0 "Set point for active power in p.u, should be >0"
    @assert q0set >= 0 "Set point for reactive power in p.u, should be >0"
    @assert u0set > 0 "Set point for voltage in p.u, should be >0"
    @assert eta >= 0 "dVOC gain parameter should be pi/Sb*V_m^2 in pu"
    @assert alpha >= 0 "dVOC gain parameter should be 0.1*V_m^2 in pu"
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
    @assert ϵ >= 0 "Small epsilon for controlled voltage to prevent singularity at zero voltage, should be around 1e-4"

end [[θ,dθ],[udc,dudc],[idc0,didc0],[vd,dvd],[e_ud,de_ud],[e_uq,de_uq],[e_id,de_id],[e_iq,de_iq],[Pf,dPf],[Qf,dQf],[Pdelta,dPdelta],[iset_abs,diset_abs],[w,dw],[LVRT,dLVRT]] begin #
    eta = p[p_ind[1]]
    alpha = p[p_ind[2]]
    Kdc = p[p_ind[3]]
    gdc = p[p_ind[4]]
    cdc = p[p_ind[5]]
    xlf = p[p_ind[6]]
    rf = p[p_ind[7]]
    xcf = p[p_ind[8]]
    Tdc = p[p_ind[9]]
    Kp_u = p[p_ind[10]]
    Ki_u = p[p_ind[11]]
    Kp_i = p[p_ind[12]]
    Ki_i = p[p_ind[13]]
    imax_csa = p[p_ind[14]]
    imax_dc = p[p_ind[15]]
    p_red = p[p_ind[16]]
    ϵ = p[p_ind[17]]
    LVRT_on = p[p_ind[18]]
    vd_e = vd + ϵ #to prevent singularity at zero voltage

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
    id = real(idq)
    iq = imag(idq)

    E = umeas + (rf + 1im*xlf) * idq
    p_before_filter = real(conj(idq) * E)
    q_before_filter = imag(conj(idq) * E)
    ix = p_before_filter

    #filtered power
    dPf = 10.0*pi*(pmeas - Pf)
    dQf = 10.0*pi*(qmeas - Qf)

    #dVOC voltage control
    v1 = eta * (q0set / u0set^2 - Qf / vd_e^2)
    v2 = ((u0set^2 - vd_e^2) * eta * alpha) / (u0set^2)
    dvd = (v1+v2) * vd_e

    #Building voltage reference
    udset = vd   # vd oder vd_e? eigentlich nur vd
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

    umd = udmeas - iq * xlf + Kp_i * (idset_csa - id) + e_id #+ id * rf
    umq = uqmeas + id * xlf + Kp_i * (iqset_csa - iq) + e_iq #+ iq * rf

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

    #Power Reduction in case of limited current
    plim = idset_csa * udmeas + iqset_csa * uqmeas
    pmax = IfElse.ifelse(plim > p0set, p0set, IfElse.ifelse(plim < 0.0, 0.0, plim))
    dP = IfElse.ifelse(iset_abs >= imax_csa && p_red > 0,p_red*(p0set -pmax), 0.0)

    #dVOC frequency /active power control
    dw = w - eta * ((p0set - dP) / u0set^2 - Pf / vd_e^2)
    dθ = w

    #DC current control
    dPdelta = 10.0*pi*(p_before_filter - pmeas - Pdelta)
    idc = -Kdc * udc + p0set - dP + (1.0+udc)*gdc + Pdelta
    didc0 = (idc - idc0) / Tdc

    idc0_lim = IfElse.ifelse(idc0 >= imax_dc, imax_dc, IfElse.ifelse(idc0 <= -imax_dc,-imax_dc,idc0))
    #DC circuit
    dudc = (idc0_lim - gdc * (1.0+udc) - ix) / cdc
    
    #dPs = Ps - p_before_filter
    #dQs = Qs - q_before_filter
    #dP0 = P0 - pmeas
    #dQ0 = Q0 - qmeas
    dLVRT = LVRT_on
end

export dVOC
