#= Sebastian Liemann, ie3 TU Dortmund, based on F. Milano, Power System Modelling and Scripting, Springer Verlag, 2010
@doc doc"""
```Julia
SixOrderMarconatoMachine(Sbase,Srated,H, P, D, Ω, E_f, R_a,T_ds,T_qs,T_dss,T_qss,X_d,X_q,X_ds,X_qs,X_dss,X_qss,T_AA)
```

A node type that applies the 6th-order (sometimes also called 4th-order if ω and δ are not counted)
synchronous machine model which is implemented according to
F. Milano, "Power System Modelling and Scripting", Springer Verlag, 2010
The main equations are on page 331, cf. Table 15.2 Model 6.b

The model has the following internal dynamic variables:
* ``u`` is here an algebraic constraint
* ``e_ds`` transient magnetic state in d-axis
* ``e_qs`` transient magnetic state in q-axis
* ``e_dss`` subtransient magnetic state in d-axis
* ``e_qss`` subtransient magnetic state in q-axis
* ``ω`` representing the frequency of the rotator (not relative)
* ``θ`` representing the angle of the rotor with respect to the voltage angle ``ϕ``.

# Keyword Arguments
- `Sbase`: "Base apparent power of the grid in VA, should be >0"
- `Srated`: "Rated apperent power of the machine in VA, should be >0"
- `H`: shaft inertia constant, given in [s],
- `P`: active (real) power output, also called the mechanical torque applied to the shaft, given in [pu]
- `D`: damping coefficient, given in [s] (here D(ω-1.) is used)
- `Ω`: rated frequency of the power grid, often ``2π⋅50Hz``
- `E_f`: field voltage in [pu.]
- `R_a` : armature resistance, given in [pu]
- `T_ds` : short-circuit transient time constant of d-axis, given in [s]
- `T_qs` : short-circuit transient time constant of q-axis, given in [s]
- `T_dss`: short-circuit subtransient transient time constant of d-axis, given in [s]
- `T_qss`: short-circuit subtransient transient time constant of s-axis, given in [s]
- `X_d`: synchronous reactance of d-axis, given in [pu]
- `X_q`: synchronous reactance of q-axis, given in [pu]
- `X_ds`: transient reactance of d-axis, given in [pu]
- `X_qs`: transient reactance of d-axis, given in [pu]
- `X_dss`: subtransient reactance of d-axis, given in [pu]
- `X_qss`: subtransient reactance of d-axis, given in [pu]
- `T_AA` : additional leakage time constant in d-axis, given in [s]
- `X_l`: What is IT??? leakage reactance

"""
=#
@DynamicNode gentpjAVROEL(Sbase, Srated, H, P, D, Ω, R_a, T_d0s, T_q0s, T_d0ss, T_q0ss, X_d, X_q, X_ds, X_qs, X_dss, X_qss, X_l, S_10, S_12,K_is,V0,Ifdlim,L1,G1,Ta,Tb,G2,L2) begin
    MassMatrix(m_int =[true,true,true,true,true,true,false,false,true,true,true])
end begin
    @assert Sbase > 0 "Base apparent power of the grid in VA, should be >0"         "// ??"
    @assert Srated > 0 "Rated apperent power of the machine in VA, should be >0"    "// ??"
    @assert H > 0 "inertia (H) should be >0"                                        "// ??"
    @assert P >= 0 "Active power (P) should be >=0"                                 "// ??"
    @assert D >= 0 "damping (D) should be >=0"                                      "// ??"
    @assert R_a >= 0 "armature resistance (R_a) should be >=0"
    @assert X_d >= 0 "reactance of d-axis (X_d) should be >=0"
    @assert X_q >= 0 "reactance of q-axis (X_q) should be >=0"
    @assert X_ds > 0 "transient reactance of d-axis (X_ds) should be >0"
    @assert X_qs > 0 "transient reactance of q-axis (X_qs) should be >0"
    @assert X_dss > 0 "subtransient reactance of d-axis (X_dss) should be >0"
    @assert X_qss > 0 "subtransient reactance of q-axis (X_qss) should be >0"
    @assert X_l > 0 "NEU!"

    @assert T_d0s > 0 "time constant of d-axis (T_ds) should be >0"
    @assert T_q0s > 0 "time constant of q-axis (T_qs) should be >0"
    @assert T_d0ss > 0 "time constant of d-axis (T_dss) should be >0"
    @assert T_q0ss > 0 "time constant of q-axis (T_qss) should be >0"

    @assert S_10 >= 0 "saturation factor at 1.0 pu must be >= 0"
    @assert S_12 >= 0 "saturation factor at 1.2 pu must be >= 0"
    @assert K_is >= 0 "gentpj current depend saturation konstant"

    #AVR & OEL
    @assert V0 >= 0 "Reference Voltage of AVR"
    @assert Ifdlim >= 0 "Maximum field current"
    @assert L1 < 0 "Lower Limit of Timer-Integrator"
    @assert G1 >= 0 "Gain before Transient Gain Reduction (PDT1)"
    @assert Ta >= 0 "Nominator Time Constant of PDT1"
    @assert Tb >= 0 "Nominator Time Constant of PDT1"
    @assert G2 >= 0 "Gain of PT1 (Exciter)"
    @assert L2 >= 0 "Upper Limit of Anti-Windup Integrator inside of the PT1 (Exciter)"

    #auxillary variables

    Ag = (1.2 - sqrt(1.2*S_12/S_10))/(1 - sqrt(1.2*S_12/S_10))
    Bg = S_10 / (1-Ag)^2

    q = log(S_12/S_10)/log(1.2)
