%load('/Users/Rithvik/Documents/UCSF/Research/wang_lab/Gait Study/practice_align.mat')
file = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data/RCS02_Rover_RCS_120821_01.mat';
load(file)

if isfield(aligned_data,"right_LFP_table") == 1

    % create new time stream where t=0 is start of recordings (alignment point)
    l_rcs_lfp_time = aligned_data.left_LFP_table.DerivedTime - aligned_data.left_LFP_table.DerivedTime(1);
    r_rcs_lfp_time = aligned_data.right_LFP_table.DerivedTime - aligned_data.right_LFP_table.DerivedTime(1);
    l_rcs_accel_time = aligned_data.left_Accel_table.DerivedTime - aligned_data.left_Accel_table.DerivedTime(1);
    r_rcs_accel_time = aligned_data.right_Accel_table.DerivedTime - aligned_data.right_Accel_table.DerivedTime(1);
    l_rover_time = 1000*seconds(aligned_data.Rover.Left.DateTime - aligned_data.Rover.Left.DateTime(1));
    r_rover_time = 1000*seconds(aligned_data.Rover.Right.DateTime - aligned_data.Rover.Right.DateTime(1));

    if l_rcs_lfp_time(end,1) < r_rcs_lfp_time(end,1)
        l_rcs_lfp_crop = size(l_rcs_lfp_time,1);
        end_time = l_rcs_lfp_time(end,1);
        [~, r_rcs_lfp_crop] = min(abs(r_rcs_lfp_time - end_time));
        [~, l_rover_crop] = min(abs(l_rover_time - end_time));
        [~, r_rover_crop] = min(abs(r_rover_time - end_time));
        [~, l_rcs_accel_crop] = min(abs(l_rcs_accel_time - end_time));
        [~, r_rcs_accel_crop] = min(abs(r_rcs_accel_time - end_time));
    else
        r_rcs_lfp_crop = size(r_rcs_lfp_time,1);
        end_time = r_rcs_lfp_time(end,1);
        [~, l_rcs_lfp_crop] = min(abs(l_rcs_lfp_time - end_time));
        [~, l_rover_crop] = min(abs(l_rover_time - end_time));
        [~, r_rover_crop] = min(abs(r_rover_time - end_time));
        [~, l_rcs_accel_crop] = min(abs(l_rcs_accel_time - end_time));
        [~, r_rcs_accel_crop] = min(abs(r_rcs_accel_time - end_time));
    end

    % concatenate signals with the new time stream 
    l_rcs_lfp_sig = [aligned_data.left_LFP_table(1:l_rcs_lfp_crop,:), table(l_rcs_lfp_time(1:l_rcs_lfp_crop),'VariableNames',{'NewTime'})];
    r_rcs_lfp_sig = [aligned_data.right_LFP_table(1:r_rcs_lfp_crop,:), table(r_rcs_lfp_time(1:r_rcs_lfp_crop),'VariableNames',{'NewTime'})];
    l_rover_sig = [aligned_data.Rover.Left(1:l_rover_crop,:), table(l_rover_time(1:l_rover_crop),'VariableNames',{'NewTime'})];
    r_rover_sig = [aligned_data.Rover.Right(1:r_rover_crop,:), table(r_rover_time(1:r_rover_crop),'VariableNames',{'NewTime'})];
    l_rcs_accel_sig = [aligned_data.left_Accel_table(1:l_rcs_accel_crop,:), table(l_rcs_accel_time(1:l_rcs_accel_crop),'VariableNames',{'NewTime'})];
    r_rcs_accel_sig = [aligned_data.right_Accel_table(1:r_rcs_accel_crop,:), table(r_rcs_accel_time(1:r_rcs_accel_crop),'VariableNames',{'NewTime'})];

    % plot the aligned and cropped signals on unified time stream
    figure(2) 
    ax(1) = subplot(411);
    plot(l_rcs_accel_sig.NewTime,l_rcs_accel_sig.XSamples)
    title('L RC+S Accelerometry')
    ax(2) = subplot(412);
    plot(l_rover_sig.NewTime, l_rover_sig.LinearAccelX)
    title('L Rover Accelerometry')
    ax(3) = subplot(413);
    plot(r_rcs_accel_sig.NewTime,r_rcs_accel_sig.XSamples)
    title('R RC+S Accelerometry')
    ax(4) = subplot(414);
    plot(r_rover_sig.NewTime, r_rover_sig.LinearAccelX)
    title('R Rover Accelerometry')
    linkaxes(ax,'x');

    % place aligned and cropped signals into a structure post_align_struct
    post_align_struct.l_rcs_accel = l_rcs_accel_sig;
    post_align_struct.r_rcs_accel = r_rcs_accel_sig;
    post_align_struct.l_rcs_lfp = l_rcs_lfp_sig;
    post_align_struct.r_rcs_lfp = r_rcs_lfp_sig;
    post_align_struct.l_rover = l_rover_sig;
    post_align_struct.r_rover = r_rover_sig;

