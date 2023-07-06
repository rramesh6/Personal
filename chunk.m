function post_align_struct = chunk(post_align_struct, period, fig)

post_align_struct.period = period; 

% chunk left leg data

ms = period*1000;
num_periods = ceil(post_align_struct.l_gait.NewTime(end)/ms);

post_align_struct.l_gait_periods = table();
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,[0:ms:ms*(num_periods-1)]','NewVariableNames','NewTime_start');
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,[ms:ms:(ms*num_periods)]','NewVariableNames','NewTime_end');
post_align_struct.l_gait_periods.NewTime_end(end) = post_align_struct.l_gait.NewTime(end);
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,zeros(num_periods,1),'NewVariableNames','Gait');

for i = 1:num_periods
    start_idx = double(post_align_struct.l_gait_periods.NewTime_start(i) + 1);
    end_idx = double(post_align_struct.l_gait_periods.NewTime_end(i) + 1);
    if end_idx > size(post_align_struct.l_gait.Gait,1)
        end_idx = size(post_align_struct.l_gait.Gait,1);
        post_align_struct.l_gait_periods.NewTime_end(i) = end_idx;
    end
    post_align_struct.l_gait_periods.Gait(i) = round(mean(post_align_struct.l_gait.Gait(start_idx:end_idx)));
end

if fig == 1 || nargin == 2
    figure(3)
    ax(1) = subplot(211);
    plot(post_align_struct.l_rcs_accel.NewTime,post_align_struct.l_rcs_accel.XSamples)
    title('L RC+S Accelerometry')
    hold on 
    for i = 1:num_periods
        x = post_align_struct.l_gait_periods.NewTime_start(i);
        y = mean(post_align_struct.l_rcs_accel.XSamples) - 0.5*max(abs(post_align_struct.l_rcs_accel.XSamples));
        width = post_align_struct.l_gait_periods.NewTime_end(i)-post_align_struct.l_gait_periods.NewTime_start(i);
        height = max(abs(post_align_struct.l_rcs_accel.XSamples))*post_align_struct.l_gait_periods.Gait(i);
        rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
    end
    hold off
    ax(2) = subplot(212);
    plot(post_align_struct.l_rover.NewTime,post_align_struct.l_rover.LinearAccelX)
    title('L Rover Accelerometry')
    hold on
    for i = 1:num_periods
        x = post_align_struct.l_gait_periods.NewTime_start(i);
        y = 0 - max(post_align_struct.l_rover.LinearAccelX);
        width = post_align_struct.l_gait_periods.NewTime_end(i)-post_align_struct.l_gait_periods.NewTime_start(i);
        height = 2.1*max(post_align_struct.l_rover.LinearAccelX)*post_align_struct.l_gait_periods.Gait(i);
        rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
    end
    hold off;
    linkaxes(ax,'x');
end

% repeat for right data: RCS02 will not generate a figure  
ms = period*1000;
num_periods = ceil(post_align_struct.r_gait.NewTime(end)/ms);

post_align_struct.r_gait_periods = table();
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,[0:ms:ms*(num_periods-1)]','NewVariableNames','NewTime_start');
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,[ms:ms:(ms*num_periods)]','NewVariableNames','NewTime_end');
post_align_struct.r_gait_periods.NewTime_end(end) = post_align_struct.r_gait.NewTime(end);
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,zeros(num_periods,1),'NewVariableNames','Gait');

for i = 1:num_periods
    start_idx = double(post_align_struct.r_gait_periods.NewTime_start(i) + 1);
    end_idx = double(post_align_struct.r_gait_periods.NewTime_end(i) + 1);
    if end_idx > size(post_align_struct.r_gait.Gait,1)
        end_idx = size(post_align_struct.r_gait.Gait,1);
        post_align_struct.r_gait_periods.NewTime_end(i) = end_idx;
    end
    post_align_struct.r_gait_periods.Gait(i) = round(mean(post_align_struct.r_gait.Gait(start_idx:end_idx)));
end

