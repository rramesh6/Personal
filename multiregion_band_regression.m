function [coeff_map, accuracy_map] = multiregion_band_regression(structures,keys,step,freq_lim,num_cv,compare,logtransform)

coeff_map = [];
accuracy_map = [];
num_bands = [0:step:freq_lim];
num_bands(1) = [];

big_struct = struct();

for i = 1:size(keys,2)
    key = keys(i);
    structure = structures{i};
    if logtransform == 1
        key_struct = struct();
        key_struct.P = [10*log10(structure.(['P_gait_' num2str(key)])') ones(size(structure.(['P_gait_' num2str(key)])',1),1); 10*log10(structure.(['P_nongait_' num2str(key)])') zeros(size(structure.(['P_nongait_' num2str(key)])',1),1)];
        key_struct.F = structure.(['F_gait_' num2str(key)])(1:2001,1)';
    else
        key_struct = struct();
        key_struct.P = [structure.(['P_gait_' num2str(key)])' ones(size(structure.(['P_gait_' num2str(key)])',1),1); structure.(['P_nongait_' num2str(key)])' zeros(size(structure.(['P_nongait_' num2str(key)])',1),1)];
        key_struct.F = structure.(['F_gait_' num2str(key)])(1:2001,1)';
    end
    fieldname = sprintf('key%d', key);
    big_struct.(fieldname) = key_struct;
end

coeff_map = [];
accuracy_map = [];
num_bands = [0:step:freq_lim];
num_bands(1) = [];

for bs = num_bands

    band_vals = 0:(freq_lim/bs):freq_lim;
    
    band_idx = [];
    for i = 1:size(band_vals,2)
        [~,temp_idx] = min(abs(key_struct.F - band_vals(i)));
        band_idx = [band_idx temp_idx];
    end
    
    overall_feature_table = [];

    for j = 1:size(keys,2)
        key = keys(j);
        feature_table = ones(size(key_struct.P,1),size(band_vals,2)-1);
        fieldname = sprintf('key%d', key);
        for i = 1:bs
            feature_table(:,i) = mean(big_struct.(fieldname).P(:,band_idx(i):band_idx(i+1)),2);
        end
        feature_table = zscore(feature_table);
        overall_feature_table = [overall_feature_table feature_table];
    end

    overall_feature_table = [overall_feature_table big_struct.(fieldname).P(:,end)];
    coeff_chunks = [];
    temp_accuracy = [];

    for i = 1:num_cv

        cv = cvpartition(size(overall_feature_table,1),'HoldOut',0.3);
        idx = cv.test;
        dataTrain = overall_feature_table(~idx,:);
        dataTest  = overall_feature_table(idx,:);
    
        model = fitglm(dataTrain(:,1:bs*size(keys,2)),dataTrain(:,end),"Distribution","binomial");
        y_hat = round(predict(model, dataTest(:,1:bs*size(keys,2))));
        accuracy = 100*(sum(y_hat == dataTest(:,end)) / numel(dataTest(:,end)));
        temp_accuracy = [temp_accuracy accuracy];
        temp_coeffs = table2array(model.Coefficients);
        temp_coeffs = temp_coeffs(2:(bs*size(keys,2))+1,1)';
        coeff_chunks = [coeff_chunks; temp_coeffs];

    end
    
    average_accuracy = mean(temp_accuracy);
    average_coeffs = mean(coeff_chunks,1);
    accuracy_map = [accuracy_map average_accuracy];
    
    overall_coeff_row = [];

    for j = 1:size(keys,2)
        temp_coeff_row = ones(size(key_struct.F));
        temp_average_coeffs = average_coeffs((1:bs)+((j-1)*bs));
        for i = 1:bs
           temp_coeff_row(band_idx(i):band_idx(i+1)) = temp_average_coeffs(i);
        end
        temp_coeff_row = temp_coeff_row(:,1:(freq_lim*10+1));
        overall_coeff_row = [overall_coeff_row temp_coeff_row];
    end
    
    coeff_map = [coeff_map; overall_coeff_row];
    update = ['Finished processing ' num2str(bs) ' bands data.'];
    disp(update)

end

% figure()
% h = heatmap(flip(coeff_map(:,1:freq_lim*10+1)),'GridVisible','off');
% xlabel('Frequency (Hz)')
% ylabel('Number of Bands')
% title(['RCS02 Band Search - Logistic Regression - Key ' num2str(key)])
% frequencies = cellfun(@num2str, num2cell(key_struct.F(1,1:freq_lim*10+1)), 'UniformOutput', false);
% frequencies = string(frequencies);
% frequencies(mod(key_struct.F(1,1:freq_lim*10+1),5) ~= 0) = " ";
% h.XDisplayLabels = frequencies;
% band_sizes = string(num_bands');
% band_sizes(mod(num_bands(1,:),10) ~= 0) = " ";
% band_sizes = flip(band_sizes);
% h.YDisplayLabels = band_sizes;
% 
% figure()
% plot(num_bands,accuracy_map);
% hold on
% xlabel('Number of Bands')
% ylabel('Accuracy (%)')

%zscored_coeff_map = zscore(coeff_map,[],2);

max_abs_coeffs = max(abs(coeff_map),[],2);
rescaled_coeffs = coeff_map ./ max_abs_coeffs;

if compare == 1
    accuracies = [];
    overall_feature_table = [];
    for i = 1:size(keys,2)
        key = keys(i);
        fieldname = sprintf('key%d', key);
        if logtransform == 1
            [feature_table,~] = freq_power_analysis(structures{i},1);
        else
            [feature_table,~] = freq_power_analysis(structures{i},0);
        end
        if i ~= size(keys,2)
            feature_table = feature_table(:,1:end-1);
        end
        overall_feature_table = [overall_feature_table feature_table];
    end

    for i = 1:10 
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
end

plots_needed = size(keys,2) + 3;
figure()
subplot(1,plots_needed,1:plots_needed-1)
h = heatmap(flip(rescaled_coeffs(:,1:size(keys,2)*(freq_lim*10+1))),'GridVisible','off','Colormap',redbluecmap(11));
xlabel('Frequency (Hz)')
ylabel('Number of Bands')
title(['RCS02 Band Search - Multiregion Logistic Regression'])
frequencies = cellfun(@num2str, num2cell(key_struct.F(1,1:freq_lim*10+1)), 'UniformOutput', false);
frequencies = string(frequencies);
frequencies(mod(key_struct.F(1,1:freq_lim*10+1),5) ~= 0) = " ";
overall_frequencies = repmat(frequencies,[1,size(keys,2)]);
h.XDisplayLabels = overall_frequencies;
band_sizes = double((num_bands));
band_sizes(mod(band_sizes,5) ~= 0) = " ";
band_sizes = string(band_sizes)';
band_sizes = flip(band_sizes);
h.YDisplayLabels = band_sizes;
subplot(1,plots_needed,plots_needed)
p = scatter(accuracy_map, num_bands,'black','filled');
rotate(p,[0 0 1],90)
xlim([80 95])
ylim([num_bands(1)-step/2 num_bands(end)+step/2])
hold on
xlabel('Accuracy(%)')
set(gca,'YTickLabel',[]);
if compare == 1
     line([average_accuracy average_accuracy], [0-step/2 num_bands(end)+step/2], 'LineStyle', '--', 'Color', 'r');
     xlim([min(accuracy_map)-5, max(average_accuracy,max(accuracy_map))+5])
end
end
