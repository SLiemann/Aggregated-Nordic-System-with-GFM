% Here the numbers of available local workers have to be set.
number_of_workers = 12;
parpool('local',number_of_workers);
model_name = gcs;
save_system(gcs);

%% Parallel
% Load object in all workers
parfevalOnAll(@loadObject,0);

% selction, which GFM controls shall be simulated
gfm_sim = 1:1; 
% selction, which SECM controls shall be simulated
secm_sim = 1:4;

i=1;
for control= gfm_sim
    for  secm = secm_sim
        in(i) = Simulink.SimulationInput(model_name);
        in(i) = in(i).setBlockParameter(model_name+"/GFM_control",'Value',num2str(control));
        in(i) = in(i).setBlockParameter(model_name+"/GFM Converter/secm_choice",'Value',num2str(secm));
        i = i+1;
    end
end
i=i-1;
display("Anzahl an Simulation: "+i)
out = parsim(in,'ShowSimulationManager','on','ShowProgress','on','TransferBaseWorkspaceVariables','on');
toc

i = 1;
for control= gfm_sim
    for  secm = secm_sim
        gfm = "";
        if control == 1
            gfm = "droop";
        elseif  control == 2
            gfm = "matching";
        elseif  control == 3
            gfm = "dVOC";    
        elseif  control == 4
            gfm = "VSM";
        else
            gfm = "XXX";
        end

        Vload = out(i).Vload;

        str_save = gfm+"_secm"+num2str(secm)+"_Rf"+num2str(Rf)+"_Xf"+num2str(int64(Lf*100*pi))+".mat";
        save("Long_term_"+str_save,"Vload");
        i = i+1;

        plot(Vload(:,1),Vload(:,2))
        hold on
        grid on
    end
end