function mean_psd_fig(psd_struct_in,key,box_lower,box_upper)

psd_struct = struct();
psd_struct.P_gait = psd_struct_in.(['P_gait_' num2str(key)]);
psd_struct.F_gait = psd_struct_in.(['F_gait_' num2str(key)]);
psd_struct.P_nongait = psd_struct_in.(['P_nongait_' num2str(key)]);
psd_struct.F_nongait = psd_struct_in.(['F_nongait_' num2str(key)]);

%figure()
title(['RCS02 Average Power Spectral Density (Key ' num2str(key) ')'])
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
for i = 1:size(psd_struct.P_gait,2)
    plot(psd_struct.F_gait(:,1),10*log10(psd_struct.P_gait(:,i)),"Color",[0 0 1 0.002],"LineWidth",0.0001)
end
g = plot(psd_struct.F_gait(:,1),10*log10(mean(psd_struct.P_gait,2)),'b','LineWidth',2);
std_gait = std(psd_struct.P_gait,[],2);
% se_gait = std_gait / sqrt(size(psd_struct.P_gait,2));
% alpha = 0.05;
% t_gait = tinv(1 - alpha / 2, size(psd_struct.P_gait,2)-1);
% lower_gait = 10*log10(mean(psd_struct.P_gait,2) - t_gait*se_gait);
% upper_gait = 10*log10(mean(psd_struct.P_gait,2) + t_gait*se_gait);
% x_conf_gait = [psd_struct.F_gait(:,1)', fliplr((psd_struct.F_gait(:,1))')];
% y_conf_gait = [lower_gait', fliplr((upper_gait)')];
% fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
for i = 1:size(psd_struct.P_nongait,2)
    plot(psd_struct.F_gait(:,1),10*log10(psd_struct.P_nongait(:,i)),"Color",[1 0 0 0.002],"LineWidth",0.0001)
end
ng = plot(psd_struct.F_nongait(:,1),10*log10(mean(psd_struct.P_nongait,2)),'r','LineWidth',2);
% std_nongait = std(psd_struct.P_nongait,[],2);
% se_nongait = std_nongait / sqrt(size(psd_struct.P_nongait,2));
% alpha = 0.05;
% t_nongait = tinv(1 - alpha / 2, size(psd_struct.P_nongait,2)-1);
% lower_nongait = 10*log10(mean(psd_struct.P_nongait,2) - t_nongait*se_nongait);
% upper_nongait = 10*log10(mean(psd_struct.P_nongait,2) + t_nongait*se_nongait);
% x_conf_nongait = [psd_struct.F_nongait(:,1)', fliplr((psd_struct.F_nongait(:,1))')];
% y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
%fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
%grey = [128, 128, 128] / 255;
%rectangle('Position',[1.5,box_lower,18.5,box_upper-box_lower],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
% rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % delta      
% rectangle('Position',[4,-100,4,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % theta
% rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
% rectangle('Position',[12,-100,18,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % beta
% rectangle('Position',[30,-100,40,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % low gamma
% rectangle('Position',[70,-100,30,100],'FaceColor',[1, 0, 1, 0.1],'EdgeColor','none'); % high gamma
y_limits = [-70 -30];
plot([1.5 1.5],y_limits,LineStyle="--",Color=[0 0 0])
plot([4 4],y_limits,LineStyle="--",Color=[0 0 0])
plot([8 8],y_limits,LineStyle="--",Color=[0 0 0])
plot([12 12],y_limits,LineStyle="--",Color=[0 0 0])
plot([30 30],y_limits,LineStyle="--",Color=[0 0 0])
% plot([70 70],y_limits,LineStyle="--",Color=[0 0 0])
% for i = 1:20:100
%     x = i;
%     plot([x x],y_limits,LineStyle="--",Color=[0 0 0])
% end
% legend([g,ng],'Gait','Non-Gait')
xlim([0 100])
ylim(y_limits)
hold off 

% figure(10)
% hold on 
% plot(psd_struct.F_gait(:,1),10*log10(mean(psd_struct.P_gait,2)),'b')
% std_gait = std(psd_struct.P_gait,[],2);
% se_gait = std_gait / sqrt(size(psd_struct.P_gait,2));
% alpha = 0.05;
% t_gait = tinv(1 - alpha / 2, size(psd_struct.P_gait,2)-1);
% lower_gait = 10*log10(mean(psd_struct.P_gait,2) - t_gait*se_gait);
% upper_gait = 10*log10(mean(psd_struct.P_gait,2) + t_gait*se_gait);
% x_conf_gait = [psd_struct.F_gait(:,1)', fliplr((psd_struct.F_gait(:,1))')];
% y_conf_gait = [lower_gait', fliplr((upper_gait)')];
% fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
% plot(psd_struct.F_nongait(:,1),10*log10(mean(psd_struct.P_nongait,2)),'r')
% std_nongait = std(psd_struct.P_nongait,[],2);
% se_nongait = std_nongait / sqrt(size(psd_struct.P_nongait,2));
% alpha = 0.05;
% t_nongait = tinv(1 - alpha / 2, size(psd_struct.P_nongait,2)-1);
% lower_nongait = 10*log10(mean(psd_struct.P_nongait,2) - t_nongait*se_nongait);
% upper_nongait = 10*log10(mean(psd_struct.P_nongait,2) + t_nongait*se_nongait);
% x_conf_nongait = [psd_struct.F_nongait(:,1)', fliplr((psd_struct.F_nongait(:,1))')];
% y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
% rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
% rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
% rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
% rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
% fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
% legend("off")
% xlim([1 20])
% ylim([box_lower box_upper])
% hold off

end
