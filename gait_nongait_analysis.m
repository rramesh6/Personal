scripts_path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Scripts';
addpath(scripts_path);
clear scripts_path;

path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

rover_stack = rover_report('RCS_02');

P_gait_0 = [];
F_gait_0 = [];
chunks_gait_0 = [];
P_nongait_0 = [];
F_nongait_0 = [];
chunks_nongait_0 = [];

P_gait_1 = [];
F_gait_1 = [];
chunks_gait_1 = [];
P_nongait_1 = [];
F_nongait_1 = [];
chunks_nongait_1 = [];

P_gait_2 = [];
F_gait_2 = [];
chunks_gait_2 = [];
P_nongait_2 = [];
F_nongait_2 = [];
chunks_nongait_2 = [];

P_gait_3 = [];
F_gait_3 = [];
chunks_gait_3 = [];
P_nongait_3 = [];
F_nongait_3 = [];
chunks_nongait_3 = [];

for i = 14:24
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = post_align(file,1);
    update = ['Labeling ' num2str(file)];
    disp(update)
    post_align_struct = label_rover(post_align_struct,rover_stack);
    update = ['Chunking ' num2str(file)];
    disp(update)
    post_align_struct = chunk(post_align_struct,10,1,0);
    update = ['Filtering ' num2str(file)];
    disp(update)
    post_align_struct = filter_lfp(post_align_struct,1,200,0);
    update = ['Analyzing ' num2str(file)];
    disp(update)

    [P_gait_0_temp,F_gait_0_temp,chunks_gait_0_temp,P_nongait_0_temp,F_nongait_0_temp,chunks_nongait_0_temp] = psd_analysis(post_align_struct,0,0);
    P_gait_0 = [P_gait_0 P_gait_0_temp];
    F_gait_0 = [F_gait_0 F_gait_0_temp];
    chunks_gait_0 = [chunks_gait_0 chunks_gait_0_temp];
    P_nongait_0 = [P_nongait_0 P_nongait_0_temp];
    F_nongait_0 = [F_nongait_0 F_nongait_0_temp];
    chunks_nongait_0 = [chunks_nongait_0 chunks_nongait_0_temp];

    [P_gait_1_temp,F_gait_1_temp,chunks_gait_1_temp,P_nongait_1_temp,F_nongait_1_temp,chunks_nongait_1_temp] = psd_analysis(post_align_struct,1,0);
    P_gait_1 = [P_gait_1 P_gait_1_temp];
    F_gait_1 = [F_gait_1 F_gait_1_temp];
    chunks_gait_1 = [chunks_gait_1 chunks_gait_1_temp];
    P_nongait_1 = [P_nongait_1 P_nongait_1_temp];
    F_nongait_1 = [F_nongait_1 F_nongait_1_temp];
    chunks_nongait_1 = [chunks_nongait_1 chunks_nongait_1_temp];

    [P_gait_2_temp,F_gait_2_temp,chunks_gait_2_temp,P_nongait_2_temp,F_nongait_2_temp,chunks_nongait_2_temp] = psd_analysis(post_align_struct,2,0);
    P_gait_2 = [P_gait_2 P_gait_2_temp];
    F_gait_2 = [F_gait_2 F_gait_2_temp];
    chunks_gait_2 = [chunks_gait_2 chunks_gait_2_temp];
    P_nongait_2 = [P_nongait_2 P_nongait_2_temp];
    F_nongait_2 = [F_nongait_2 F_nongait_2_temp];
    chunks_nongait_2 = [chunks_nongait_2 chunks_nongait_2_temp];

    [P_gait_3_temp,F_gait_3_temp,chunks_gait_3_temp,P_nongait_3_temp,F_nongait_3_temp,chunks_nongait_3_temp] = psd_analysis(post_align_struct,3,0);
    P_gait_3 = [P_gait_3 P_gait_3_temp];
    F_gait_3 = [F_gait_3 F_gait_3_temp];
    chunks_gait_3 = [chunks_gait_3 chunks_gait_3_temp];
    P_nongait_3 = [P_nongait_3 P_nongait_3_temp];
    F_nongait_3 = [F_nongait_3 F_nongait_3_temp];
    chunks_nongait_3 = [chunks_nongait_3 chunks_nongait_3_temp];

end

%% Create structures

