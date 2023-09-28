% Here the numbers of available local workers have to be set.
number_of_workers = 12;
parpool('local',number_of_workers);
model_name = gcs;
save_system(gcs);

% Start, resolution and end of impedance sampling for resistance and
% inductance
Rstart = 20;
dR = 1;
Rend = 0;
Xstart = 20;
dX = 1;
Xend = 0;


%% Parallel
% Load object in all workers
parfevalOnAll(@loadObject,0);

clear in;
i=1;
tic;
for R = Rstart:-dR:Rend
    for X = Xstart:-dX:Xend
        in(i) = Simulink.SimulationInput(model_name);
        if R ~= 0
            in(i) = in(i).setBlockParameter(model_name+"/Short-Circuit Impedance","Resistance",num2str(R));
        else
            in(i) = in(i).setBlockParameter(model_name+"/Short-Circuit Impedance","Resistance",num2str(1e-4));  
        end
        if X ~= 0
            in(i) = in(i).setBlockParameter(model_name+"/Short-Circuit Impedance","Inductance",num2str(X/100/pi));
        else
            in(i) = in(i).setBlockParameter(model_name+"/Short-Circuit Impedance","Inductance",num2str(1e-4/100/pi));
        end

        in(i) = in(i).setBlockParameter(model_name+"/GFM_control","Value",num2str(control));%floor((i+1)/2)
        in(i) = in(i).setBlockParameter(model_name+"/GFM Converter/Current Limitation/anti_windup","Value",num2str(awu));%mod(i,2)
        i = i+1;
    end
end
i=i-1;
display("Number of simulations: "+i)
out = parsim(in,'ShowSimulationManager','on','ShowProgress','on','TransferBaseWorkspaceVariables','on');

XR = [];
XR_tout = [];
i=1;

h_ind = 0;
l_ind = 0;

stop_string = model_name + "/STOP";

% get the index of stop-block state 
for k=1:out(1).xFinal.loggedStates.numElements
    if strcmp(out(1).xFinal.loggedStates{k}.BlockPath.getBlock(1),stop_string)
        stop_ind = k
    end
end

% Checking if simulation was stopped or not 
for R = Rstart/dR-Rend/dR+1:-1:1
    for X = Xstart/dX-Xend/dX+1:-1:1
        if out(i).xFinal.loggedStates{stop_ind}.Values.Data % if it has stopped, than it was unstable
            XR(R,X) = 0;
        else
            XR(R,X) = 1; % otherwise stable
        end
       XR_tout(R,X) = out(i).SimulationMetadata.ModelInfo.StopTime;
       i=i+1;
    end
end
[Xs, Ys] = meshgrid(Rend:dR:Rstart,Xend:dX:Xstart);

% Save results with a filename based on the scenario
if control ==1 
    tmp = "droop";
elseif control == 2
    tmp = "matching";
elseif control == 3
    tmp = "dVOC";
elseif control == 4
    tmp = "VSM";
else
    tmp = "false";
end

if sat_select == 1
    tmp_str = "_dprio_";
elseif sat_select == 2
    tmp_str = "_qprio_";
elseif sat_select == 3
    tmp_str = "_circular_";
else
    tmp_str ="_uknown_prio_";
end

filename = "Ts_"+Ts+tmp_str+"SECM_"+SECM+"_awu_"+awu+"_" + tmp + "_I" + share_i_load + "_R_" + Rstart + "_" + dR + "_" + Rend + "_X_" + Xstart + "_" + dX + "_" + Xend + ".mat"
save(filename,"Xs","Ys","XR","XR_tout");

% Determine stability limit and plot the results
[x,y] = DetermineBoundary(XR,Xs,Ys);
plot(x,y,Color="blue");
hold on
grid on
time = toc;
time/3600