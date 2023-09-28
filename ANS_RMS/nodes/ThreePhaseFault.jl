
@DynamicNode ThreePhaseFault(rfault, xfault,p_ind) begin
    MassMatrix()#m_int =[false,false]
end  begin
end [] begin
    s = u * conj(i)
    rfault = p[p_ind[1]]
    xfault = p[p_ind[2]]
    yfault = 1.0 / (rfault + 1im * xfault)
    
    du = conj(-yfault * u) * u - s 
end

export ThreePhaseFault