% This is the new initialization file. Made on Feb.25.2005 by Jinming 
% For rule based control

clear all;			% Initialize workspace
% close all;        % Close graphic windows

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load initialization data file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prius_sim_data;
disp('Data loaded sucessfully!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ess_init_soc=0.6;   %initial battery state of charge (1.0 = 100% charge)
%flag_char_init=0;   %charging flag
%SOC_low_limit = 0.2; %%Jim%%
%SOC_high_limit = 0.9; %%Jim%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% load driving cycle %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drivingcycle = 1; %1:US06 acceleration %2:EPA UDDS cycle %3:EPA Highway cycle
switch (drivingcycle)
    case 1
        %load US06 cycle (compare the results in paper SAE2001-01-1335
        load CYC_US06.mat; % Load driving cycle (US06 cycle)
        cyc_mph=cyc_mph(133:163,:);
%         cyc_mph=cyc_mph*2/3;
%         cyc_mph=cyc_mph(133:500,:);%(133:163,:);
        tt0=cyc_mph(1,1);
        cyc_mph(:,1)=cyc_mph(:,1)-tt0+1;
        time_final=length(cyc_mph(:,2))-1;
        
    case 2
        %load EPA cycle (compare the results of fuel comsuption
        load CYC_UDDS.mat; % Load driving cycle (EPA urban cycle)
        %cyc_mph=cyc_mph(190:400,:);
        %tt0=cyc_mph(1,1);
        %cyc_mph(:,1)=cyc_mph(:,1)-tt0+1;
        %CYC_HWFET; % Load driving cycle (EPA highway cycle)
        time_final = 1*length(cyc_mph(:,2));
        
    case 3
        %load EPA cycle (compare the results of fuel comsuption
        load CYC_HWFET.mat; % Load driving cycle (EPA highway cycle)
        %cyc_mph=cyc_mph(190:400,:);
        %tt0=cyc_mph(1,1);
        %cyc_mph(:,1)=cyc_mph(:,1)-tt0+1;
        %CYC_HWFET; % Load driving cycle (EPA highway cycle)
        time_final = 1*length(cyc_mph(:,2));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% All Control related parameters  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%made by Jinming Liu Mar.26.2004
%updated by Jinming Liu Oct.31.2004
%updated by Jinming Liu Feb.27.2005

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% driver controller parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% keep unchanged (Note: Jinming Liu)
Kf_c = 1/10;
Kp_c = 30;
Ti_c = 60;
Tt_c = 65;
v_max_c = 100;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGINE CONTROL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lookup map for calculate maxmum engine driving power
eng_ctrl_spd=[104.7 110 115.2 120.4 125.7 130.9 136.1 141.4 ...
            146.6 151.8 157.1 162.3 167.6 172.8 178 183.3 188.5 193.7 199 ...
            204.2 209.4 214.7 219.9 225.1 230.4 235.6 240.9 246.1 251.3 256.6 ...
            261.8 267 272.3 277.5 282.7 288 293.2 298.5 303.7 308.9 314.2 ...
            319.4 324.6 329.9 335.1 340.3 345.6 350.8 356 361.3 366.5 371.8 ...
            377 382.2 387.5 392.7 397.9 403.2 408.4 413.6 418.9];
eng_ctrl_max_trq=[77.33 78.2 79.07 79.94 80.81 81.68 82.35 82.85 83.35 83.85 ...
            84.35 84.83 85.2 85.58 85.95 86.32 86.7 87.13 87.6 88.08 88.55 ...
            89.02 89.47 89.79 90.11 90.43 90.76 91.08 91.4 91.73 92.05 92.38 ...
            92.7 93.03 93.35 93.67 93.99 94.32 94.64 94.96 95.29 95.61 95.93 ...
            96.26 96.58 96.9 97.22 97.55 97.87 98.19 98.52 98.84 99.17 99.49 ...
            99.81 100.2 100.5 100.9 101.3 101.7 102];
%     eng_ctrl_spd=[1000 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 4000]*2*pi/60; 
% lbft2Nm=1.356; %conversion from lbft to Nm
% eng_ctrl_max_trq=[57 60.5 62.5 64 65.9 67.2 68.5 69.8 71.1 72.4 73.7 75.2]*lbft2Nm;

%base on engine optimal speed map in Advisor
%proved by later engine operating discovery [Jinming]
eng_spd_opt=eng_ctrl_spd;
eng_pwr_opt=eng_spd_opt.*eng_ctrl_max_trq*0.9; % to smooth the control curve, we apply 0.9 throttle, close to the optimized curve
eng_pwr_max=40000; %engine max power (W)

eng_idle_spd=1000*pi/30;  % (rad/s), engine's idle speed
max_eng_spd=4000*pi/30; %rad/s
%eng_off_time=5;  %(guess)% (sec), before lasting this time, engine cant be totally shut off. needs to be set at engine's idle speed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERATOR CONTROL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_gen_spd=6500*pi/30; %rad/s
min_gen_spd=-6500*pi/30; %rad/s
%Generator Speed PI Control (base on PSAT)
gc_kp_on= 0.9;%*0.1;        % Proportional Factor Controller gains  N*m/(rad/s) 
gc_ki_on=0.005;       % Integration Factor          N*m/(rad/s)/sec       



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BATTERY CONTROL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SOC boundaries
high_soc=0.75;  % highest desired battery state of charge
low_soc=0.50;   % below this value, the engine must be on and charge
stop_soc=0.45;  % lowest desired battery state of charge, avoid reaching this point
regstop_soc=0.8;  % reach this point, regenerative brake will stop
soc_control=0.55;   % for charging mode control
target_soc=0.6; % try to maintain the soc 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rule Base Control Strategy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%in ADVISOR
%eng_launch_spd=45*1000/3600; % 9/6/00 from recent files looks like 28 mph (45 kph) is max speed with which engine can be off.
w_engine_on = 30*1600/3600/R_tire; % (rad/s) (30 mph Guess)
P_ev_mode = 12000; %(w) (Guess)
P_eng_mode = 40000; %(w)
%P_engbat_mode = 55000; %(w)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation and Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
simulation_case=1; %1:normal simulation 2:fuel consumption with soc correction
switch simulation_case
    case 1
        time_step = 0.02;
        sim('prius_rulebased.mdl');
        display('Simulation completed!');
        prius_sim_plot;
        
    case 2
        time_step = 0.02;
        soc_init_index = [0.5 0.6 0.7];
        for simrun=1:length(soc_init_index)
            ess_init_soc=soc_init_index(simrun);
            sim('prius_rulebased.mdl');
            display(['Simulation ',num2str(simrun),' completed!']);
            mpg(simrun)=distance_in_mile(2)/fuel_consum_in_g(2)*1000*3.8*0.75;

            figure;
            plot(timet,demand_spd,...
                'r:',timet,actual_spd,...
                'b-',timet,actual_spd,'g-.','LineWidth',2);
            set(gca,'fontSize',12,'fontWeight','bold')
            xlabel('time (sec)','fontWeight','bold','fontSize',12);
            title(['Main Results:  Total travel ',num2str(distance_in_mile(2)),...
                    ' Miles;  Fuel ',num2str(mpg(simrun)),' MPG.'],'fontWeight','bold','fontSize',12);
            hold on;
            [AX,H1,H2] = plotyy(timet,actual_spd,...
                timet,output_soc,'plot');
            set(get(AX(1),'Ylabel'),'String','Vehicle Speed (MPH)','fontWeight','bold','fontSize',12)
            set(get(AX(2),'Ylabel'),'String','State of Charge','fontWeight','bold','fontSize',12)
            set(H2,'LineStyle','-.')
            set(H2,'LineWidth',2)
            set(AX(2),'fontSize',12,'fontWeight','bold')
            % set(AX(2),'YLim',[0.45 0.9])
            set(gca,'fontSize',12,'fontWeight','bold')
            legend('Reference Speed','Actual Speed','SOC')
            grid;
            
            soc_dif(simrun)=output_soc(length(output_soc))-ess_init_soc;
        end
        mpg_final=interp1(soc_dif,mpg,0);
        figure;
        plot(soc_dif,mpg,'b-',soc_dif,mpg,'r*','LineWidth',2);
        set(gca,'fontSize',12,'fontWeight','bold')
        xlabel('difference of soc (final-initial)','fontSize',12,'fontWeight','bold');
        ylabel('fuel consumption (MPG)','fontSize',12,'fontWeight','bold');
        title(['fuel consumption after soc correction: ',num2str(mpg_final),' MPG'],'fontSize',12,'fontWeight','bold');
end