%% CV Version

feature_array = table2array(feature_table);
X = feature_array(:,1:end-1);
Y = feature_array(:,end);

%cvp = cvpartition(size(X,1),'Holdout',0.4);
cvp = cvpartition(Y,'Holdout',0.4,'Stratify',true);
idxTrn = training(cvp); 
idxTest = test(cvp);    

t = templateTree('MaxNumSplits',1);
Mdl = fitcensemble(feature_table(idxTrn,:),'Speed','Method','AdaBoostM2','Learners',t);
labels = predict(Mdl,X(idxTest,:));

confusionchart(Y(idxTest,:),labels)

%% No CV Version

feature_array = table2array(feature_table);
X = feature_array(:,1:end-1);
Y = feature_array(:,end);

t = templateTree('MaxNumSplits',1);
Mdl = fitcensemble(feature_table,'Speed','Method','AdaBoostM2','Learners',t);
labels = predict(Mdl,X);

confusionchart(Y,labels)

predImportance = predictorImportance(Mdl);
bar(predImportance)
title("Predictor Importance")
xlabel("Predictor")
ylabel("Importance Measure")

[~,idxSort] = sort(predImportance,"descend");
idx10 = idxSort(1:10)
names10 = feature_table.Properties.VariableNames(idx10);
bar(predImportance(idx10))
title("Top 10 Predictors")
xlabel("Predictor")
ylabel("Importance Measure")
xticklabels(names10)

%% SMOTE

feature_table = readtable('/Volumes/dwang3_shared/Treadmill/Ramp Up/Feature Tables/Power/gait_RCS_02_Treadmill_Ramp_Up_BOTH_STIM_ON_MEDS.csv');
feature_array = table2array(feature_table);
X = feature_array(:,1:end-1);
Y = feature_array(:,end);
cvp = cvpartition(Y,'Holdout',0.33,'Stratify',true);
idxTrn = training(cvp); 
idxTest = test(cvp);    
X_train = X(idxTrn);
Y_train = Y(idxTrn);
X_test = X(idxTest);
Y_test = Y(idxTest);

speeds = unique(Y);
for i = 1:size(speeds)-1
    minority_class_label = speeds(i);
    X_minority = X_train(Y_train == minority_class_label, :);
    mdl = fitrsmote(X_minority, 'NumNeighbors', 3); 
end


  % Extract minority class instances
 % Create SMOTE model
[X_synthetic, y_synthetic] = sample(mdl, X_minority);  % Generate synthetic samples