else 

    % create new time stream where t=0 is start of recordings (alignment point)
    l_rcs_lfp_time = aligned_data.left_LFP_table.DerivedTime - aligned_data.left_LFP_table.DerivedTime(1);
    l_rcs_accel_time = aligned_data.left_Accel_table.DerivedTime - aligned_data.left_Accel_table.DerivedTime(1);
    l_rover_time = 1000*seconds(aligned_data.Rover.Left.DateTime - aligned_data.Rover.Left.DateTime(1));
    r_rover_time = 1000*seconds(aligned_data.Rover.Right.DateTime - aligned_data.Rover.Right.DateTime(1));

    l_rcs_lfp_crop = size(l_rcs_lfp_time,1);
    end_time = l_rcs_lfp_time(end,1);
    [~, l_rover_crop] = min(abs(l_rover_time - end_time));
    [~, r_rover_crop] = min(abs(r_rover_time - end_time));
    [~, l_rcs_accel_crop] = min(abs(l_rcs_accel_time - end_time));

    l_rcs_lfp_sig = [aligned_data.left_LFP_table(1:l_rcs_lfp_crop,:), table(l_rcs_lfp_time(1:l_rcs_lfp_crop),'VariableNames',{'NewTime'})];
    l_rover_sig = [aligned_data.Rover.Left(1:l_rover_crop,:), table(l_rover_time(1:l_rover_crop),'VariableNames',{'NewTime'})];
    r_rover_sig = [aligned_data.Rover.Right(1:r_rover_crop,:), table(r_rover_time(1:r_rover_crop),'VariableNames',{'NewTime'})];
    l_rcs_accel_sig = [aligned_data.left_Accel_table(1:l_rcs_accel_crop,:), table(l_rcs_accel_time(1:l_rcs_accel_crop),'VariableNames',{'NewTime'})];

    % plot the aligned and cropped signals on unified time stream
    figure(2) 
    ax(1) = subplot(311);
    plot(l_rcs_accel_sig.NewTime,l_rcs_accel_sig.XSamples)
    title('L RC+S Accelerometry')
    ax(2) = subplot(312);
    plot(l_rover_sig.NewTime, l_rover_sig.LinearAccelX)
    title('L Rover Accelerometry')
    ax(4) = subplot(313);
    plot(r_rover_sig.NewTime, r_rover_sig.LinearAccelX)
    title('R Rover Accelerometry')
    linkaxes(ax,'x');

    % place aligned and cropped signals into a structure post_align_struct
    post_align_struct.l_rcs_accel = l_rcs_accel_sig;
    post_align_struct.l_rcs_lfp = l_rcs_lfp_sig;
    post_align_struct.l_rover = l_rover_sig;
    post_align_struct.r_rover = r_rover_sig;

end 

%%

warning('off','all');

% start by defining the files to be read, which are all the excel reports
% detailing gait periods generated by the Rover device 

path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Rover Excel Reports';
files = dir(fullfile(path,'*.xlsx'));
names = {files.name};
addpath(path)

% create empty matrix rover_stack to store all the info from these reports

rover_stack = [];

% cycle through all the excel reports and import all the data from these
% reports into rover_stack

