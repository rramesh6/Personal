function massive_feature_table = band_feature_table(structure,key,freq_lim,logtransform,zscoring);

if logtransform == 1
    key_struct = struct();
    key_struct.P = [10*log10(structure.(['P_gait_' num2str(key)])') ones(size(structure.(['P_gait_' num2str(key)])',1),1); 10*log10(structure.(['P_nongait_' num2str(key)])') zeros(size(structure.(['P_nongait_' num2str(key)])',1),1)];
    key_struct.F = structure.(['F_gait_' num2str(key)])(1:2001,1)';
else
    key_struct = struct();
    key_struct.P = [structure.(['P_gait_' num2str(key)])' ones(size(structure.(['P_gait_' num2str(key)])',1),1); structure.(['P_nongait_' num2str(key)])' zeros(size(structure.(['P_nongait_' num2str(key)])',1),1)];
    key_struct.F = structure.(['F_gait_' num2str(key)])(1:2001,1)';
end

step = 1;
num_bands = [0:step:freq_lim];
num_bands(1) = [];
massive_feature_table = [];

band_vals = [];
for bs = num_bands;
top_freq = 1;
bottom_freq = 1;
    while bottom_freq + bs <= freq_lim 
      top_freq = bottom_freq + bs;  
      band_vals = [band_vals; bottom_freq top_freq];
      bottom_freq = bottom_freq + 1;
    end
end

band_names = strcat(strtrim(num2str(band_vals(:,1))), '-', strtrim(num2str(band_vals(:,2))));
band_names = string(band_names);
for i = 1:numel(band_names)
    band_names{i} = strrep(band_names{i}, ' ', ''); 
    band_names{i} = strcat('key_',num2str(key),'_',band_names{i});
end

band_idx = band_vals;
for i = 1:size(band_vals,1)
    for j = 1:size(band_vals,2)
        [~, band_idx(i,j)] = min(abs(key_struct.F - band_vals(i,j)));
    end
end

for i = 1:size(band_vals)
    feature_table = mean(key_struct.P(:,band_idx(i,1):band_idx(i,2)),2);
    if zscoring == 1
        feature_table = zscore(feature_table);
    end
    massive_feature_table = [massive_feature_table feature_table];
end

massive_feature_table = [massive_feature_table key_struct.P(:,end)];
band_names = [band_names; string('Gait')];
massive_feature_table = array2table(massive_feature_table,"VariableNames",band_names);