if fig == 1 || nargin == 2
    if isfield(post_align_struct,"r_rcs_accel") == 1
        figure(3)
        ax(1) = subplot(211);
        plot(post_align_struct.r_rcs_accel.NewTime,post_align_struct.r_rcs_accel.XSamples)
        title('R RC+S Accelerometry')
        hold on 
        for i = 1:num_periods
            x = post_align_struct.r_gait_periods.NewTime_start(i);
            y = mean(post_align_struct.r_rcs_accel.XSamples) - 0.5*max(abs(post_align_struct.r_rcs_accel.XSamples));
            width = post_align_struct.r_gait_periods.NewTime_end(i)-post_align_struct.r_gait_periods.NewTime_start(i);
            height = max(abs(post_align_struct.r_rcs_accel.XSamples))*post_align_struct.r_gait_periods.Gait(i);
            rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
            rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
        end
        hold off
        ax(2) = subplot(212);
        plot(post_align_struct.r_rover.NewTime,post_align_struct.r_rover.LinearAccelX)
        title('R Rover Accelerometry')
        hold on
        for i = 1:num_periods
            x = post_align_struct.r_gait_periods.NewTime_start(i);
            y = 0 - max(post_align_struct.r_rover.LinearAccelX);
            width = post_align_struct.r_gait_periods.NewTime_end(i)-post_align_struct.r_gait_periods.NewTime_start(i);
            height = 2.1*max(post_align_struct.r_rover.LinearAccelX)*post_align_struct.r_gait_periods.Gait(i);
            rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
        end
        hold off;
        linkaxes(ax,'x');
    end
end

% plot left and right rover accelerometry 

new_num_periods = min(size(post_align_struct.l_gait_periods,1),size(post_align_struct.r_gait_periods,1));
if fig == 1 || nargin == 2
    figure(4)
    ax(1) = subplot(211);
    plot(post_align_struct.l_rover.NewTime,post_align_struct.l_rover.LinearAccelX)
    title('L Rover Accelerometry')
    hold on
    for i = 1:new_num_periods
        x = post_align_struct.l_gait_periods.NewTime_start(i);
        y = 0 - max(post_align_struct.l_rover.LinearAccelX);
        width = post_align_struct.l_gait_periods.NewTime_end(i)-post_align_struct.l_gait_periods.NewTime_start(i);
        height = 2.1*max(post_align_struct.l_rover.LinearAccelX)*post_align_struct.l_gait_periods.Gait(i);
        rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
    end
    hold off;
    ax(2) = subplot(212);
    plot(post_align_struct.r_rover.NewTime,post_align_struct.r_rover.LinearAccelX)
    title('R Rover Accelerometry')
    hold on
    for i = 1:new_num_periods
        x = post_align_struct.r_gait_periods.NewTime_start(i);
        y = 0 - max(post_align_struct.r_rover.LinearAccelX);
        width = post_align_struct.r_gait_periods.NewTime_end(i)-post_align_struct.r_gait_periods.NewTime_start(i);
        height = 2.1*max(post_align_struct.r_rover.LinearAccelX)*post_align_struct.r_gait_periods.Gait(i);
        rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
    end
    hold off;
    linkaxes(ax,'x');
end

% Method 1: BOTH L and R have to be gait periods
overall_gait_periods = post_align_struct.l_gait_periods;
overall_gait_periods.Gait(:) = 0;

for i = 1:size(overall_gait_periods,1)
    if post_align_struct.l_gait_periods.Gait(i,1) == 1 & post_align_struct.r_gait_periods.Gait(i,1) == 1
        overall_gait_periods.Gait(i,1) = 1;
    else
        continue
    end
end

figure(5)
ax(1) = subplot(211);
plot(post_align_struct.l_rcs_accel.NewTime,post_align_struct.l_rcs_accel.XSamples)
title('L RCS Accelerometry')
hold on
for i = 1:new_num_periods
    x = overall_gait_periods.NewTime_start(i);
    y = 0 - max(post_align_struct.l_rcs_accel.XSamples);
    width = overall_gait_periods.NewTime_end(i)-overall_gait_periods.NewTime_start(i);
    height = 2.1*max(post_align_struct.l_rcs_accel.XSamples)*overall_gait_periods.Gait(i);
    rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
end
hold off;
ax(2) = subplot(212);
plot(post_align_struct.r_rover.NewTime,post_align_struct.r_rover.LinearAccelX)
title('L Rover Accelerometry')
hold on
for i = 1:new_num_periods
    x = overall_gait_periods.NewTime_start(i);
    y = 0 - max(post_align_struct.l_rover.LinearAccelX);
    width = overall_gait_periods.NewTime_end(i)-overall_gait_periods.NewTime_start(i);
    height = 2.1*max(post_align_struct.l_rover.LinearAccelX)*overall_gait_periods.Gait(i);
    rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
end
hold off;
linkaxes(ax,'x');

post_align_struct.overall_gait_periods = overall_gait_periods;

end
