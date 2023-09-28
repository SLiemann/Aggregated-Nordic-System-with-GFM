clear;

% Sample time
Ts = 2e-6; % CHANGE to short-term to speed up simulation

% GFM control 
control = 3;  % 1=droop, 2=matching, 3=dVOC, 4 =VSM

% anti-windup
awu = 1; % anti-winup, 1 = activated, 0 = deactivated

% current axis prioritisation
sat_select = 3; %1= d-prio, 2=q-prio, 3=circular

% Stability-enhancing control method 
SECM = 3; % 1= SECM-1,  2 = SECM-2, 3 = SECM-3, 4 = SECM-4, 5 = no SECM

%parameters of SECMs
Kpl = 5.0;
idppu = 0.95; %CHANGE to short-term voltage stability 
gamma = 2.3;

% Share of constant current and load (only works now for share_i_load > 0)
share_i_load = 1.0; % 1.0 = 100% constant current, 0.7 = 70% constant current and 30% pure resistance

% PLL parameters of load
Kp_pll = 92;
Ki_pll = 4255.3;

% Base values of the grid
S_b = 8000e6;
f_b = 50;
w_b = 2*pi*f_b;

% Parameters of the original Nordic Test system to determine short-circuit
% contribution of bus 4031 (taken from a PowerFactory version of the grid)
Skss = 9242e6;
RX = 0.08779356;
cf = 1.0;
Egrid_tmp = 1.054080675694902*400e3;
phase_tmp = 18.842890293505274;
R1 = RX*cf/sqrt(1+RX^2)*(400e3)^2/Skss;
L1 = cf/sqrt(1+RX^2)*(400e3)^2/Skss/(100*pi);
Z1 = (R1 + 1i*L1*100*pi);

% Init fault resistance and duration
T_on = 0.1;
T_off = T_on + 0.1;
Rf = 1e6;       % CHANGE to short-term voltage stability: no fault during simulation
Lf = 1e6/100/pi; % CHANGE to short-term voltage stability: no fault during simulation

% Init of some measurement variables
angle_load = 0;
init_v1 = 1.0;
init_v2 = 1.0;
init_v3 = 1.0;
init_vload = 1.0;

% init variables for synchronous generator 
% to_simulink = calc_saturation(); 
% Ve = 1;
% Pm = 1;
% sm_init = zeros(7,1)';
% idq0_init = [0 0 0];
% E_l = 0;
% delta0= 0;
% v_d = 0;
% v_q = 0;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters of the converter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base power 
S_bc= 5142e6; % CHANGE to short-term voltage stability
% active power reference 
ps = 4440e6/S_bc; 
% reactive power reference 
qs= 0.0;  %will be adopted after load flow calculattion

%% Converter params (mainly taken from Tayyebi et al.)
% The main differences to the original system is that the converter's rated
% power is increased to 5300 MVA as well as its terminal voltage to 15 kV.

S_single = 500e3;
n = S_bc/S_single; %n=200 %n= 1 equal to 100e6/200
V1_rms = 15e3;
V_bc = V1_rms;
I_bc   = S_bc / (V_bc*sqrt(3));
I_b_LV = S_b  / (V_bc*sqrt(3));
V_m=sqrt(2/3)*V_bc;
Vdc_n=3*V_m;

% adaption of the filter impedances due to the new voltage level and power rating

% Orignal filter parameters
C_dc_or= 0.008*200;
R_f_or = 0.001/200;
L_f_or =(1/200)*200*10^-6;
C_f_or =200*300*10^-6;
Vdc_n_or = 3*sqrt(2/3)*1000;
R_dc_or =(Vdc_n_or/(0.05*(100e6)/Vdc_n_or));

% Original impedance values
Xcdc_or = 1/(100*pi*C_dc_or);
Xlf_or = 100*pi*L_f_or;
Xcf_or = 1/(100*pi*C_f_or);

