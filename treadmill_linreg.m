feature_table = readtable('/Volumes/dwang3_shared/Treadmill/Ramp Up/Feature Tables/Power/gait_RCS_05_Treadmill_Ramp_Up_ON_STIM_ON_MEDS.csv');

% stim_columns = (contains(feature_table.Properties.VariableNames,'Left') & contains(feature_table.Properties.VariableNames,'Key0') | contains(feature_table.Properties.VariableNames,'Right') & contains(feature_table.Properties.VariableNames,'Key1'));
stim_columns = (contains(feature_table.Properties.VariableNames,'Left') & contains(feature_table.Properties.VariableNames,'Key1'));
feature_table = feature_table(:,feature_table.Properties.VariableNames(~stim_columns));

mdl = fitlm(feature_table,"linear","ResponseVar","Speed")

%% Plot Top 10 Predictors

unsorted_predictors = mdl.Coefficients(~contains(mdl.Coefficients.Properties.RowNames,'Intercept'),:);
unsorted_predictors.AbsEstimate = abs(unsorted_predictors.Estimate);
sorted_predictors = sortrows(unsorted_predictors,"AbsEstimate","descend");
top_10_predictors = sorted_predictors(1:10,:);
top_10_predictors.phase = zeros(10,1);
for i = 1:10
    if contains(top_10_predictors.Properties.RowNames{i}, 'Initial') 
        top_10_predictors.phase(i) = 1;
    elseif contains(top_10_predictors.Properties.RowNames{i}, 'RightSwing') 
        top_10_predictors.phase(i) = 2;
    elseif contains(top_10_predictors.Properties.RowNames{i}, 'Terminal') 
        top_10_predictors.phase(i) = 3;
    elseif contains(top_10_predictors.Properties.RowNames{i}, 'LeftSwing') 
        top_10_predictors.phase(i) = 4;
    end
end

for i = 1:10
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'tK', 't K');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'LeftSwing', ' LSP');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'RightSwing', ' RSP');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'InitialDoubleSupport', ' IDS');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'TerminalDoubleSupport', ' TDS');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'High', 'High ');
    top_10_predictors.Properties.RowNames{i} = strrep(top_10_predictors.Properties.RowNames{i}, 'Low', 'Low ');
    top_10_predictors.Properties.RowNames{i} = regexprep(top_10_predictors.Properties.RowNames{i}, '(\d+)', '$1 ');
end

top_10_predictors = sortrows(top_10_predictors,"phase");
retained_var_names = top_10_predictors.Properties.RowNames;

top_10_predictors.ticks = zeros(10,1);
ticker = 1;
dotted_line_store = [];
for i = 1:9
    if (contains(top_10_predictors.Properties.RowNames{i},'RSP') & ~contains(top_10_predictors.Properties.RowNames{i+1},'RSP')) | (contains(top_10_predictors.Properties.RowNames{i},'IDS') & ~contains(top_10_predictors.Properties.RowNames{i+1},'IDS')) | (contains(top_10_predictors.Properties.RowNames{i},'LSP') & ~contains(top_10_predictors.Properties.RowNames{i+1},'LSP')) | (contains(top_10_predictors.Properties.RowNames{i},'TDS') & ~contains(top_10_predictors.Properties.RowNames{i+1},'TDS'))
        top_10_predictors.ticks(i) = ticker;
        dotted_line_store = [dotted_line_store; ticker + 1];
        ticker = ticker + 2;
    else
        top_10_predictors.ticks(i) = ticker;
        ticker = ticker + 1;
    end
end

if (contains(top_10_predictors.Properties.RowNames{end},'RSP') & ~contains(top_10_predictors.Properties.RowNames{end-1},'RSP')) | (contains(top_10_predictors.Properties.RowNames{end},'IDS') & ~contains(top_10_predictors.Properties.RowNames{end-1},'IDS')) | (contains(top_10_predictors.Properties.RowNames{end},'LSP') & ~contains(top_10_predictors.Properties.RowNames{end-1},'LSP')) | (contains(top_10_predictors.Properties.RowNames{end},'TDS') & ~contains(top_10_predictors.Properties.RowNames{end-1},'TDS'))
    top_10_predictors.ticks(end) = top_10_predictors.ticks(end-1) + 2;
else
    top_10_predictors.ticks(end) = top_10_predictors.ticks(end-1) + 1;
end

figure()
ax(1) = subplot(1,1,1);
b = bar(top_10_predictors.ticks, top_10_predictors.Estimate, 0.75);
for i = 1:10
    ax(1).XTickLabel{i} = top_10_predictors.Properties.RowNames{i};
end
b.FaceColor = "flat";
for i = 1:10
    if contains(top_10_predictors.Properties.RowNames{i}, 'Left')
        b.CData(i,:) = [57 106 177]./255; % blue
    else
        b.CData(i,:) = [204 37 41]./255; % red
    end
end
hold on
for i = 1:size(dotted_line_store,1)
    plot([dotted_line_store(i) dotted_line_store(i)], [min(top_10_predictors.Estimate)-0.2 max(top_10_predictors.Estimate)+0.2],'LineStyle','--','Color','black')
end
ax(1).YLim = ([min(top_10_predictors.Estimate)-0.2, max(top_10_predictors.Estimate)+0.2]);
ylabel('Coefficient')
title('Top 10 Predictors of Speed')


%% Decomissioned 

IDS_table = top_10_predictors(contains(top_10_predictors.Properties.RowNames,'Initial'),:);
phraseToRemove = 'InitialDoubleSupport';
for i = 1:size(IDS_table,1)
    IDS_table.Properties.RowNames{i} = strrep(IDS_table.Properties.RowNames{i}, phraseToRemove, '');
    IDS_table.Properties.RowNames{i} = strrep(IDS_table.Properties.RowNames{i}, 'tK', 't K');
    IDS_table.Properties.RowNames{i} = regexprep(IDS_table.Properties.RowNames{i}, '(\d+)', '$1 ');
