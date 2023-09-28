@DynamicNode ThreePhaseFaultContinouos(rfault,xfault,Tf,p_ind) begin
    MassMatrix(m_int =[true,true])
end  begin
    @assert rfault > 0.0 "Resistive part of fault impedance"
    @assert xfault > 0.0 "Inductive part of fault impedance"
    @assert Tf > 0.0 "Time constant of fault, e.g. of an electric arc"
end [[rf,drf],[xf,dxf]] begin#[[P,dP],[Q,dQ]]
    s = u * conj(i)
    rfault = p[p_ind[1]]
    xfault = p[p_ind[2]]
    
    drf = (rfault - rf) / Tf
    dxf = (xfault - xf) / Tf

    yfault = 1.0 / (rf + 1im * xf)

    du = conj(-yfault * u) * u - s 
end

export ThreePhaseFaultContinouos