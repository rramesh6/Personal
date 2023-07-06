function mean_psd_fig(psd_struct,key)

figure(9)
title('RCS02 Average Power Spectral Density (Key0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(Psd_struct.F_gait_0(:,1),10*log10(mean(Psd_struct.P_gait_0,2)),'b')
std_gait = std(Psd_struct.P_gait_0,[],2);
se_gait = std_gait / sqrt(size(Psd_struct.P_gait_0,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(Psd_struct.P_gait_0,2)-1);
lower_gait = 10*log10(mean(Psd_struct.P_gait_0,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(Psd_struct.P_gait_0,2) + t_gait*se_gait);
x_conf_gait = [Psd_struct.F_gait_0(:,1)', fliplr((Psd_struct.F_gait_0(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(Psd_struct.F_nongait_0(:,1),10*log10(mean(Psd_struct.P_nongait_0,2)),'r')
std_nongait = std(Psd_struct.P_nongait_0,[],2);
se_nongait = std_nongait / sqrt(size(Psd_struct.P_nongait_0,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(Psd_struct.P_nongait_0,2)-1);
lower_nongait = 10*log10(mean(Psd_struct.P_nongait_0,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(Psd_struct.P_nongait_0,2) + t_nongait*se_nongait);
x_conf_nongait = [Psd_struct.F_nongait_0(:,1)', fliplr((Psd_struct.F_nongait_0(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend('Gait','','Non-Gait')
grey = [128, 128, 128] / 255;
rectangle('Position',[1.5,-65,18.5,40],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
xlim([1 90])
ylim([-80 -25])
hold off 

figure(10)
hold on 
plot(Psd_struct.F_gait_0(:,1),10*log10(mean(Psd_struct.P_gait_0,2)),'b')
std_gait = std(Psd_struct.P_gait_0,[],2);
se_gait = std_gait / sqrt(size(Psd_struct.P_gait_0,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(Psd_struct.P_gait_0,2)-1);
lower_gait = 10*log10(mean(Psd_struct.P_gait_0,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(Psd_struct.P_gait_0,2) + t_gait*se_gait);
x_conf_gait = [Psd_struct.F_gait_0(:,1)', fliplr((Psd_struct.F_gait_0(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(Psd_struct.F_nongait_0(:,1),10*log10(mean(Psd_struct.P_nongait_0,2)),'r')
std_nongait = std(Psd_struct.P_nongait_0,[],2);
se_nongait = std_nongait / sqrt(size(Psd_struct.P_nongait_0,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(Psd_struct.P_nongait_0,2)-1);
lower_nongait = 10*log10(mean(Psd_struct.P_nongait_0,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(Psd_struct.P_nongait_0,2) + t_nongait*se_nongait);
x_conf_nongait = [Psd_struct.F_nongait_0(:,1)', fliplr((Psd_struct.F_nongait_0(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend("off")
xlim([1 20])
ylim([-65 -25])
hold off

