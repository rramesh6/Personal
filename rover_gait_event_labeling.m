%% Visualize Rover Data

figure()
ax(1) = subplot(211);
plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX)
hold on
title('L RCS Accel')
hold off
ax(2) = subplot(212);
plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX)
hold on
title('R RCS Accel')
hold off


%% Identify LHS 

% figure()
% peak_idx = islocalmax(aligned_data.Rover.Left.LinearAccelX,"MinProminence",7000);
% peak_times = aligned_data.Rover.Left.taxis(peak_idx);
% plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
% tolerance = 0.25;
% hold on
% title('L RCS Accel')
% for i = 1:size(gait_events.LHS,1)
%     plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'g')
% end
% for i = 2:size(aligned_data.Rover.Left.taxis,1)-1
%     isClose = any(abs(aligned_data.Rover.Left.taxis(i) - peak_times) <= tolerance);
%     if aligned_data.Rover.Left.LinearAccelX(i-1) > -565 & aligned_data.Rover.Left.LinearAccelX(i) < -565 & aligned_data.Rover.Left.LinearAccelX(i+1) < -565 & aligned_data.Rover.Left.LinearAccelX(i) > -900 & isClose == 0
%         scatter(aligned_data.Rover.Left.taxis(i),aligned_data.Rover.Left.LinearAccelX(i),'r','filled')
%     end
% end
% hold off
% 
% 
% plot(aligned_data.Rover.Left.taxis,filtered_signal,'k')
% hold on
% for i = 1:size(gait_events.LHS,1)
%     plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'g')
% end
% hold off
% 
% figure()
% plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
% hold on
% title('L RCS Accel')
% for i = 1:size(gait_events.LHS,1)
%     plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'g')
% end
% for i = 2:size(aligned_data.Rover.Left.taxis,1)-1
%     if filtered_signal(i-1) > -313 & filtered_signal(i) < -313 & filtered_signal(i+1) < -313
%         scatter(aligned_data.Rover.Left.taxis(i),aligned_data.Rover.Left.LinearAccelX(i),'r','filled')
%     end
% end
% hold off

vals = [];
for i = 1:size(aligned_data.gait_events.LHS,1)
    [~, idx] = min(abs(aligned_data.Rover.Left.taxis - aligned_data.gait_events.LHS(i)));
    val = filtered_signal(idx);
    vals = [vals; val];
end
mean_val_LHS = mean(vals);
std_val_LHS = std(vals);

filtered_signal = bandpass(aligned_data.Rover.Left.LinearAccelX,[0.5 3],100);
figure()
plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
hold on
title('L RCS Accel')
for i = 1:size(gait_events.LHS,1)
    plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'g')
end
LHS_times = [];
for i = 2:size(aligned_data.Rover.Left.taxis,1)-1
    if filtered_signal(i-1) > -313 & filtered_signal(i) < -313 & filtered_signal(i+1) < -313
        temp_LHS = aligned_data.Rover.Left.taxis(i);
        LHS_times = [LHS_times; temp_LHS];
    end
end
LHS_times_final = [];
for i = 1:size(LHS_times,1)-1
    if LHS_times(i+1) - LHS_times(i) <= 0.2
       temp_LHS = mean([LHS_times(i) LHS_times(i+1)]);
       LHS_times_final = [LHS_times_final; temp_LHS];
    else
       LHS_times_final = [LHS_times_final; LHS_times(i)];
    end
end
for i = 1:size(LHS_times_final,1)-1
    plot([LHS_times_final(i) LHS_times_final(i)], [-8000 10000],'r')
end
hold off

%% Identify LTO

filtered_signal = bandpass(aligned_data.Rover.Left.LinearAccelX,[0.5 3],100);
figure()
plot(aligned_data.Rover.Left.taxis,filtered_signal,'k')
hold on
title('L RCS Accel')
for i = 1:size(gait_events.LTO,1)
    plot([gait_events.LTO(i) gait_events.LTO(i)], [-8000 10000],'g')
end

vals = [];
for i = 1:size(aligned_data.gait_events.LTO,1)
    [~, idx] = min(abs(aligned_data.Rover.Left.taxis - aligned_data.gait_events.LTO(i)));
    val = filtered_signal(idx);
    vals = [vals; val];
end
mean_val_LTO = mean(vals);
std_val_LTO = std(vals);

filtered_signal = bandpass(aligned_data.Rover.Left.LinearAccelX,[0.5 3],100);
figure()
plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
hold on
title('L RCS Accel')
for i = 1:size(gait_events.LTO,1)
    plot([gait_events.LTO(i) gait_events.LTO(i)], [-8000 10000],'g')