end
IDS_names = IDS_table.Properties.RowNames;
IDS_vals = IDS_table.Estimate;

RSP_table = top_10_predictors(contains(top_10_predictors.Properties.RowNames,'RightSwing'),:);
phraseToRemove = 'RightSwing';
for i = 1:size(RSP_table,1)
    RSP_table.Properties.RowNames{i} = strrep(RSP_table.Properties.RowNames{i}, phraseToRemove, '');
    RSP_table.Properties.RowNames{i} = strrep(RSP_table.Properties.RowNames{i}, 'tK', 't K');
    RSP_table.Properties.RowNames{i} = regexprep(RSP_table.Properties.RowNames{i}, '(\d+)', '$1 ');
end
RSP_names = RSP_table.Properties.RowNames;
RSP_vals = RSP_table.Estimate;

TDS_table = top_10_predictors(contains(top_10_predictors.Properties.RowNames,'Terminal'),:);
phraseToRemove = 'TerminalDoubleSupport';
for i = 1:size(TDS_table,1)
    TDS_table.Properties.RowNames{i} = strrep(TDS_table.Properties.RowNames{i}, phraseToRemove, '');
    TDS_table.Properties.RowNames{i} = strrep(TDS_table.Properties.RowNames{i}, 'tK', 't K');
    TDS_table.Properties.RowNames{i} = regexprep(TDS_table.Properties.RowNames{i}, '(\d+)', '$1 ');
end
TDS_names = TDS_table.Properties.RowNames;
TDS_vals = TDS_table.Estimate;

LSP_table = top_10_predictors(contains(top_10_predictors.Properties.RowNames,'LeftSwing'),:);
phraseToRemove = 'LeftSwing';
for i = 1:size(LSP_table,1)
    LSP_table.Properties.RowNames{i} = strrep(LSP_table.Properties.RowNames{i}, phraseToRemove, '');
    LSP_table.Properties.RowNames{i} = strrep(LSP_table.Properties.RowNames{i}, 'tK', 't K');
    LSP_table.Properties.RowNames{i} = regexprep(LSP_table.Properties.RowNames{i}, '(\d+)', '$1 ');
end
LSP_names = LSP_table.Properties.RowNames;
LSP_vals = LSP_table.Estimate;

barWidth = 0.5;
odd_vals = [-10:10];
even_vals = [-9.5:9.5];

figure()
ax(1) = subplot(1,4,1);
b = bar(1:size(IDS_names,1), IDS_vals, barWidth);
hold on
for i = 1:numel(IDS_names)
    ax(1).XTickLabel{i} = IDS_names{i};
end
ylabel('Coefficient')
title('Initial Double Support')
if numel(top_10_predictors) > 1
    ylim([1.1*min(top_10_predictors.Estimate) 1.1*max(top_10_predictors.Estimate)])
end
b.FaceColor = "flat";
for i = 1:numel(IDS_names)
    if contains(IDS_names{i}, 'Left')
        b.CData(i,:) = [0 0 1];
    elseif contains(IDS_names{i}, 'Right')
        b.CData(i,:) = [1 0 0];
    end
end
hold off
ax(2) = subplot(1,4,2);
b = bar(1:size(RSP_names,1), RSP_vals, barWidth);
for i = 1:numel(RSP_names)
    ax(2).XTickLabel{i} = RSP_names{i};
end
hold on
ylabel('Coefficient')
title('Right Swing Phase')
if numel(top_10_predictors) > 1
    ylim([1.1*min(top_10_predictors.Estimate) 1.1*max(top_10_predictors.Estimate)])
end
b.FaceColor = "flat";
for i = 1:numel(RSP_names)
    if contains(RSP_names{i}, 'Left')
        b.CData(i,:) = [0 0 1];
    elseif contains(RSP_names{i}, 'Right')
        b.CData(i,:) = [1 0 0];
    end
end
ax(3) = subplot(1,4,3);
b = bar(1:size(TDS_names,1), TDS_vals, barWidth);
for i = 1:numel(TDS_names)
    ax(3).XTickLabel{i} = TDS_names{i};
end
hold on
ylabel('Coefficient')
title('Terminal Double Support')
if numel(top_10_predictors) > 1
    ylim([1.1*min(top_10_predictors.Estimate) 1.1*max(top_10_predictors.Estimate)])
end
b.FaceColor = "flat";
for i = 1:numel(TDS_names)
    if contains(TDS_names{i}, 'Left')
        b.CData(i,:) = [0 0 1];
    elseif contains(TDS_names{i}, 'Right')
        b.CData(i,:) = [1 0 0];
    end
end
hold off
ax(4) = subplot(1,4,4);
b = bar(1:size(LSP_names,1), LSP_vals, barWidth);
for i = 1:numel(LSP_names)
    ax(4).XTickLabel{i} = LSP_names{i};
end
hold on
ylabel('Coefficient')
title('Left Swing Phase')
if numel(top_10_predictors) > 1
    ylim([1.1*min(top_10_predictors.Estimate) 1.1*max(top_10_predictors.Estimate)])
end
b.FaceColor = "flat";
for i = 1:numel(LSP_names)
    if contains(LSP_names{i}, 'Left')
        b.CData(i,:) = [0 0 1];
    elseif contains(LSP_names{i}, 'Right')
        b.CData(i,:) = [1 0 0];
    end
end
hold on
linkaxes(ax,'xy')

%% 



