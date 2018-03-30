close all;

%plotend = find(timet>300, 1);
plotend = length(timet);


figure(15)
subplot(4,1,1); %veh demand speed
plot(timet(plotstart:plotend),demand_spd(plotstart:plotend));
ylabel('veh spd');
axis([-inf inf -inf inf]);

subplot(4,1,2); %eng speed
plot(timet(plotstart:plotend),W_engine(plotstart:plotend));
ylabel('spd');
axis([-inf inf -inf inf]);

subplot(4,1,3); %torque
plot(timet(plotstart:plotend),T_engine(plotstart:plotend));
ylabel('trq');
axis([-inf inf -inf inf]);

subplot(4,1,4); %command (0~1)
plot(timet(plotstart:plotend),endCmd(plotstart:plotend), '+-');
axis([-inf inf -0.01 1.2]);

figure(6); clf;
plot(W_engine(plotstart:20:plotend),T_engine(plotstart:20:plotend),'ms','LineWidth',2);
title('Engine operating points','fontWeight','bold','fontSize',12);
xlabel('Speed (RPM)','fontWeight','bold','fontSize',12);
ylabel('Torque (Nm)','fontWeight','bold','fontSize',12);
set(gca,'fontSize',12,'fontWeight','bold')
grid;


% %histogram
% figure(16)
% x = min(throttle):0.1:max(throttle);
% n_elements = hist(throttle,x);