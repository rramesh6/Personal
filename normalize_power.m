function [power_percent_structure, z_scored_structure] = normalize_power(struct,fig_power_percent,fig_z_scored_structure)

fields = fieldnames(struct);

freq = fields(contains(fields,'F_gait'));
freq_res = struct.(freq{:})(2,1) - struct.(freq{:})(1,1);
gait_power = fields(contains(fields, 'P_gait'));
total_power_gait = sum(struct.(gait_power{:}),1).*freq_res;
percent_power_gait = ((struct.(gait_power{:})*freq_res)./total_power_gait)*100;
nongait_power = fields(contains(fields, 'P_nongait'));
total_power_nongait = sum(struct.(nongait_power{:}),1).*freq_res;
percent_power_nongait = ((struct.(nongait_power{:})*freq_res)./total_power_nongait)*100;
power_percent_structure = struct;
power_percent_structure.(gait_power{:}) = percent_power_gait;
power_percent_structure.(nongait_power{:}) = percent_power_nongait;

if fig_power_percent == 1 || nargin < 3
    figure()
    hold on
    plot(power_percent_structure.(freq{:})(:,1),mean(power_percent_structure.(gait_power{:}),2),'b');
    plot(power_percent_structure.(freq{:})(:,1),mean(power_percent_structure.(nongait_power{:}),2),'r');
    legend('Gait','Non-Gait')
    xlabel('Frequency (Hz)')
    ylabel('Percent of Total Signal Power (%)')
    xlim([0 100])
    hold off
end

overall_raw = [struct.(gait_power{:}) struct.(nongait_power{:})];
overall_zscored = zscore(overall_raw,[],2);
zscored_powers_gait = overall_zscored(:,1:size(struct.(gait_power{:}),2));
zscored_powers_nongait = overall_zscored(:,((size(struct.(gait_power{:}),2)) + 1):size(overall_zscored,2));
%zscored_powers_gait = zscore(struct.(gait_power{:}));
%zscored_powers_nongait = zscore(struct.(nongait_power{:}));
z_scored_structure = struct;
z_scored_structure.(gait_power{:}) = zscored_powers_gait;
z_scored_structure.(nongait_power{:}) = zscored_powers_nongait;

if fig_z_scored_structure == 1 || nargin < 3
    figure()
    hold on
    plot(z_scored_structure.(freq{:})(:,1),mean(z_scored_structure.(gait_power{:}),2),'b');
    plot(z_scored_structure.(freq{:})(:,1),mean(z_scored_structure.(nongait_power{:}),2),'r');
    xlabel('Frequency (Hz)')
    ylabel('Z-Scored Power')
    legend('Gait','Non-Gait')
    xlim([0 100])
    hold off
end


% test =  [[1:5]' 10*rand(5,1)];
% test_mean = mean(test,1);
% test_sd = std(test);
% test_minus_mean = test - test_mean;
% test_zscored = test_minus_mean./test_sd;

end