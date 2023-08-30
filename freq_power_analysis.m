function [feature_table, freq_power_table] = freq_power_analysis(struct,logtransform)

fields = fieldnames(struct);
P_gait = fields(contains(fields,'P_gait'));
F_gait = fields(contains(fields,'F_gait'));
P_nongait = fields(contains(fields,'P_nongait'));
F_nongait = fields(contains(fields,'F_nongait'));
P_gait = struct.(P_gait{:});
F_gait = struct.(F_gait{:});
P_nongait = struct.(P_nongait{:});
F_nongait = struct.(F_nongait{:});

delta_f = [1.5 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 30];
low_gamma_f = [30 70];
high_gamma_f = [70 100];
all_f = [delta_f; theta_f; alpha_f; beta_f; low_gamma_f; high_gamma_f];

bands = {'delta','theta','alpha','beta','low gamma','high gamma'};
freq_power_table = table('Size',[6,2],'VariableTypes',{'double','double'},'VariableNames',{'Gait','Non-Gait'},'RowNames',bands);

if logtransform == 1
    P_gait = 10*log10(P_gait);
    P_nongait = 10*log10(P_nongait);
end

for i = 1:size(all_f,1)
    [~,start_idx] = min(abs(F_gait(:,1)-all_f(i,1)));
    [~,end_idx] = min(abs(F_gait(:,1)-all_f(i,2)));
    average_power_gait = mean(mean(P_gait(start_idx:end_idx,:),2),1);
    freq_power_table.Gait(i) = average_power_gait;
    average_power_nongait = mean(mean(P_nongait(start_idx:end_idx,:),2),1);
    freq_power_table.("Non-Gait")(i) = average_power_nongait;
end

feature_table = ones(size(P_gait,2) + size(P_nongait,2),size(all_f,1));
for i = 1:size(all_f,1)
    [~,start_idx] = min(abs(F_gait(:,1)-all_f(i,1)));
    [~,end_idx] = min(abs(F_gait(:,1)-all_f(i,2)));
    average_power_gait = mean(P_gait(start_idx:end_idx,:),1);
    average_power_nongait = mean(P_nongait(start_idx:end_idx,:),1);
    feature_table(:,i) = [average_power_gait';average_power_nongait'];
end

% if logtransform == 1
%     feature_table = 10*log10(feature_table);
% end

gait_labels = [ones(size(P_gait,2),1); zeros(size(P_nongait,2),1)];

feature_table = [feature_table gait_labels];

end
