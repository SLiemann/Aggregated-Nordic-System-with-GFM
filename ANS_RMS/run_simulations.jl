using Plots

include("include_custom_nodes_lines_utilities.jl")
include("grid/ANS_GFM_phasor_simulation.jl")

gfm_control  = 1 # 1 = droop, 2 = matching, 3 = dVOC, 4 = VSM0
secm = 1 # for phasor simulations, only SECM-1 is available, 0 = deactivated

# initialization of the system 
pg0,ic0 = Initialize_ANS(gfm_control,secm);

# fault impedances
rfault = 20.0
xfault = 1im*20.0
# simulation of the system
t_end = 5.0
@time pgsol, suc0,FRT0 = simulate_ANS(pg0,ic0,(0.0,t_end),(rfault + xfault)/Zbase);

#plotting the result
plot(pgsol,"bus1",:v)
plot!(pgsol,"bus2",:v)
plot!(pgsol,"bus3",:v)
plot!(pgsol,"bus_gfm",:v)
plot!(pgsol,"bus_load",:v)