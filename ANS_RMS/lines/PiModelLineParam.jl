#=
@doc """
```Julia
    PiModelLineParam(from, to, y, y_shunt_km, y_shunt_mk)
```
A line modelled according to the PI-Model.

See also the Chapter 2 in
  Göran Andersson, _Power System Analysis_, Lecture 227-0526-00, ITET ETH Zurich, 2012

# Arguments
- `from` : node `k`
- `to` : node `m`
- `y`: admittance of line between `k` and `m` --> PARAMETER
- `y_shunt_km`: shunt admittance at the end connected to node `k`
- `y_shunt_mk`: shunt admittance at the end connected to node `m`
- `t_km`: transformer ratio at the end connected to node `k`
- `t_mk`: transformer ratio at the end connected to node `m`

# Assumptions:
- the line admittance is symmetric
"""
=#
@Line PiModelLineParam(from, to, y, y_shunt_km, y_shunt_mk,p_ind) begin
    Y = PiModel(y, y_shunt_km, y_shunt_mk, 1, 1)
end begin
    active = p[p_ind]
    voltage_vector = [source_voltage,destination_voltage]
    current_vector = Y * voltage_vector
end

export PiModelLineParam