end [[θ,dθ],[ω, dω],[e_ds, de_ds],[e_qs, de_qs],[e_dss, de_dss],[e_qss, de_qss],[el,del],[ifd,difd],[timer,dtimer],[x1,dx1],[E_f,dE_f]] begin

    #current transformation to dq-system
    i_c = 1im*i*(cos(-θ)+1im*sin(-θ))/(Srated/Sbase)
    i_d = real(i_c)
    i_q = imag(i_c)

    #terminal voltage transformation to local dq-system
    v = 1im*u*(cos(-θ)+1im*sin(-θ))
    v_d_term = real(v)
    v_q_term = imag(v)

    #pe = real(u * conj(i))

    #start equation
    e_l = sqrt((v_q_term + (i_q * R_a) + (i_d * X_l))^2 + (v_d_term + (i_d * R_a) - (i_q * X_l))^2)
    del = el-e_l

    #saturation function
    #S_d = 0.0
    #S_q = 0.0

    #if e_l > Ag
        #S_d = Bg*(e_l+K_is*abs(i_c)-Ag)^2/(e_l+K_is*abs(i_c))
        #S_q = S_d*X_q/X_d
    #end
    S_d = S_10*e_l^q 
    S_q = S_d*X_q/X_d

    #further equations
    e_q2 = (e_qss - e_qs + i_d * ((X_ds - X_dss) / (1 + S_d))) * ((X_d - X_dss) / (X_ds - X_dss))
    e_q1 = e_qss  - e_q2 + i_d * ((X_d - X_dss) / (1 + S_d))

    e_d2 = (e_dss - e_ds - i_q * ((X_qs - X_qss) / (1 + S_q))) * ((X_q - X_qss) / (X_qs - X_qss))
    e_d1 = e_dss  - e_d2 - i_q * ((X_q - X_qss) / (1 + S_q))

    de_qs = (E_f - (1 + S_d) * e_q1) * 1 / T_d0s
    de_ds = - (1 + S_q) * e_d1 / T_q0s

    de_qss = - (1 + S_d) * ((X_ds - X_dss) / (X_d - X_dss)) * (e_q2 / T_d0ss)
    de_dss = - (1 + S_q) * ((X_qs - X_qss) / (X_q - X_qss)) * (e_d2 / T_q0ss)

    v_q_term1 = (e_q1 + e_q2)*(1+ω) - i_q * R_a - i_d * ((X_d - X_l) / (1 + S_d) + X_l)
    v_d_term1 = (e_d1 + e_d2)*(1+ω) - i_d * R_a + i_q * ((X_q - X_l) / (1 + S_q) + X_l)

    #retransformation
    v1  = v_d_term1 + 1im*v_q_term1
    du = u - -1im*v1*(cos(θ)+1im*sin(θ)) #algebraic constraint (Ausgang)

    te = ((v_q_term1 + R_a * i_q) * i_q + (v_d_term1 + R_a * i_d) * i_d) /(ω + 1.0) 

    dθ = Ω * 2*pi * ω
    dω = ((P - D * ω)/(1+ω) - te) / (2*H) #P turbine

    #Field current in a non-reciprocal system, otherwise would be: ifd = (E_f - T_d0s * de_qs) / (X_d - X_l)
    difd = ifd - (E_f - T_d0s * de_qs) #/ (X_d - X_l)  #algebraic constraint for output

    #AVR error
    V_error = V0 - abs(u)
    #OEL
    ifd_error = ifd - Ifdlim
    array_out  = IfElse.ifelse(ifd_error > 0.0,ifd_error,IfElse.ifelse(ifd_error >= -0.1,0.0,-1.0))
    dtimer =IfElse.ifelse(timer<=L1,IfElse.ifelse(array_out<0.0,0.0,array_out),array_out)
    switch_output = IfElse.ifelse(timer<0.0,V_error,-ifd_error)

    #AVR - Transient Gain Reducution & Exciter
    min_out = min(V_error,switch_output)
    dx1 = (min_out*G1 - x1) / Tb
    PDT1_out = x1 + dx1*Ta
    e = G2*(PDT1_out - E_f)

    lowlimit  = IfElse.ifelse(E_f<=0.0,IfElse.ifelse(e<0.0,true,false),false)
    highlimit = IfElse.ifelse(E_f>= L2,IfElse.ifelse(e>0.0,true,false),false)
    dE_f = IfElse.ifelse(lowlimit==true,0.0,IfElse.ifelse(highlimit==true,0.0,e))
end

export gentpjAVROEL