end
LTO_times = [];
for i = 2:size(aligned_data.Rover.Left.taxis,1)-1
    if filtered_signal(i-1) > 507 & filtered_signal(i) < 507 & filtered_signal(i+1) < 507
        temp_LTO = aligned_data.Rover.Left.taxis(i);
        LTO_times = [LTO_times; temp_LTO];
    end
end
LTO_times_final = [];
for i = 1:size(LTO_times,1)-1
    if LTO_times(i+1) - LTO_times(i) <= 0.2
       temp_LTO = mean([LTO_times(i) LTO_times(i+1)]);
       LTO_times_final = [LTO_times_final; temp_LTO];
    else
       LTO_times_final = [LTO_times_final; LTO_times(i)];
    end
end
for i = 1:size(LTO_times_final,1)-1
    plot([LTO_times_final(i) LTO_times_final(i)], [-8000 10000],'r')
end
hold off

%% Identify RHS

% figure()
% peak_idx = islocalmin(aligned_data.Rover.Right.LinearAccelX,"MinProminence",7000);
% peak_times = aligned_data.Rover.Right.taxis(peak_idx);
% plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX,'k')
% tolerance = 0.25;
% hold on
% title('R RCS Accel')
% for i = 1:size(gait_events.RHS,1)
%     plot([gait_events.RHS(i) gait_events.RHS(i)], [-8000 10000],'g')
% end
% for i = 2:size(aligned_data.Rover.Right.taxis,1)-1
%     isClose = any(abs(aligned_data.Rover.Right.taxis(i) - peak_times) <= tolerance);
%     if aligned_data.Rover.Right.LinearAccelX(i-1) < 565 & aligned_data.Rover.Right.LinearAccelX(i) > 565 & aligned_data.Rover.Right.LinearAccelX(i+1) > 565 & aligned_data.Rover.Right.LinearAccelX(i) < 900 & isClose == 0
%         scatter(aligned_data.Rover.Right.taxis(i),aligned_data.Rover.Right.LinearAccelX(i),'r','filled')
%     end
% end
% hold off

vals = [];
for i = 1:size(aligned_data.gait_events.RHS,1)
    [~, idx] = min(abs(aligned_data.Rover.Right.taxis - aligned_data.gait_events.RHS(i)));
    val = filtered_signal(idx);
    vals = [vals; val];
end
mean_val_RHS = mean(vals);
std_val_RHS = std(vals);

filtered_signal = bandpass(aligned_data.Rover.Right.LinearAccelX,[0.5 3],100);
figure()
plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX,'k')
hold on
title('R RCS Accel')
for i = 1:size(gait_events.RHS,1)
    plot([gait_events.RHS(i) gait_events.RHS(i)], [-8000 10000],'g')
end
RHS_times = [];
for i = 2:size(aligned_data.Rover.Right.taxis,1)-1
    if filtered_signal(i-1) < 917 & filtered_signal(i) > 917 & filtered_signal(i+1) > 917
        temp_RHS = aligned_data.Rover.Right.taxis(i);
        RHS_times = [RHS_times; temp_RHS];
    end
end
RHS_times_final = [];
for i = 1:size(RHS_times,1)-1
    if RHS_times(i+1) - RHS_times(i) <= 0.2
       temp_RHS = mean([RHS_times(i) RHS_times(i+1)]);
       RHS_times_final = [RHS_times_final; temp_RHS];
    else
       RHS_times_final = [RHS_times_final; RHS_times(i)];
    end
end
for i = 1:size(RHS_times_final,1)-1
    plot([RHS_times_final(i) RHS_times_final(i)], [-8000 10000],'r')
end
hold off

%% Identify RTO 

filtered_signal = bandpass(aligned_data.Rover.Right.LinearAccelX,[0.5 2],100);
figure()
plot(aligned_data.Rover.Right.taxis,filtered_signal,'k')
hold on
title('R RCS Accel')
for i = 1:size(gait_events.RTO,1)
    plot([gait_events.RTO(i) gait_events.RTO(i)], [-8000 10000],'g')
end

vals = [];
for i = 1:size(aligned_data.gait_events.RTO,1)
    [~, idx] = min(abs(aligned_data.Rover.Right.taxis - aligned_data.gait_events.RTO(i)));
    val = filtered_signal(idx);
    vals = [vals; val];
end
mean_val_RTO = mean(vals);
std_val_RTO = std(vals);