% Original base impedances
Zpu_or = 1000^2/100e6;
Zpu_dc_or = Vdc_n_or^2/100e6;

% Original pu values 
Xcdc_pu_or = Xcdc_or/Zpu_dc_or;
Xcf_pu_or = Xcf_or/Zpu_or;
Xlf_pu_or = Xlf_or/Zpu_or;
Rf_pu_or = R_f_or/Zpu_or;
Rdc_pu_or = R_dc_or/Zpu_dc_or;

% new based impedances
Zbase_new = V1_rms^2/S_bc;
Zbase_dc_new = (3*sqrt(2/3)*V1_rms)^2/S_bc;

% new impedance values
C_f = 1/(Xcf_pu_or*Zbase_new*100*pi);
R_f = Rf_pu_or*Zbase_new;
L_f = Xlf_pu_or*Zbase_new/100/pi;
C_dc = 1/(Xcdc_pu_or*Zbase_dc_new*100*pi);
R_dc = Rdc_pu_or*Zbase_dc_new;

% Filter time constant
w_f=2*pi*5;
T_en=-0.5;%Enabling the DC source saturation after the initial synchronization

% base impedances based on converter power and voltage
Z_bc=(V_bc^2)/S_b;
L_bc=Z_bc/w_b;
C_bc=1/(w_b*Z_bc);

% filter impedances based on converter base impedance
R_f_pu=R_f/Z_bc;
L_f_pu=L_f/L_bc;
C_f_pu=C_f/C_bc;

%% Control parameters  (mainly taken from Tayyebi et al.)

%DC source and governor-turbine time constants
tau_dc=0.05;tau_g=5;

% grid-forming converter control----------------
I_b_dc=S_bc/Vdc_n;
i_loss_dc=Vdc_n/R_dc;
i_ul=1.15*(S_bc/Vdc_n)+i_loss_dc;%dc source saturation limits
i_ll=-1.15*(S_bc/Vdc_n)-i_loss_dc;%dc source saturation limits

% DC voltage control--------------------------------
eta_1= w_b/Vdc_n;
m_p=(2*pi*0.5)/(S_bc);
k_dc=eta_1/(Vdc_n*m_p);
K_p=(1/Vdc_n);
K_r=1/R_dc;

% AC voltage control--------------------------------
ki_v_ac=2*0.25;
kp_v_ac=0.001;

% Voltage loop----------------------------------------
%n = S_bc/S_single;
S1 = 100e6;
U1 = 1e3;
Zbase = U1^2/S1;
Zb = (15e3)^2/S_bc;
n = 1/Zb;

% Voltage control loop
Kp_v =0.52*n;
Ki_v =(n)*1.161022;
Kff_v = 1;
Ti_v = Kp_v/Ki_v; 

% Current current loop
Kp_i =0.738891/n;
Ki_i =(1/n)*1.19; %
Kff_i = 1;
Ti_i = Kp_i / Ki_i;

%dVOC and droop gains
m_p=(2*pi*0.5)/(S_bc);
eta =  m_p*V_m^2; %compute eta from m_p
alpha = 1e-1*V_m^2;%;
epsi = 1e-4;

% VSM control
D_p=(1/(m_p*w_b));
tau_f=0.02;
J=D_p*tau_f;

% Current Saturation Algorithm
I_max_sat_pu = 1.0 * I_bc *sqrt(2);

%% LOAD FLOW

model2update = bdroot(gcs);

% finde some blocks
PL = find_system(model2update,"IncludeCommented","on",'LookUnderMasks','all','Name','Pload - Load Flow');
IL = find_system(model2update,"IncludeCommented","on",'Name','Constant Current Load (EMT)');
GFM = find_system(model2update,"IncludeCommented","on",'LookUnderMasks','all','Name','GFM Converter');
LFAC = find_system(model2update,"IncludeCommented","on",'LookUnderMasks','all','Name','GFM AC load flow');