for i = 1:length(names)

    fname = names{i}

    % convert all columns of the data set to appropriate data types,
    % starting with the left leg information

    df_left = readtable(fname,'Sheet', 'Left Leg Stride List','ReadVariableNames', true);
    df_left= removevars(df_left,{'x_'});
    df_left.Fname = repmat({fname},size(df_left,1),1);
    df_left.LeftRight = repmat({'Left'},size(df_left,1),1);
    df_left.Time = datetime(df_left.Time, 'InputFormat', 'MM/dd/yy - HH:mm:ss');
    df_left.GaitCycleTime_s_ = regexprep(df_left.GaitCycleTime_s_, ' s', '');
    df_left.GaitCycleTime_s_ = str2double(df_left.GaitCycleTime_s_);
    df_left.GaitCycleTime_s_ = seconds(df_left.GaitCycleTime_s_);
    df_left.Length_cm_ = regexprep(df_left.Length_cm_, ' cm', '');
    df_left.Length_cm_ = str2double(df_left.Length_cm_);
    df_left.SwingPeriod_s_ = regexprep(df_left.SwingPeriod_s_, ' s', '');
    df_left.SwingPeriod_s_ = str2double(df_left.SwingPeriod_s_);
    df_left.SwingPeriod_s_ = seconds(df_left.SwingPeriod_s_);
    df_left.Heading___ = regexprep(df_left.Heading___, ' °', '');
    df_left.Heading___ = str2double(df_left.Heading___);
    df_left.Used = strcmp(df_left.Used, 'Yes');
    df_left.Fname = string(df_left.Fname);
    df_left.LeftRight = string(df_left.LeftRight);
    df_left.End = df_left.Time + df_left.GaitCycleTime_s_;
    
    % now, convert all the right leg information similarly

    df_right = readtable(fname, 'Sheet', 'Right Leg Stride List', 'ReadVariableNames', true);
    df_right= removevars(df_right,{'x_'});
    df_right.Fname = repmat({fname},size(df_right,1),1);
    df_right.LeftRight = repmat({'right'},size(df_right,1),1);
    df_right.Time = datetime(df_right.Time, 'InputFormat', 'MM/dd/yy - HH:mm:ss');
    df_right.GaitCycleTime_s_ = regexprep(df_right.GaitCycleTime_s_, ' s', '');
    df_right.GaitCycleTime_s_ = str2double(df_right.GaitCycleTime_s_);
    df_right.GaitCycleTime_s_ = seconds(df_right.GaitCycleTime_s_);
    df_right.Length_cm_ = regexprep(df_right.Length_cm_, ' cm', '');
    df_right.Length_cm_ = str2double(df_right.Length_cm_);
    df_right.SwingPeriod_s_ = regexprep(df_right.SwingPeriod_s_, ' s', '');
    df_right.SwingPeriod_s_ = str2double(df_right.SwingPeriod_s_);
    df_right.SwingPeriod_s_ = seconds(df_right.SwingPeriod_s_);
    df_right.Heading___ = regexprep(df_right.Heading___, ' °', '');
    df_right.Heading___ = str2double(df_right.Heading___);
    df_right.Used = strcmp(df_right.Used, 'Yes');
    df_right.Fname = string(df_right.Fname);
    df_right.LeftRight = string(df_right.LeftRight);
    df_right.End = df_right.Time + df_right.GaitCycleTime_s_;

    % import the left and right leg info into rover_stack

    rover_stack = [rover_stack; df_left; df_right];
end

% clean up the final output rover_stack with appropriate variable names

rover_stack.Properties.VariableNames = {'Time','GaitCycleTime','Length','SwingPeriod','Heading','Used','Fname','LeftRight','End'};

% add a column in rover_stack with the dates for each data entry 

rover_stack.Date = datestr(rover_stack.Time, 'mm/dd/yy');
rover_stack.Date = string(rover_stack.Date);

%% generate ms by ms gait labels based on rover stack

