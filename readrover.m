% goal of this script is to read in the Rover recordings and the associated
% excel files 

warning('off','all');

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

% add some empty columns where we can store the file name where associated
% acceleration info can be found (accel_fname), the start index of the
% acceleration info (start_index), and the end index of the acceleration
% info (end_index)

rover_stack.accel_fname = string(zeros(size(rover_stack,1),1));
rover_stack.data_start_index = zeros(size(rover_stack,1),1);
rover_stack.data_end_index = zeros(size(rover_stack,1),1);

% create some empty tables where we will eventually store information on
% the rover reports 

%rover_used_only = table('Size',[0, numel(rover_stack.Properties.VariableNames)],'VariableTypes', {'datetime','duration','double','duration','double','logical','string','string', 'datetime', 'string','double', 'double', 'double'},'VariableNames',rover_stack.Properties.VariableNames);
%rover_used_all = table('Size',[0, numel(rover_stack.Properties.VariableNames)],'VariableTypes', {'datetime','duration','double','duration','double','logical','string','string', 'datetime', 'string','double', 'double', 'double'},'VariableNames',rover_stack.Properties.VariableNames);
rover_used_all = [];
left_data = [];
date_time_array = [];
left_keys = table('Size', [0, 5], 'VariableTypes', {'double', 'double', 'string', 'double', 'logical'},'VariableNames', {'Start', 'End', 'Fname', 'Class', 'Used'});
left_keys = table([],[],[],[],[],'VariableNames',{'Start','End','Fname','Class','Used'});

% before we start partitioning the data into 5 second intervals, it is
% important to set the number of samples we want in each interval (500)

samples = 500;

% create a second-order butterworth bandpass filter of 0.5 - 20Hz 

[z,p,k] = butter(5,[0.5 20]/100, 'bandpass');
[sos] = zp2sos(z,p,k);


%% import accelerometry data and label with gait for left leg

% set the new path, which directs to the folder with actual rover
% recordings (containing accelerometry data)

path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Gait Study/Practice Post Alignment';
addpath(path)
files = dir(fullfile(path,'*.CSV'));
nrows = 0;

% cycle through the files in the folder and determine how many rows are
% needed to store all the data to preallocate a table size 

for i = 1:length(files)
    fname = fullfile(files(1).folder, files(1).name);
    opts = detectImportOptions(fname,'NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy')
    df = readtable(fname, opts);
    nrows = nrows + ceil(height(df)/samples);
end

% build the tables based on the number of rows needed to eventually store
% the left leg accelerometry and datetime data in chunks

left_data = zeros(nrows, samples, 3);
date_time_array = NaT(nrows, samples);

curr_row = 1;

% cycle through the files containing rover accelerometry data.

for i = 1:length(files)
    fname = fullfile(files(i).folder, files(i).name)
    opts = detectImportOptions(fname,'NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy');
    df = readtable(fname, opts);
    df.Properties.VariableNames = {'Date','Time','QuatW','QuatX','QuatY','QuatZ','QuatSeqNum','AccelX','AccelY','AccelZ','AccelSeqNum'};
    
    % for each file, read in the unfiltered accel x, y, and z data as well
    % as the datetime for each entry 

    unfiltered_x = df.AccelX;
    unfiltered_y = df.AccelY;
    unfiltered_z = df.AccelZ;
    combined = datetime(df.Date + df.Time);
    combined.Format = 'MM/dd/yy HH:mm:ss';
    d = struct('Date', datetime(df.('Date')), ...
               'Time', combined, ...
               'Used', zeros(height(df), 1), ...
               'AccX', unfiltered_x, ...
               'AccY', unfiltered_y, ...
               'AccZ', unfiltered_z);
    unfiltered_df = struct2table(d);

    % pick the date from the first entry of the data table containing
    % unfiltered accelerometry data (should be the same for the entire
    % file). isolate the rover label data from the excel reports
    % (containined in rover_stack) that match the date of the current
    % accelerometry data and are from the same leg. put this isolated data
    % in a table called rover_report 

    date = unfiltered_df{1,'Date'};
    date = datestr(date, 'mm/dd/yy');
    date = string(date);
    rover_report = rover_stack(rover_stack{:, 'Date'} == date & rover_stack{:, 'LeftRight'} == "Left", :); 

