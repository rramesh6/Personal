%% load in the data - structures containing PSD info for one key each 

load('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/athome_rover/RCS05_poststim_noroverloss.mat')

%% extract all dates from which recordings have been sourced

chunk_labels = RCS05_poststim_noroverloss_key0.chunks_gait_0;

all_session_dates = cell(size(chunk_labels));

for i = 1:numel(chunk_labels)
    date = strtok(chunk_labels{i}, '_');
    all_session_dates{i} = date;
end

session_dates = unique(all_session_dates);

%% randomly partition into two sets based on dates: train and test 

percentageToSelect = 0.7;
numToSelect = round(percentageToSelect * numel(session_dates));
randomIndices = randperm(numel(session_dates), numToSelect);
train_dates = session_dates(randomIndices);
nonSelectedIndices = setdiff(1:numel(session_dates), randomIndices);
test_dates = session_dates(nonSelectedIndices);

for i = 1:numel(test_dates)
    if i == 1
        session = test_dates{i};
        key0_train = throw_session(RCS05_poststim_noroverloss_key0,session);
        key2_train = throw_session(RCS05_poststim_noroverloss_key2,session);
        key3_train = throw_session(RCS05_poststim_noroverloss_key3,session);
    else 
        session = test_dates{i};
        key0_train = throw_session(key0_train,session);
        key2_train = throw_session(key2_train,session);
        key3_train = throw_session(key3_train,session);
    end
end

for i = 1:numel(train_dates)
    if i == 1
        session = train_dates{i};
        key0_test = throw_session(RCS05_poststim_noroverloss_key0,session);
        key2_test = throw_session(RCS05_poststim_noroverloss_key2,session);
        key3_test = throw_session(RCS05_poststim_noroverloss_key3,session);
    else 
        session = train_dates{i};
        key0_test = throw_session(key0_test,session);
        key2_test = throw_session(key2_test,session);
        key3_test = throw_session(key3_test,session);
    end
end

%%

key0_train_table = band_feature_table(key0_train,0,50,1,0);
key2_train_table = band_feature_table(key2_train,2,50,1,0);
key3_train_table = band_feature_table(key3_train,3,50,1,0);
key0_test_table = band_feature_table(key0_test,0,50,1,0);
key2_test_table = band_feature_table(key2_test,2,50,1,0);
key3_test_table = band_feature_table(key3_test,3,50,1,0);

%%

writetable(key0_train_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key0_train.csv');
writetable(key2_train_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key2_train.csv');
writetable(key3_train_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key3_train.csv');
writetable(key0_test_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key0_test.csv');
writetable(key2_test_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key2_test.csv');
writetable(key3_test_table,'/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/Rover/Data/Analysis Data/Revised Feature Tables/date_partitioning/key3_test.csv');