% disable GFM block and activating AC voltage source
set_param(GFM{1},'Commented','on');
set_param(LFAC{1},'Commented','off','Frequency','50','PhaseAngle','0','Voltage','V1_rms','Pref','S_bc*ps','Qmin','-sqrt(S_bc^2-(S_bc*ps)^2)+V1_rms^2/(1/(C_f*100*pi))','Qmax','sqrt(S_bc^2-(S_bc*ps)^2)+V1_rms^2/(1/(C_f*100*pi))');

% activating a load with constant current for load flow calculation
set_param(PL{1},'Commented','off');
set_param(PL{1},'NominalVoltage',num2str(20000),'LoadType','Constant I');

% solve load flow -> have a look at the load flow parameter in the powergui
% block
LF = power_loadflow('-v2',model2update,'solve');

% activating and deactivating back
set_param(PL{1},'Commented','on');
set_param(GFM{1},'Commented','off');
set_param(LFAC{1},'Commented','on');

%%Print Load Flow
disp('#########################');
disp('Load flow result:');
for i =1:length(LF.bus)
    display(LF.bus(i).ID+": "+num2str(abs(LF.bus(i).Vbus)) + " pu, angle: "+num2str(180/pi*angle(LF.bus(i).Vbus))+"°")
end
disp('#########################');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisation of the converter and grid model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Init Load
ind_l = find(strcmp({LF.bus.ID},'v_load')); 
angle_load = angle(LF.bus(ind_l).Vbus)*180/pi;

% Init Measurement
ind_g = find(strcmp({LF.bus.ID},'v_2')); 
init_v2 = abs(LF.bus(ind_g).Vbus)/sqrt(2);
ind_sg = find(strcmp({LF.bus.ID},'v_3')); 
init_v3 = abs(LF.bus(ind_sg).Vbus)/sqrt(2);
Uinit_last = abs(LF.bus(ind_l).Vbus)/sqrt(2);

%% Init GFM converter
ind_gfm = find(strcmp({LF.bus.ID},'v_GFM'));
ind_gfm2 = find(strcmp({LF.vsrc.busID},'v_GFM'));
V_LF = LF.bus(ind_gfm).Vbus;
V_LF_mag = abs(LF.bus(ind_gfm).Vbus);
Vref = V_LF_mag*V_m;
V_LF_angle = angle(LF.bus(ind_gfm).Vbus)*180/pi;
P_LF = real(LF.bus(ind_gfm).Sbus);
P_LF_si = P_LF*S_b;
Q_LF = imag(LF.bus(ind_gfm).Sbus);
qs = Q_LF*S_b/S_bc;
Q_LF_si = Q_LF*S_b;
S_LF = LF.bus(ind_gfm).Sbus;
I_LF = LF.vsrc(ind_gfm2).I;
I_LF_mag = abs(LF.vsrc(ind_gfm2).I);

% Current before the filter
I_C_f = 1i*C_f_pu*V_LF;
I_LF_VSC = I_LF + I_C_f;

% Converter terminal voltage
V_LF_RL = I_LF_VSC*(1i*L_f_pu+R_f_pu);
V_LF_VSC = V_LF_RL + V_LF;

% power before and after the filter
S_vor = V_LF_VSC * conj(I_LF_VSC);
P_vor = real(S_vor)*S_b;
P_aft = P_LF*S_b;
dP = P_vor - P_aft;

% Initialize DC bus and measured power
idc = ps*S_bc/Vdc_n + Vdc_n/R_dc + dP/Vdc_n;
[A_tau,B_tau,C_tau,D_tau] = tf2ss([1],[tau_dc 1]);
init_tau = -inv(A_tau)*B_tau*idc;

[A_pm,B_pm,C_pm,D_pm] = tf2ss([w_f],[1 w_f]);
init_dP = -inv(A_pm)*B_pm*dP;

init_pm = -inv(A_pm)*B_pm*P_aft;