filtered_signal = bandpass(aligned_data.Rover.Right.LinearAccelX,[0.5 2],100);
figure()
plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX,'k')
hold on
title('R RCS Accel')
for i = 1:size(gait_events.RTO,1)
    plot([gait_events.RTO(i) gait_events.RTO(i)], [-8000 10000],'g')
end
RTO_times = [];
for i = 2:size(aligned_data.Rover.Right.taxis,1)-1
    isClose = any(abs(aligned_data.Rover.Right.taxis(i) - peak_times) <= 0.25);
    if filtered_signal(i-1) < -93.5 & filtered_signal(i) > -93.5 & filtered_signal(i+1) > -93.5
        temp_RTO = aligned_data.Rover.Right.taxis(i);
        RTO_times = [RTO_times; temp_RTO];
    end
end
RTO_times_final = [];
for i = 1:size(RTO_times,1)-1
    if RTO_times(i+1) - RTO_times(i) <= 0.01
       temp_RTO = mean([RTO_times(i) RTO_times(i+1)]);
       RTO_times_final = [RTO_times_final; temp_RTO];
    else
       RTO_times_final = [RTO_times_final; RTO_times(i)];
    end
end
for i = 1:size(RTO_times_final,1)-1
    plot([RTO_times_final(i) RTO_times_final(i)], [-8000 10000],'r')
end
hold off

%% Consolidate

LHS = [];
RTO = [];
RHS = [];
LTO = [];


for i = 1:size(LHS_times_final,1)-1
    LHS_temp = LHS_times_final(i);
    start_time = LHS_times_final(i);
    end_time = LHS_times_final(i+1);
    RTO_isolate = RTO_times_final(RTO_times_final > start_time & RTO_times_final < end_time);
    if size(RTO_isolate,1) == 0
        continue
    elseif size(RTO_isolate,1) == 1
        RTO_temp = RTO_isolate;
        start_time = RTO_isolate;
    else
        RTO_temp = RTO_isolate(1);
        start_time = RTO_isolate(1);
    end
    RHS_isolate = RHS_times_final(RHS_times_final > start_time & RHS_times_final < end_time);
    if size(RHS_isolate,1) == 0
        continue
    elseif size(RHS_isolate,1) == 1
        RHS_temp = RHS_isolate;
        start_time = RHS_isolate;
    else
        RHS_temp = RHS_isolate(1);
        start_time = RHS_isolate(1);
    end
    LTO_isolate = LTO_times_final(LTO_times_final > start_time & LTO_times_final < end_time);
    if size(LTO_isolate,1) == 0
        continue
    elseif size(LTO_isolate,1) == 1
        LTO_temp = LTO_isolate;
        start_time = LTO_isolate;
    else
        LTO_temp = LTO_isolate(1);
        start_time = LTO_isolate(1);
    end
    LHS = [LHS; LHS_temp];
    RTO = [RTO; RTO_temp];
    RHS = [RHS; RHS_temp];
    LTO = [LTO; LTO_temp];
end

figure()
ax(1) = subplot(411);
plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
hold on
title('L Heel Strikes')
for i = 1:size(gait_events.LHS,1)
    plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'g')
end
for i = 1:size(LHS,1)
    plot([LHS(i) LHS(i)], [-8000 10000],'r')
end
ax(2) = subplot(412);
plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX,'k')
hold on
title('R Toe Offs')
for i = 1:size(gait_events.RTO,1)
    plot([gait_events.RTO(i) gait_events.RTO(i)], [-8000 10000],'g')
end
for i = 1:size(RTO,1)
    plot([RTO(i) RTO(i)], [-8000 10000],'r')
end
ax(3) = subplot(413);
plot(aligned_data.Rover.Right.taxis,aligned_data.Rover.Right.LinearAccelX,'k')
hold on
title('R Heel Strikes')
for i = 1:size(gait_events.RHS,1)
    plot([gait_events.RHS(i) gait_events.RHS(i)], [-8000 10000],'g')
end
for i = 1:size(RHS,1)
    plot([RHS(i) RHS(i)], [-8000 10000],'r')
end
ax(4) = subplot(414);
plot(aligned_data.Rover.Left.taxis,aligned_data.Rover.Left.LinearAccelX,'k')
hold on
title('L Toe Offs')
for i = 1:size(gait_events.LTO,1)
    plot([gait_events.LTO(i) gait_events.LTO(i)], [-8000 10000],'g')
end
for i = 1:size(LTO,1)
    plot([LTO(i) LTO(i)], [-8000 10000],'r')
end
linkaxes(ax,'x')


