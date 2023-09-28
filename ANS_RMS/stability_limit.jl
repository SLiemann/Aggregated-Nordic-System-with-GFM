using Plots

include("include_custom_nodes_lines_utilities.jl")
include("grid/ANS_GFM_phasor_simulation.jl")

gfm_control  = 1 # 1 = droop, 2 = matching, 3 = dVOC, 4 = VSM0
secm = 1 # for phasor simulations, only SECM-1 is available, 0 = deactivated

# Exmaple of how to sample short-circuit impedance and determine stability boundary 
Rsampling = 15:-1:0.0
Xsampling = 15:-1:0.0

# running the simulations (sequentiel now but could be parallised in the future)
# due to the fast execution, parallelisation is not needed now
@time xr, xrt = CalcXRMap(Rsampling,Xsampling,gfm_control,secm);
# determine the stability limit
x,y = DetermineBoundary(xr,Rsampling,Xsampling)

# plotting the result
plot(x,y)

# for a 3d version:
# surface(Rsampling,Xsampling,xr)