RCS02_prestim_key0 = struct();
RCS02_prestim_key0.P_gait_0 = P_gait_0;
RCS02_prestim_key0.F_gait_0 = F_gait_0;
RCS02_prestim_key0.chunks_gait_0 = chunks_gait_0;
RCS02_prestim_key0.P_nongait_0 = P_nongait_0;
RCS02_prestim_key0.F_nongait_0 = F_nongait_0;
RCS02_prestim_key0.chunks_nongait_0 = chunks_nongait_0;

RCS02_prestim_key1 = struct();
RCS02_prestim_key1.P_gait_1 = P_gait_1;
RCS02_prestim_key1.F_gait_1 = F_gait_1;
RCS02_prestim_key1.chunks_gait_1 = chunks_gait_1;
RCS02_prestim_key1.P_nongait_1 = P_nongait_1;
RCS02_prestim_key1.F_nongait_1 = F_nongait_1;
RCS02_prestim_key1.chunks_nongait_1 = chunks_nongait_1;

RCS02_prestim_key2 = struct();
RCS02_prestim_key2.P_gait_2 = P_gait_2;
RCS02_prestim_key2.F_gait_2 = F_gait_2;
RCS02_prestim_key2.chunks_gait_2 = chunks_gait_2;
RCS02_prestim_key2.P_nongait_2 = P_nongait_2;
RCS02_prestim_key2.F_nongait_2 = F_nongait_2;
RCS02_prestim_key2.chunks_nongait_2 = chunks_nongait_2;

RCS02_prestim_key3 = struct();
RCS02_prestim_key3.P_gait_3 = P_gait_3;
RCS02_prestim_key3.F_gait_3 = F_gait_3;
RCS02_prestim_key3.chunks_gait_3 = chunks_gait_3;
RCS02_prestim_key3.P_nongait_3 = P_nongait_3;
RCS02_prestim_key3.F_nongait_3 = F_nongait_3;
RCS02_prestim_key3.chunks_nongait_3 = chunks_nongait_3;

%% Logistic Regression with Frequency Bands

accuracies = [];

for i = 1:10 
    cv = cvpartition(size(feature_table_1,1),'HoldOut',0.3);
    idx = cv.test;
    dataTrain = feature_table_1(~idx,:);
    dataTest  = feature_table_1(idx,:);

    model = fitglm(dataTrain(:,1:6),dataTrain(:,7),"Distribution","binomial");
    y_hat = round(predict(model, dataTest(:,1:6)));
    accuracy = 100*sum(y_hat == dataTest(:,7))/numel(dataTest(:,7));
    accuracies = [accuracies accuracy];
end

average_accuracy = mean(accuracies);

x_line = average_accuracy;  
y_line = [-1 1];  
line(x_line, y_line, 'LineStyle', '--', 'Color', 'r');


model = fitglm(feature_table(:,1:6),feature_table(:,7),"Distribution","binomial");

model = fitglm(Y,feature_table(:,2502),"Distribution","binomial");

[idx,C] = kmeans(band_data(:,1:6),2);
figure;
plot(band_data(idx==1,1),band_data(idx==1,3),'r.','MarkerSize',12)
hold on
plot(band_data(idx==2,1),band_data(idx==2,3),'b.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

%% K-MEANS

[cluster_assignments, centroids] = kmeans(feature_table(:,1:6), 2);
figure()
subplot(121)
scatter(feature_table(:, 1), feature_table(:, 2), [], feature_table(:,7));
subplot(122)
scatter(feature_table(:, 1), feature_table(:, 2), [], cluster_assignments);

%% t-SNE

Y = tsne(feature_table(:,1:6));
scatter(Y(:,1),Y(:,2),[],feature_table(:,7));


feature_table = [power_percent_1.P_gait_1' ones(size(power_percent_1.P_gait_1,2),1); power_percent_1.P_nongait_1' zeros(size(power_percent_1.P_nongait_1,2),1)];
Y = tsne(power_percent_(:,1:6));
scatter(Y(:,1),Y(:,2));

%% OVERALL LOGISTIC REGRESSION

accuracies = [];

for i = 1:100 
    cv = cvpartition(size(overall_feature_table,1),'HoldOut',0.3);
    idx = cv.test;
    dataTrain = overall_feature_table(~idx,:);
    dataTest  = overall_feature_table(idx,:);

    model = fitglm(dataTrain(:,1:end-1),dataTrain(:,end),"Distribution","binomial");
    y_hat = round(predict(model, dataTest(:,1:end-1)));
    accuracy = 100*sum(y_hat == dataTest(:,end))/numel(dataTest(:,end));
    accuracies = [accuracies accuracy];
end

average_accuracy = mean(accuracies);


