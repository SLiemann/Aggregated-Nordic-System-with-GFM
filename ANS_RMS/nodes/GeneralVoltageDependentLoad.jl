@DynamicNode GeneralVoltageDependentLoad(P, Q, U, Ap, Bp, Aq, Bq) begin
    MassMatrix(m_int =[false,false])
end  begin
    @assert 0 <= Ap <= 1
    @assert 0 <= Bp <= 1
    @assert 0 <= Aq <= 1
    @assert 0 <= Bq <= 1
    @assert isreal(U)
end [[P0,dp],[Q0,dq]] begin
    s = u * conj(i)
    u_rel = abs(u) / U
    Pv = P * (Ap * u_rel^2 + Bp * u_rel + 1.0 - Ap - Bp)
    Qv = Q * (Aq * u_rel^2 + Bq * u_rel + 1.0 - Aq - Bq)

    du = complex(Pv, Qv) - s

    dp = P0 - Pv
    dq = Q0 - Qv
end

export GeneralVoltageDependentLoad
