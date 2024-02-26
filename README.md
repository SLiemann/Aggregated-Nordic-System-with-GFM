# Aggregated Nordic System (ANS) with Grid-Forming Converters

This repository contains the Simulink and PowerDynamics.jl models which are used in the paper:

S. Liemann, C. Rehtanz, "Voltage Stability Analysis of Grid-Forming Converters with Current Limitation", handed in for the PSCC 2024.

The models and code provided here can be used, shared and modified, but without any warranty.
In case you want to use these models for research, please have a look at the citation section below. 
The converter models where mainly taken from: https://github.com/ATayebi/GridFormingConverters

For further information or if you encounter some problems do not hesitate to contact us: sebastian.liemann (at) tu-dortmund.de

## Models

In the above paper an aggregated version of the Nordic Test System (see https://ieeexplore.ieee.org/document/9018172 for the original implementation) is derived for voltage stability analyses.
The idea is to have a grid model that captures the main voltage dynamics and stability properties, but is much more computionally efficient, e.g. for the acceleration of large-sampling studies. 
Since the analysis in the paper is divided into short-term/long-term voltage stability as well as EMT/phasor, this is also reflected by the provided files.

[NordicLTVS_v2.pdf](https://github.com/SLiemann/Aggregated-Nordic-System-with-GFM/files/14403078/NordicLTVS_v2.pdf)

### EMT implementation of the ANS

All files described here can be found in the folder ANS_EMT. It also contains instructions on how to start a simulation.

|  File | Description    |
|---|---|
|  **ANS_GFM_short_term.slx** | EMT Simulink implementation of the ANS for short-term voltage stability analyses.     |
|  **ANS_GFM_long_term.slx**  |  contains the same grid as for the shor-term analyses, but with modifications according to the detection of instability. |
| **init_ANS_GFM_short_term.m**  |  contains the code for the initialisation of the short-term model   |
|  **init_ANS_GFM_lomg_term.m** | contains the code for the initialisation of the long-term model (with some parameter adaptions)  |
|  **parallel_simulations_short_term.m** | contains the code for parallelising the simulations and deriving the short-term stability limit plots in the paper|
|  **parallel_simulations_long_term.m** | contains the code for parallelising the long-term simulations  |


Auxillary files:
|  File | Description    |
|---|---|
| **DetermineBoundary.m**| script to get the stability limit from the simulations|
| **next_ind.m**| internal function for DetermineBoundary.m|
| **calc_saturation.m**| function to calculate field current saturation for synchronous machines (not used here)|


### Phasor (RMS) implementation of the ANS

The folder 'ANS_RMS' contains the needed Julia-files for running a phasor simulation of the ANS written for the package PowerDynamics.jl. If you haven't worked with PowerDynamics.jl yet, please have a look at their Github page: https://github.com/JuliaEnergy/PowerDynamics.jl

The folder contains an overview of the files and instructions on how to start a simulation.

# Citation 

 In case the models and code provided here are used for research and publications, please acknowledge this by citing the following papers:

@ARTICLE{Liemann2024,
  author={Liemann, Sebastian and Rehtanz, Christian },
  journal={Power Systems Computation Conference (PSCC) 2024 (under review)}, 
  title={Voltage Stability Analysis of Grid-Forming Converters with Current Limitation}, 
  year={2024}}

@ARTICLE{Tayyebi2020,
  author={Tayyebi, Ali and Groß, Dominic and Anta, Adolfo and Kupzog, Friederich and Dörfler, Florian},
  journal={IEEE Journal of Emerging and Selected Topics in Power Electronics}, 
  title={Frequency Stability of Synchronous Machines and Grid-Forming Power Converters}, 
  year={2020},
  volume={8},
  number={2},
  pages={1004-1018},
  doi={10.1109/JESTPE.2020.2966524}}