post_align_struct.l_gait = table();
post_align_struct.l_gait = addvars(post_align_struct.l_gait,[0:1:post_align_struct.l_rover.NewTime(end,1)]','NewVariableNames','NewTime');
post_align_struct.l_gait = addvars(post_align_struct.l_gait, (repmat(post_align_struct.l_rover.DateTime(1),size(post_align_struct.l_gait(:,1))) + seconds(post_align_struct.l_gait.NewTime/1000)),'NewVariableNames','DateTime');
if contains(file,'21_') == 1
    post_align_struct.l_gait.DateTime.Year = 2021;
elseif contains(file,'22_') == 1
    post_align_struct.l_gait.DateTime.Year = 2022;
else
    post_align_struct.l_gait.DateTime.Year = 2023;
end
post_align_struct.l_gait = addvars(post_align_struct.l_gait, zeros(size(post_align_struct.l_gait.NewTime)),'NewVariableNames','Gait');

post_align_struct.r_gait = table();
post_align_struct.r_gait = addvars(post_align_struct.r_gait,[0:1:post_align_struct.r_rover.NewTime(end,1)]','NewVariableNames','NewTime');
post_align_struct.r_gait = addvars(post_align_struct.r_gait, (repmat(post_align_struct.r_rover.DateTime(1),size(post_align_struct.r_gait(:,1))) + seconds(post_align_struct.r_gait.NewTime/1000)),'NewVariableNames','DateTime');
if contains(file,'21_') == 1
    post_align_struct.r_gait.DateTime.Year = 2021;
elseif contains(file,'22_') == 1
    post_align_struct.r_gait.DateTime.Year = 2022;
else
    post_align_struct.r_gait.DateTime.Year = 2023;
end
post_align_struct.r_gait = addvars(post_align_struct.r_gait, zeros(size(post_align_struct.r_gait.NewTime)),'NewVariableNames','Gait');

rover_stack_left = rover_stack(rover_stack.LeftRight == "Left",:);
rover_stack_right = rover_stack(rover_stack.LeftRight == "right",:);

for i = 1:size(rover_stack_left,1)
    if (rover_stack_left.Time(i) < post_align_struct.l_gait.DateTime(1) & rover_stack_left.End(i) < post_align_struct.l_gait.DateTime(1)) || (rover_stack_left.Time(i) > post_align_struct.l_gait.DateTime(end) & rover_stack_left.End(i) > post_align_struct.l_gait.DateTime(end))      
        continue
    else
        start_time = rover_stack_left.Time(i);
        [~, start_idx] = min(abs(post_align_struct.l_gait.DateTime - start_time));
        end_time = rover_stack_left.End(i);
        [~, end_idx] = min(abs(post_align_struct.l_gait.DateTime - end_time));
        post_align_struct.l_gait.Gait(start_idx:end_idx) = 1;
    end
end

for i = 1:size(rover_stack_right,1)
    if (rover_stack_right.Time(i) < post_align_struct.r_gait.DateTime(1) & rover_stack_right.End(i) < post_align_struct.r_gait.DateTime(1)) || (rover_stack_right.Time(i) > post_align_struct.r_gait.DateTime(end) & rover_stack_right.End(i) > post_align_struct.r_gait.DateTime(end))      
        continue
    else
        start_time = rover_stack_right.Time(i);
        [~, start_idx] = min(abs(post_align_struct.r_gait.DateTime - start_time));
        end_time = rover_stack_right.End(i);
        [~, end_idx] = min(abs(post_align_struct.r_gait.DateTime - end_time));
        post_align_struct.r_gait.Gait(start_idx:end_idx) = 1;
    end
end

%% define chunking criteria 

period = 10; % in seconds 

%% chunk left leg data

ms = period*1000;
num_periods = ceil(post_align_struct.l_gait.NewTime(end)/ms);

post_align_struct.l_gait_periods = table();
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,[0:ms:ms*(num_periods-1)]','NewVariableNames','NewTime_start');
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,[ms:ms:(ms*num_periods)]','NewVariableNames','NewTime_end');
post_align_struct.l_gait_periods.NewTime_end(end) = post_align_struct.l_gait.NewTime(end);
post_align_struct.l_gait_periods = addvars(post_align_struct.l_gait_periods,zeros(num_periods,1),'NewVariableNames','Gait');

for i = 1:num_periods
    start_idx = post_align_struct.l_gait_periods.NewTime_start(i) + 1;
    end_idx = post_align_struct.l_gait_periods.NewTime_end(i) + 1;
    post_align_struct.l_gait_periods.Gait(i) = round(mean(post_align_struct.l_gait.Gait(start_idx:end_idx)));
end

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

%% repeat for right data: RCS02 will not generate a figure  

ms = period*1000;
num_periods = ceil(post_align_struct.r_gait.NewTime(end)/ms);

post_align_struct.r_gait_periods = table();
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,[0:ms:ms*(num_periods-1)]','NewVariableNames','NewTime_start');
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,[ms:ms:(ms*num_periods)]','NewVariableNames','NewTime_end');
post_align_struct.r_gait_periods.NewTime_end(end) = post_align_struct.r_gait.NewTime(end);
post_align_struct.r_gait_periods = addvars(post_align_struct.r_gait_periods,zeros(num_periods,1),'NewVariableNames','Gait');

for i = 1:num_periods
    start_idx = post_align_struct.r_gait_periods.NewTime_start(i) + 1;
    end_idx = post_align_struct.r_gait_periods.NewTime_end(i) + 1;
    post_align_struct.r_gait_periods.Gait(i) = round(mean(post_align_struct.r_gait.Gait(start_idx:end_idx)));
end

if isfield(aligned_data,"right_LFP_table") == 1
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

%% plot left and right rover accelerometry 

figure(4)
ax(1) = subplot(211);
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

%% Method 1: BOTH L and R have to be gait periods
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
for i = 1:num_periods
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
for i = 1:num_periods
    x = overall_gait_periods.NewTime_start(i);
    y = 0 - max(post_align_struct.l_rover.LinearAccelX);
    width = overall_gait_periods.NewTime_end(i)-overall_gait_periods.NewTime_start(i);
    height = 2.1*max(post_align_struct.l_rover.LinearAccelX)*overall_gait_periods.Gait(i);
    rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
end
hold off;
linkaxes(ax,'x');

post_align_struct.overall_gait_periods = overall_gait_periods;

%% FILTER LFP SIGNALS

Fs = 500;
filter_above = 1;
filter_below = 200;

post_align_struct.l_rcs_lfp.key0 = highpass(post_align_struct.l_rcs_lfp.key0,filter_above,Fs);
post_align_struct.l_rcs_lfp.key0 = lowpass(post_align_struct.l_rcs_lfp.key0,filter_below,Fs);

post_align_struct.l_rcs_lfp.key1 = highpass(post_align_struct.l_rcs_lfp.key1,filter_above,Fs);
post_align_struct.l_rcs_lfp.key1 = lowpass(post_align_struct.l_rcs_lfp.key1,filter_below,Fs);

post_align_struct.l_rcs_lfp.key2 = highpass(post_align_struct.l_rcs_lfp.key2,filter_above,Fs);
post_align_struct.l_rcs_lfp.key2 = lowpass(post_align_struct.l_rcs_lfp.key2,filter_below,Fs);

post_align_struct.l_rcs_lfp.key3 = highpass(post_align_struct.l_rcs_lfp.key3,filter_above,Fs);
post_align_struct.l_rcs_lfp.key3 = lowpass(post_align_struct.l_rcs_lfp.key3,filter_below,Fs);

%% LFP Prelim Analysis: KEY 0
new_num_periods = ceil(post_align_struct.l_rcs_lfp.NewTime(end)/ms)-1;

Fs = 500;
Pxx_key0_gait = [];
F_key0_gait = [];
Pxx_key0_nongait = [];
F_key0_nongait = [];

for i = 1:new_num_periods
    [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
    [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
    x = post_align_struct.l_rcs_lfp.key0(start_idx:end_idx,:);
    [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
    if post_align_struct.overall_gait_periods.Gait(i,1) == 1
        Pxx_key0_gait = [Pxx_key0_gait Pxx];
        F_key0_gait = [F_key0_gait F];
    else
        Pxx_key0_nongait = [Pxx_key0_nongait Pxx];
        F_key0_nongait = [F_key0_nongait F];
    end
    update = ['Finished processing chunk ' num2str(i)];
    disp(update)
end


figure(6)
title('Power Spectral Density (Gait - key 0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
for i = 1:size(Pxx_key0_gait,2)
    plot(F_key0_gait(:,i),10*log10(Pxx_key0_gait(:,i)))
    pause(0.5)
end
hold off

figure(7)
subplot(211)
title('Average Power Spectral Density (Gait - key 0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key0_gait(:,1),10*log10(mean(Pxx_key0_gait,2)))
hold off 
subplot(212)
title('Average Power Spectral Density (Non-Gait - key 0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key0_nongait(:,1),10*log10(mean(Pxx_key0_nongait,2)))
hold off 

figure(8)
title('Average Power Spectral Density (key 0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key0_gait(:,1),10*log10(mean(Pxx_key0_gait,2)),'b')
plot(F_key0_nongait(:,1),10*log10(mean(Pxx_key0_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 

%% LFP Prelim Analysis: KEY 1
new_num_periods = ceil(post_align_struct.l_rcs_lfp.NewTime(end)/ms)-1;

Fs = 500;
Pxx_key1_gait = [];
F_key1_gait = [];
Pxx_key1_nongait = [];
F_key1_nongait = [];

for i = 1:new_num_periods
    [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
    [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
    x = post_align_struct.l_rcs_lfp.key1(start_idx:end_idx,:);
    [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
    if post_align_struct.overall_gait_periods.Gait(i,1) == 1
        Pxx_key1_gait = [Pxx_key1_gait Pxx];
        F_key1_gait = [F_key1_gait F];
    else
        Pxx_key1_nongait = [Pxx_key1_nongait Pxx];
        F_key1_nongait = [F_key1_nongait F];
    end
    update = ['Finished processing chunk ' num2str(i)];
    disp(update)
end


figure(6)
title('Power Spectral Density (Gait - key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
for i = 1:size(Pxx_key1_gait,2)
    plot(F_key1_gait(:,i),10*log10(Pxx_key1_gait(:,i)))
    pause(0.5)
end
hold off

figure(7)
subplot(211)
title('Average Power Spectral Density (Gait - key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key1_gait(:,1),10*log10(mean(Pxx_key1_gait,2)))
hold off 
subplot(212)
title('Average Power Spectral Density (Non-Gait - key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key1_nongait(:,1),10*log10(mean(Pxx_key1_nongait,2)))
hold off 

figure(8)
title('Average Power Spectral Density (key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key1_gait(:,1),10*log10(mean(Pxx_key1_gait,2)),'b')
plot(F_key1_nongait(:,1),10*log10(mean(Pxx_key1_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 

%% LFP Prelim Analysis: KEY 2
new_num_periods = ceil(post_align_struct.l_rcs_lfp.NewTime(end)/ms)-1;

Fs = 500;
Pxx_key2_gait = [];
F_key2_gait = [];
Pxx_key2_nongait = [];
F_key2_nongait = [];

for i = 1:new_num_periods
    [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
    [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
    x = post_align_struct.l_rcs_lfp.key2(start_idx:end_idx,:);
    [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
    if post_align_struct.overall_gait_periods.Gait(i,1) == 1
        Pxx_key2_gait = [Pxx_key2_gait Pxx];
        F_key2_gait = [F_key2_gait F];
    else
        Pxx_key2_nongait = [Pxx_key2_nongait Pxx];
        F_key2_nongait = [F_key2_nongait F];
    end
    update = ['Finished processing chunk ' num2str(i)];
    disp(update)
end


figure(6)
title('Power Spectral Density (Gait - key 2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
for i = 1:size(Pxx_key2_gait,2)
    plot(F_key2_gait(:,i),10*log10(Pxx_key2_gait(:,i)))
    pause(0.5)
end
hold off

figure(7)
subplot(211)
title('Average Power Spectral Density (Gait - key 2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key2_gait(:,1),10*log10(mean(Pxx_key2_gait,2)))
hold off 
subplot(212)
title('Average Power Spectral Density (Non-Gait - key 2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key2_nongait(:,1),10*log10(mean(Pxx_key2_nongait,2)))
hold off 

figure(8)
title('Average Power Spectral Density (key 2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key2_gait(:,1),10*log10(mean(Pxx_key2_gait,2)),'b')
plot(F_key2_nongait(:,1),10*log10(mean(Pxx_key2_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 

%% LFP Prelim Analysis: KEY 3
new_num_periods = ceil(post_align_struct.l_rcs_lfp.NewTime(end)/ms)-1;

Fs = 500;
Pxx_key3_gait = [];
F_key3_gait = [];
Pxx_key3_nongait = [];
F_key3_nongait = [];

for i = 1:new_num_periods
    [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
    [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
    x = post_align_struct.l_rcs_lfp.key3(start_idx:end_idx,:);
    [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
    if post_align_struct.overall_gait_periods.Gait(i,1) == 1
        Pxx_key3_gait = [Pxx_key3_gait Pxx];
        F_key3_gait = [F_key3_gait F];
    else
        Pxx_key3_nongait = [Pxx_key3_nongait Pxx];
        F_key3_nongait = [F_key3_nongait F];
    end
    update = ['Finished processing chunk ' num2str(i)];
    disp(update)
end


figure(6)
title('Power Spectral Density (Gait - key 3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
for i = 1:size(Pxx_key3_gait,2)
    plot(F_key3_gait(:,i),10*log10(Pxx_key3_gait(:,i)))
    pause(0.5)
end
hold off

figure(7)
subplot(211)
title('Average Power Spectral Density (Gait - key 3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key3_gait(:,1),10*log10(mean(Pxx_key3_gait,2)))
hold off 
subplot(212)
title('Average Power Spectral Density (Non-Gait - key 3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key3_nongait(:,1),10*log10(mean(Pxx_key3_nongait,2)))
hold off 

figure(8)
title('Average Power Spectral Density (key 3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key3_gait(:,1),10*log10(mean(Pxx_key3_gait,2)),'b')
plot(F_key3_nongait(:,1),10*log10(mean(Pxx_key3_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 

%% Plot all keys on the same figure 

figure(9)
subplot(221)
title('Average Power Spectral Density (key 0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key0_gait(:,1),10*log10(mean(Pxx_key0_gait,2)),'b')
plot(F_key0_nongait(:,1),10*log10(mean(Pxx_key0_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 
subplot(222)
title('Average Power Spectral Density (key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key1_gait(:,1),10*log10(mean(Pxx_key1_gait,2)),'b')
plot(F_key1_nongait(:,1),10*log10(mean(Pxx_key1_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 
subplot(223)
title('Average Power Spectral Density (key 2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key2_gait(:,1),10*log10(mean(Pxx_key2_gait,2)),'b')
plot(F_key2_nongait(:,1),10*log10(mean(Pxx_key2_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 
subplot(224)
title('Average Power Spectral Density (key 3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(F_key3_gait(:,1),10*log10(mean(Pxx_key3_gait,2)),'b')
plot(F_key3_nongait(:,1),10*log10(mean(Pxx_key3_nongait,2)),'r')
legend('Gait','Non-Gait')
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
hold off 

%% Filter key0 signal 

figure(10)
subplot(211)
title('L RCS LFP (key 0) - Pre-Filtering')
hold on 
plot(post_align_struct.l_rcs_lfp.NewTime,post_align_struct.l_rcs_lfp.key0)
xlabel('Time')
ylabel('Amplitude (mV)')
hold off
subplot(212)
title('L RCS LFP (key 0) - Post-Filtering')
filtered_l_key0 = highpass(post_align_struct.l_rcs_lfp.key0,1,Fs);
filtered_l_key0 = lowpass(filtered_l_key0,200,Fs);
hold on 
plot(post_align_struct.l_rcs_lfp.NewTime,filtered_l_key0)
xlabel('Time')
ylabel('Amplitude (mV)')
hold off

% compare PSDs
figure(11)
[Pxx_key0_prefilter,F_key0_prefilter] = pwelch(post_align_struct.l_rcs_lfp.key0,[],[],[],Fs);
plot(F_key0_prefilter(:,1),10*log10(mean(Pxx_key0_prefilter,2)),'b')
hold on 
title('L RCS LFP (key 0) PSDs')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
[Pxx_key0_postfilter,F_key0_postfilter] = pwelch(filtered_l_key0,[],[],[],Fs);
plot(F_key0_postfilter(:,1),10*log10(mean(Pxx_key0_postfilter,2)),'r')
legend('Pre-Filter','Post-Filter')