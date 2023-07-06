function freq_power_table = freq_power_analysis(P_gait,F_gait,P_nongait,F_nongait)
delta_f = [1 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 20];
high_beta_f = [20 30];
gamma_f = [30 90];
all_f = [delta_f; theta_f; alpha_f; beta_f; high_beta_f; gamma_f];

bands = {'delta','theta','alpha','beta','high beta','gamma'};
freq_power_table = table('Size',[6,2],'VariableTypes',{'double','double'},'VariableNames',{'Gait','Non-Gait'},'RowNames',bands);

for i = 1:size(all_f,1)
    [~,start_idx] = min(abs(F_gait(:,1)-all_f(i,1)));
    [~,end_idx] = min(abs(F_gait(:,1)-all_f(i,2)));
    average_power_gait = mean(mean(P_gait(start_idx:end_idx,:),2),1);
    freq_power_table.Gait(i) = average_power_gait;
    average_power_nongait = mean(mean(P_nongait(start_idx:end_idx,:),2),1);
    freq_power_table.("Non-Gait")(i) = average_power_nongait;
end
