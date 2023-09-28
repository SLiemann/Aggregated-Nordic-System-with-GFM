#=
"""
```Julia
    StaticPowerTransformer(from,to,Sbase,Srated,uk,XR_ratio,i0,Pv0,tap_side,tap_pos,tap_inc)
```

Transformer based on typical equipment parameters

# Arguments

- `from` : start node
- `to` : end node
- `Sbase`: Base apprarent power in [W]
- `Srated`: rated apparent Power in [W]
- `uk`: short-circuit voltage in [%], e.g 15% => 0.15
- `XR_ratio`:X/R ratio of uk
- `i0`: no load current (core losses) in [%], e.g 6 % => 0.06
- `Pv0`: iron core losses in [W]
- `tap_side`: Side at which side the Transformer should be stepped, either LV or HV
- `tap_pos`: current tap position (integer), zero is neutral position
- `tap_inc`: voltag increase per tap in [%], e.g. 1 %

"""
=#
@Line StaticPowerTransformer(from,to,Sbase,Srated,uk,XR_ratio,i0,Pv0,tap_side,tap_pos,tap_inc) begin
    üLV    = 1.0
    üHV    = 1.0
    if tap_side == "LV"
        üLV = 1.0 / (1.0 + tap_pos * tap_inc / 100.0)
    elseif tap_side == "HV"
        üHV = 1.0 / (1.0 + tap_pos * tap_inc / 100.0)
    else
        error("Can not interprete tap_side (HV/LV): $tap_side")
    end

    #Calculatiing leakage reactance Xa and winding resistance Ra
    Ra = 0.
    Xa = 0.
    if XR_ratio == 0
        Ra = uk
        Xa = 0.
    elseif XR_ratio == Inf
        Ra = 0.
        Xa = uk
    else
        Ra = uk / sqrt(1 + XR_ratio^2)
        Xa = XR_ratio * Ra
    end
    Ya  = 1.0 / (0.5 * (Ra + 1im*Xa))    #it is assumed that losses are equally (0.5) distributed over both sides
    Ybs = Ya                             #Ybs should be changed, if losses are not equally distributed

    #Calculating magnetising reactance Xm and core resistance Rfe from iron losess
    Zm  = 1.0 / (i0 / 100.0) #no-load currents depends on complete magnetising impedance
    Rfe = Srated / Pv0
    Xm = Inf
    if i0 != 0
        Xm  = 1.0 / sqrt(1.0/Zm^2 - 1.0/Rfe^2)
    end
    Ym  = 1.0/Rfe + 1.0/(1im*Xm)

    Ybase = Sbase / Srated #this could be changed, if global base values are available
    Y     = 1.0 / (Ya + Ybs + Ym) ./ Ybase
    Y = Y.*PiModel(Ya*Ybs, Ya*Ym, Ybs*Ym,üHV,üLV)
    # If current is flowing away from the source, it is negative at the source.
    voltage_vector = [source_voltage,destination_voltage]
    current_vector = Y * voltage_vector
end

export StaticPowerTransformer
