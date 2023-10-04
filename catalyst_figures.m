%% Average PSDs 

figure()
subplot(121)
mean_psd_fig(RCS05_poststim_noroverloss_key0,0)
title('GPi')
xlim([0 30])
ylim([-85 -45])
subplot(122)
mean_psd_fig(RCS05_poststim_noroverloss_key2,2)
title('M1')
xlim([0 50])
ylim([-75 -40])
legend('off')

%%

figure()
overall_gait_periods = post_align_struct.overall_gait_periods;
plot(post_align_struct.l_rover.NewTime/1000,post_align_struct.l_rover.LinearAccelX,'black')
title('Wearable Device Acceleration Signal - Left Leg')
hold on
for i = 1:size(overall_gait_periods,1)
    x = overall_gait_periods.NewTime_start(i)/1000;
    y = 0 - max(post_align_struct.l_rover.LinearAccelX);
    width = overall_gait_periods.NewTime_end(i)-overall_gait_periods.NewTime_start(i);
    width = width/1000;
    height = 2.1*max(post_align_struct.l_rover.LinearAccelX);
    if overall_gait_periods.Gait(i) == 1
            rectangle('Position',[x,y,width,height],'FaceColor',[0, 0, 1, 0.2],'EdgeColor','none');
    elseif overall_gait_periods.Gait(i) == 0
            rectangle('Position',[x,y,width,height],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none');
    end
end
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
hold off