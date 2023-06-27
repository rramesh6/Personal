%load('/Users/Rithvik/Documents/UCSF/Research/wang_lab/Gait Study/practice_align.mat')
load('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data/RCS02_Rover_RCS_121421_03.mat')

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

%warning('off','all');

% start by defining the files to be read, which are all the excel reports
% detailing gait periods generated by the Rover device 

path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Gait Study/Practice Excel Report';
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
post_align_struct.l_gait.DateTime.Year = 2022;
post_align_struct.l_gait = addvars(post_align_struct.l_gait, zeros(size(post_align_struct.l_gait.NewTime)),'NewVariableNames','Gait');

post_align_struct.r_gait = table();
post_align_struct.r_gait = addvars(post_align_struct.r_gait,[0:1:post_align_struct.r_rover.NewTime(end,1)]','NewVariableNames','NewTime');
post_align_struct.r_gait = addvars(post_align_struct.r_gait, (repmat(post_align_struct.r_rover.DateTime(1),size(post_align_struct.r_gait(:,1))) + seconds(post_align_struct.r_gait.NewTime/1000)),'NewVariableNames','DateTime');
post_align_struct.r_gait.DateTime.Year = 2022;
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

%% repeat for right data 

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