%     if height(rover_report) == 0
%         temp = [];
%         rover_report.Filename = temp;
%         rover_report.StartIndex = temp;
%         rover_report.EndIndex = temp; 
%     end

    % cycle through each entry in rover_report (each entry corresponds to a
    % single period of labeled gait or non-gait 

    for k = 1:height(rover_report)

        % for each entry, extract the start and end time of that period

        start_time = rover_report.Time(k);
        end_time = rover_report.End(k);

        % find the associated indexes of accel data for the start and end
        % time of that labeled period 

        % for the values in the unfiltered_df (accel data) that contain times for whcih
        % labels exist in the excel reports, turn the Used column value to
        % 1 
        
        if sum(unfiltered_df{:, 'Time'} == start_time) == 0
            start_index = 0;
            end_index = 0;
        else
            start_index = max(find(unfiltered_df{:, 'Time'} == start_time, 1, 'first') - 50, 1);
            end_index = min(find(unfiltered_df{:, 'Time'} >= end_time, 1, 'first') + 50, height(unfiltered_df));
            unfiltered_df{start_index:end_index, 'Used'} = 1;
        end

        % for the appropriate entry in rover_report (labeled period), add
        % the filename where accel data can be found, the start index for
        % the start time, and the end index for the end time 

        rover_report.accel_fname(k) = fname;
        rover_report.data_start_index(k) = start_index;
        rover_report.data_end_index(k) = end_index;
    end
    
    % add the collected rover_report data to a table called rover_used_all,
    % which will eventually contain both the labeled period and the
    % associated info about accel data 

    rover_used_all = [rover_used_all; rover_report];

    % cycle through the entries in each unfiltered_df table (containing
    % accel data) in chunks

    for i = 0:floor(height(unfiltered_df)/samples)

        % begin by creating an array 'data' that isolates an x-second
        % portion of the accel data based on the # of samples that has been
        % defined earlier. extract datetime data into date_time as well.

        data = table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 4:end));
        data = reshape(data, [1, size(data, 1), 3]);

        date_time = table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 2));
        date_time = reshape(date_time, [1, numel(date_time)]);

        % for each 'chunk,' determine whether most of the data in that
        % chunk has been used or unused (as in has a label or not)

        maj_used = round(mean(table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 3))));

        % for each chunk, record the start sample, end sample, fname for
        % the accel data, class (0), and whether the chunk is mostly
        % used/labeled or not

        next_key = table('Size', [0,5], 'VariableTypes',{'double','double','string','double','double'}, 'VariableNames', {'Start', 'End', 'Fname', 'Class', 'Used'});
        next_key.Start(1) = i*samples;
        next_key.End(1) = min((i + 1) * samples, height(unfiltered_df));
        next_key.Fname(1) = fname; 
        next_key.Class(1) = 0;
        next_key.Used(1) = maj_used;

        % accumulate this information about each chunk into a table called
        % left_keys

        left_keys = [left_keys; next_key];

        % if the chunk is incomplete, as in smaller than the x-second
        % period, because there are not enough samples, then pad the chunk
        % with zeroes for the next step 

        if size(data,2) < samples 
            diff = samples - size(data,2);
            diff_zeros = zeros([1, diff, 3]);
            data = cat(2, data, diff_zeros);

            diff_time = repmat(date_time(end),1,diff);
            date_time = cat(2, date_time, diff_time);
        end

        % filter the accel data using the previously designed filter 

        data(:, :, 1) = sosfilt(sos, data(:, :, 1), 1);
        data(:, :, 2) = sosfilt(sos, data(:, :, 2), 1);
        data(:, :, 3) = sosfilt(sos, data(:, :, 3), 1);
        
        % in left_data, add the filtered accelerometer data and the
        % associated datetime information 

        left_data(curr_row, :, :) = data;
        date_time_array(curr_row, :) = date_time;
        curr_row = curr_row + 1;
    end
end

% at the end, isolate only the periods which have associated labels for the
% majority of data in that chunk and place that data in filtered_table

mask = (left_keys.Used == 1);
filtered_table = left_keys(mask,:);

writetable(left_keys, 'left_keys_500.csv');
writetable(rover_stack, 'rcs02_reports_combined.csv');
writetable(rover_used_all, 'rcs02_reports_used_all.csv');

% summary of outputs:

% left_keys contains a list of all accel data files with data partitioned
% into specific x-second intervals. each interval is identified as used or
% not used (labeled as gait or not gait)

% rcs02_reports_combined contains a compilation of all gait periods from
% the Rover excel reports. all the gait info (gait cycle time, length,
% swing period, and heading) is provided, along with the filename, start,
% and end indexes of associated accel data if it exists. 

% rocs02_reports_used_all contains a list of only gait periods from the
% Rover excel reports that have associated accelerometry info. 

%% repeat for right leg data 

rover_used_all = [];
right_data = [];
date_time_array = [];
right_keys = table('Size', [0, 5], 'VariableTypes', {'double', 'double', 'string', 'double', 'logical'},'VariableNames', {'Start', 'End', 'Fname', 'Class', 'Used'});
right_keys = table([],[],[],[],[],'VariableNames',{'Start','End','Fname','Class','Used'});

