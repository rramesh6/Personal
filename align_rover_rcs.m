% import data from the first Rover file (left leg) as a table
opts = detectImportOptions('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Processed Data/Rover/Left/010322.CSV','NumHeaderLines',6);
opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy')
left_leg_data = readtable('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Processed Data/Rover/Left/010322.CSV',opts);

% convert date and time columns to string arrays
date_strings = cellstr(left_leg_data.Date);
time_strings = cellstr(left_leg_data.Time);

% combine date and time columns into a datetime array
datetime_strings = strcat(date_strings, {' '}, time_strings);
datetime_column = datetime(datetime_strings, 'InputFormat', 'MM/dd/yy HH:mm:ss');
unix_time_left = posixtime(datetime_column);

% account for sampling rate with the addition of 20 miliseconds intervals
n = size(unix_time_left,1);
counter = mod(0:n-1, 51)';
unix_time_left = unix_time_left + 0.02*counter;

% search the folder of right leg data to check whether a corresponding file
% exists
if isfile('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Processed Data/Rover/Right/010322.CSV')
    opts = detectImportOptions('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Processed Data/Rover/Right/010322.CSV','NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy')
    right_leg_data = readtable('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Processed Data/Rover/Right/010322.CSV',opts);
    % convert date and time columns to string arrays
    date_strings = cellstr(right_leg_data.Date);
    time_strings = cellstr(right_leg_data.Time);
    % combine date and time columns into a datetime array
    datetime_strings = strcat(date_strings, {' '}, time_strings);
    datetime_column = datetime(datetime_strings, 'InputFormat', 'MM/dd/yy HH:mm:ss');
    unix_time_right = posixtime(datetime_column);
    % account for sampling rate with the addition of 20 miliseconds intervals
    n = size(unix_time_right,1);
    counter = mod(0:n-1, 51)';
    unix_time_right = unix_time_right + 0.02*counter;
else
    return
end

% in theory, what should happen is that the code should cycle through the
% available RC+S data to find the session that overlaps with the Rover
% data. This should be a focused search to only identify the sessions that
% might reasonably overlap based on the naming system. It should then
% repeat this for every Rover session basically and build a compiled table
% for each Rover session with the gait and neural data in one place.