% Init of voltage and current measurements at the filter
Vmag_init = abs(V_LF)*V_bc*sqrt(2/3);
Vangle_init = angle(V_LF)*180/pi;  
V_init_a = Vmag_init*sin(Vangle_init*pi/180);
V_init_b = Vmag_init*sin(Vangle_init*pi/180-2*pi/3);
V_init_c = Vmag_init*sin(Vangle_init*pi/180+2*pi/3);
V_init = [V_init_a, V_init_b, V_init_c]; %at the filter capacitance

Imag_init = abs(I_LF_VSC)*sqrt(2)*I_b_LV;
Iangle_init = angle(I_LF_VSC)*180/pi;%-angle(V_LF)*180/pi;
I_init_a = Imag_init*sin(Iangle_init*pi/180);
I_init_b = Imag_init*sin(Iangle_init*pi/180-2*pi/3);
I_init_c = Imag_init*sin(Iangle_init*pi/180+2*pi/3);
I_init = [I_init_a, I_init_b, I_init_c]; %converters current

I0mag_init = abs(I_LF)*sqrt(2)*I_b_LV;
I0angle_init = angle(I_LF)*180/pi;
I0_init_a = I0mag_init*sin(I0angle_init*pi/180);
I0_init_b = I0mag_init*sin(I0angle_init*pi/180-2*pi/3);
I0_init_c = I0mag_init*sin(I0angle_init*pi/180+2*pi/3);
I0_init = [I0_init_a, I0_init_b, I0_init_c]; % current to grid after filter

% Initialize voltage source of GFM average model
Umag_init = abs(V_LF_VSC)*V_bc*sqrt(2/3);
Uangle_init = angle(V_LF_VSC)*180/pi; 
Umag_init_a=Umag_init*sin(Uangle_init*pi/180);
Umag_init_b=Umag_init*sin(Uangle_init*pi/180-2*pi/3);
Umag_init_c=Umag_init*sin(Uangle_init*pi/180+2*pi/3);
U_init=[Umag_init_a, Umag_init_b, Umag_init_c]; % converters terminal voltage

% Initialize voltage reference values
V_d_int = abs(V_LF)*V_bc*sqrt(2/3);
V_q_int = 0;

% Transformation of measurements into local dq-reference frame of converter
angleV_LF = Vangle_init/180*pi;
U_reIM  = [real(V_LF_VSC);imag(V_LF_VSC)].*V_bc*sqrt(2/3); %V_LF_VSC
Udq_int = [cos(angleV_LF), sin(angleV_LF) ;...
          -sin(angleV_LF), cos(angleV_LF)]*U_reIM;

U_d_int = Udq_int(1);
U_q_int = Udq_int(2);

I_reIM = [real(I_LF_VSC);imag(I_LF_VSC)].*I_b_LV*sqrt(2);
Idq_int = [cos(angleV_LF), sin(angleV_LF) ;...
          -sin(angleV_LF), cos(angleV_LF)]*I_reIM;

I_d_int = Idq_int(1);
I_q_int = Idq_int(2);

I0_reIM = [real(I_LF);imag(I_LF)].*I_b_LV*sqrt(2);
I0dq_int = [cos(angleV_LF), sin(angleV_LF) ;...
          -sin(angleV_LF), cos(angleV_LF)]*I0_reIM;
I0_d_int = I0dq_int(1);
I0_q_int = I0dq_int(2);

% Initialize PI control states

% Voltage control loop
V_d_int_init = (I_d_int + V_q_int*C_f*w_b - I0_d_int);
V_q_int_init = (I_q_int - V_d_int*C_f*w_b - I0_q_int);

% Current control loop
I_d_int_init = (U_d_int + I_q_int*L_f*w_b - V_d_int - I_d_int*R_f*0);
I_q_int_init = (U_q_int - I_d_int*L_f*w_b - V_q_int - I_q_int*R_f*0);
