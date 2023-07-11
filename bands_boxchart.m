function bands_boxchart(psd_struct_in,key)

psd_struct = struct();
psd_struct.P_gait = psd_struct_in.(['P_gait_' num2str(key)]);
psd_struct.F_gait = psd_struct_in.(['F_gait_' num2str(key)]);
psd_struct.P_nongait = psd_struct_in.(['P_nongait_' num2str(key)]);
psd_struct.F_nongait = psd_struct_in.(['F_nongait_' num2str(key)]);

psd_struct.P_gait = (psd_struct.P_gait)';
psd_struct.P_gait = [psd_struct.P_gait 2*ones(size(psd_struct.P_gait,1),1)];
psd_struct.P_nongait = (psd_struct.P_nongait)';
psd_struct.P_nongait = [psd_struct.P_nongait ones(size(psd_struct.P_nongait,1),1)];

all_power_data = [psd_struct.P_gait; psd_struct.P_nongait];

delta_f = [1.5 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 30];
low_gamma_f = [30 70];
high_gamma_f = [70 100];
all_f = [delta_f; theta_f; alpha_f; beta_f; low_gamma_f; high_gamma_f];

band_data = [];

for i = 1:size(all_power_data,1)
    for j = 1:size(all_f,1)
        [~,start_idx] = min(abs(psd_struct.F_gait(:,1)-all_f(j,1)));
        [~,end_idx] = min(abs(psd_struct.F_gait(:,1)-all_f(j,2)));
        temp_power = mean(all_power_data(i,start_idx:end_idx),2);
        band_data(i,j) = temp_power;
    end
end

band_data = [band_data all_power_data(:,2502)];
band_names = {"delta","theta","alpha","beta","low gamma","high gamma"};
band_data_array = [];
band_names_array = [];
movement_state_array = [];

for i = 1:size(band_names,2)
    band_data_array = [band_data_array; band_data(:,i)];
    band_names_array = [band_names_array; repmat(band_names{i},size(band_data(:,i)))];
    movement_state_array = [movement_state_array; band_data(:,7)];
end

for i = 1:size(band_names,2)
    band_names{i} = char(band_names{i});
end

all_band_data_array = [band_names_array band_data_array movement_state_array];
column_names = {'Frequency Band','Power/Frequency','Movement State'};
band_data_tbl = array2table(all_band_data_array,"VariableNames",column_names);
band_data_tbl.("Power/Frequency") = double(band_data_tbl.("Power/Frequency"));
band_data_tbl.("Power/Frequency") = 10*log10(band_data_tbl.("Power/Frequency"));
band_data_tbl.("Frequency Band") = categorical(band_data_tbl.("Frequency Band"),band_names);
band_data_tbl.("Movement State") = categorical(band_data_tbl.("Movement State"));

p_delta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "delta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "delta" & band_data_tbl.("Movement State") == categorical(2)));
p_theta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "theta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "theta" & band_data_tbl.("Movement State") == categorical(2)));
p_alpha = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "alpha" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "alpha" & band_data_tbl.("Movement State") == categorical(2)));
p_beta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "beta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "beta" & band_data_tbl.("Movement State") == categorical(2)));
p_lowgamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "low gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "low gamma" & band_data_tbl.("Movement State") == categorical(2)));
p_highgamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high gamma" & band_data_tbl.("Movement State") == categorical(2)));
p_cats = [p_delta p_theta p_alpha p_beta p_lowgamma p_highgamma]; 
sig_cats = [p_delta p_theta p_alpha p_beta p_lowgamma p_highgamma] < 0.05;

figure()
b = boxchart(band_data_tbl.("Frequency Band"),band_data_tbl.("Power/Frequency"),'GroupByColor',band_data_tbl.("Movement State"))
xlabel('Frequency Band')
ylabel('Power/Frequency (dB/Hz)')
numGroups = size(unique(band_data_tbl.("Frequency Band")),1);
categoryCounts = countcats(unique(band_data_tbl.("Frequency Band")));
linePositions = cumsum(categoryCounts) - 0.5;
hold on;
for i = 2:length(linePositions)
    line([linePositions(i), linePositions(i)], ylim, 'Color', 'k', 'LineStyle', '--');
end
title(['RCS02 Average Power/Frequency in Canonical Frequency Bands - Key ' num2str(key)])
for i = 1:numGroups
    if sig_cats(i)
        x_pos = i;
        y_pos = max(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == band_names{i})) + 2;
        plot([x_pos-0.25 x_pos+0.25], [y_pos, y_pos], 'k-', 'LineWidth', 1.5);
        x_star = x_pos;
        y_star = y_pos + 0.5;
        if p_cats(i) < 0.05 & p_cats > 0.02
            text(x_star, y_star, '*', 'HorizontalAlignment', 'center', 'FontSize', 14);
        elseif p_cats(i) < 0.02 & p_cats(i) > 0.001
            text(x_star, y_star, '**', 'HorizontalAlignment', 'center', 'FontSize', 14);
        else
            text(x_star, y_star, '***', 'HorizontalAlignment', 'center', 'FontSize', 14);
        end
    end
end
b(1).SeriesIndex = 2;
b(2).SeriesIndex = 1;
legend({'Non-Gait','Gait'})
band_names_wranges = {'delta (1-4)','theta (4-8)','alpha (8-12)','beta (12-30)','low gamma (30-70)','high gamma (70-100)'};
set(gca, 'XTickLabel', band_names_wranges)
hold off;