samples = 500;
[z,p,k] = butter(5,[0.5 20]/100, 'bandpass');
[sos] = zp2sos(z,p,k);

path = '/Users/Rithvik/Documents/UCSF/Wang Lab/Data/RCS_02/Rover/Right';
files = dir(fullfile(path,'*.CSV'));
nrows = 0;

for i = 1:length(files)
    fname = fullfile(files(1).folder, files(1).name);
    opts = detectImportOptions(fname,'NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy');
    df = readtable(fname, opts);
    nrows = nrows + ceil(height(df)/samples);
end

right_data = zeros(nrows, samples, 3);
date_time_array = NaT(nrows, samples);

curr_row = 1;

for i = 1:length(files)
    fname = fullfile(files(i).folder, files(i).name)
    opts = detectImportOptions(fname,'NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy');
    df = readtable(fname, opts);
    df.Properties.VariableNames = {'Date','Time','QuatW','QuatX','QuatY','QuatZ','QuatSeqNum','AccelX','AccelY','AccelZ','AccelSeqNum'};
    unfiltered_x = df.AccelX;
    unfiltered_y = df.AccelY;
    unfiltered_z = df.AccelZ;
    combined = datetime(df.Date + df.Time);
    combined.Format = 'MM/dd/yy HH:mm:ss';
    d = struct('Date', datetime(df.('Date')), ...
               'Time', combined, ...
               'Used', zeros(height(df), 1), ...
               'AccX', unfiltered_x, ...
               'AccY', unfiltered_y, ...
               'AccZ', unfiltered_z);
    unfiltered_df = struct2table(d);
    date = unfiltered_df{1,'Date'};
    date = datestr(date, 'mm/dd/yy');
    date = string(date);
    rover_report = rover_stack(rover_stack{:, 'Date'} == date & rover_stack{:, 'LeftRight'} == "right", :); 

%     if height(rover_report) == 0
%         temp = [];
%         rover_report.Filename = temp;
%         rover_report.StartIndex = temp;
%         rover_report.EndIndex = temp; 
%     end

    for k = 1:height(rover_report)

        start_time = rover_report.Time(k);
        end_time = rover_report.End(k);
        
        if sum(unfiltered_df{:, 'Time'} == start_time) == 0
            start_index = 0;
            end_index = 0;
        else
            start_index = max(find(unfiltered_df{:, 'Time'} == start_time, 1, 'first') - 50, 1);
            end_index = min(find(unfiltered_df{:, 'Time'} >= end_time, 1, 'first') + 50, height(unfiltered_df));
            unfiltered_df{start_index:end_index, 'Used'} = 1;
        end

        rover_report.accel_fname(k) = fname;
        rover_report.data_start_index(k) = start_index;
        rover_report.data_end_index(k) = end_index;
    end

    rover_used_all = [rover_used_all; rover_report];

    for i = 0:floor(height(unfiltered_df)/samples)

        data = table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 4:end));
        data = reshape(data, [1, size(data, 1), 3]);

        date_time = table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 2));
        date_time = reshape(date_time, [1, numel(date_time)]);

        maj_used = round(mean(table2array(unfiltered_df(i * samples + 1:min((i + 1) * samples, height(unfiltered_df)), 3))));

        next_key = table('Size', [0,5], 'VariableTypes',{'double','double','string','double','double'}, 'VariableNames', {'Start', 'End', 'Fname', 'Class', 'Used'});
        next_key.Start(1) = i*samples;
        next_key.End(1) = min((i + 1) * samples, height(unfiltered_df));
        next_key.Fname(1) = fname; 
        next_key.Class(1) = 0;
        next_key.Used(1) = maj_used;

        right_keys = [right_keys; next_key];

        if size(data,2) < samples 
            diff = samples - size(data,2);
            diff_zeros = zeros([1, diff, 3]);
            data = cat(2, data, diff_zeros);

            diff_time = repmat(date_time(end),1,diff);
            date_time = cat(2, date_time, diff_time);
        end

        data(:, :, 1) = sosfilt(sos, data(:, :, 1), 1);
        data(:, :, 2) = sosfilt(sos, data(:, :, 2), 1);
        data(:, :, 3) = sosfilt(sos, data(:, :, 3), 1);

        right_data(curr_row, :, :) = data;
        date_time_array(curr_row, :) = date_time;
        curr_row = curr_row + 1;
    end
end

mask = (right_keys.Used == 1);
filtered_table = right_keys(mask,:);

writetable(right_keys, 'right_keys_500.csv');
writetable(rover_stack, 'rcs02_reports_combined_right.csv');
writetable(rover_used_all, 'rcs02_reports_used_all_right.csv');