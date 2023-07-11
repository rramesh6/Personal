function percent_total_power(struct)

fields = fieldnames(struct);
gait_power = fields(contains(fields, 'P_gait'));
freq = fields(contains(fields,'F_gait'));
freq_res = struct.(freq{:})(2,1) - struct.(freq{:})(1,1);
total_power = sum(struct.(gait_power{:})(:,1))*freq_res;
percent_power = ((struct.(gait_power{:})(:,1)*freq_res)/total_power)*100;

zscored_powers = zscore(struct.(gait_power{:}));

struct.(gait_power{:}) - mean_powers

test =  [[1:5]' 10*rand(5,1)];
test_mean = mean(test,1);
test_sd = std(test);
test_minus_mean = test - test_mean;
test_zscored = test_minus_mean./test_sd;