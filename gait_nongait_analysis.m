scripts_path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Scripts';
addpath(scripts_path);

path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

rover_stack = rover_report('RCS_02');
P_gait_0 = [];
F_gait_0 = [];
P_nongait_0 = [];
F_nongait_0 = [];

P_gait_1 = [];
F_gait_1 = [];
P_nongait_1 = [];
F_nongait_1 = [];

P_gait_2 = [];
F_gait_2 = [];
P_nongait_2 = [];
F_nongait_2 = [];

P_gait_3 = [];
F_gait_3 = [];
P_nongait_3 = [];
F_nongait_3 = [];


for i = [1:3 5:8]
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = post_align(file,1);
    update = ['Labeling ' num2str(file)];
    disp(update)
    post_align_struct = label_rover(post_align_struct,rover_stack);
    update = ['Chunking ' num2str(file)];
    disp(update)
    post_align_struct = chunk(post_align_struct,10,1);
    update = ['Filtering ' num2str(file)];
    disp(update)
    post_align_struct = filter_lfp(post_align_struct,1,200,1);
    update = ['Analyzing ' num2str(file)];
    disp(update)

    [P_gait_0_temp,F_gait_0_temp,P_nongait_0_temp,F_nongait_0_temp] = psd_analysis(post_align_struct,0,0);
    P_gait_0 = [P_gait_0 P_gait_0_temp];
    F_gait_0 = [F_gait_0 F_gait_0_temp];
    P_nongait_0 = [P_nongait_0 P_nongait_0_temp];
    F_nongait_0 = [F_nongait_0 F_nongait_0_temp];

    [P_gait_1_temp,F_gait_1_temp,P_nongait_1_temp,F_nongait_1_temp] = psd_analysis(post_align_struct,1,0);
    P_gait_1 = [P_gait_1 P_gait_1_temp];
    F_gait_1 = [F_gait_1 F_gait_1_temp];
    P_nongait_1 = [P_nongait_1 P_nongait_1_temp];
    F_nongait_1 = [F_nongait_1 F_nongait_1_temp];

    [P_gait_2_temp,F_gait_2_temp,P_nongait_2_temp,F_nongait_2_temp] = psd_analysis(post_align_struct,2,0);
    P_gait_2 = [P_gait_2 P_gait_2_temp];
    F_gait_2 = [F_gait_2 F_gait_2_temp];
    P_nongait_2 = [P_nongait_2 P_nongait_2_temp];
    F_nongait_2 = [F_nongait_2 F_nongait_2_temp];

    [P_gait_3_temp,F_gait_3_temp,P_nongait_3_temp,F_nongait_3_temp] = psd_analysis(post_align_struct,3,0);
    P_gait_3 = [P_gait_3 P_gait_3_temp];
    F_gait_3 = [F_gait_3 F_gait_3_temp];
    P_nongait_3 = [P_nongait_3 P_nongait_3_temp];
    F_nongait_3 = [F_nongait_3 F_nongait_3_temp];

end

%% Create structures
RCS02_poststim_key0 = struct();
RCS02_poststim_key0.P_gait_0 = P_gait_0;
RCS02_poststim_key0.F_gait_0 = F_gait_0;
RCS02_poststim_key0.P_nongait_0 = P_nongait_0;
RCS02_poststim_key0.F_nongait_0 = F_nongait_0;

RCS02_poststim_key1 = struct();
RCS02_poststim_key1.P_gait_1 = P_gait_1;
RCS02_poststim_key1.F_gait_1 = F_gait_1;
RCS02_poststim_key1.P_nongait_1 = P_nongait_1;
RCS02_poststim_key1.F_nongait_1 = F_nongait_1;

RCS02_poststim_key2 = struct();
RCS02_poststim_key2.P_gait_2 = P_gait_2;
RCS02_poststim_key2.F_gait_2 = F_gait_2;
RCS02_poststim_key2.P_nongait_2 = P_nongait_2;
RCS02_poststim_key2.F_nongait_2 = F_nongait_2;

RCS02_poststim_key3 = struct();
RCS02_poststim_key3.P_gait_3 = P_gait_3;
RCS02_poststim_key3.F_gait_3 = F_gait_3;
RCS02_poststim_key3.P_nongait_3 = P_nongait_3;
RCS02_poststim_key3.F_nongait_3 = F_nongait_3;

%% KEY 0 FIGURE GENERATOR: Average PSD and subplot to focus on low frequencies

figure(9)
title('RCS02 Average Power Spectral Density (Key0)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(RCS02_prestim_key0.F_gait_0(:,1),10*log10(mean(RCS02_prestim_key0.P_gait_0,2)),'b')
std_gait = std(RCS02_prestim_key0.P_gait_0,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key0.P_gait_0,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key0.P_gait_0,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key0.P_gait_0,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key0.P_gait_0,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key0.F_gait_0(:,1)', fliplr((RCS02_prestim_key0.F_gait_0(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key0.F_nongait_0(:,1),10*log10(mean(RCS02_prestim_key0.P_nongait_0,2)),'r')
std_nongait = std(RCS02_prestim_key0.P_nongait_0,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key0.P_nongait_0,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key0.P_nongait_0,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key0.P_nongait_0,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key0.P_nongait_0,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key0.F_nongait_0(:,1)', fliplr((RCS02_prestim_key0.F_nongait_0(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend('Gait','','Non-Gait')
%rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
%rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
%rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
%rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
grey = [128, 128, 128] / 255;
rectangle('Position',[1.5,-65,18.5,40],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
xlim([1 90])
ylim([-80 -25])
hold off 

figure(10)
hold on 
plot(RCS02_prestim_key0.F_gait_0(:,1),10*log10(mean(RCS02_prestim_key0.P_gait_0,2)),'b')
std_gait = std(RCS02_prestim_key0.P_gait_0,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key0.P_gait_0,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key0.P_gait_0,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key0.P_gait_0,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key0.P_gait_0,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key0.F_gait_0(:,1)', fliplr((RCS02_prestim_key0.F_gait_0(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key0.F_nongait_0(:,1),10*log10(mean(RCS02_prestim_key0.P_nongait_0,2)),'r')
std_nongait = std(RCS02_prestim_key0.P_nongait_0,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key0.P_nongait_0,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key0.P_nongait_0,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key0.P_nongait_0,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key0.P_nongait_0,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key0.F_nongait_0(:,1)', fliplr((RCS02_prestim_key0.F_nongait_0(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend("off")
xlim([1 20])
ylim([-65 -25])
hold off

%% KEY 0 FIGURE GENERATOR: Boxchart comparing average power in canonical bands

test_data = RCS02_prestim_key0;
test_data.P_gait_0 = (test_data.P_gait_0)';
test_data.P_gait_0 = [test_data.P_gait_0 2*ones(size(test_data.P_gait_0,1),1)];
test_data.P_nongait_0 = (test_data.P_nongait_0)';
test_data.P_nongait_0 = [test_data.P_nongait_0 ones(size(test_data.P_nongait_0,1),1)];

all_power_data = [test_data.P_gait_0; test_data.P_nongait_0];

delta_f = [1 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 20];
high_beta_f = [20 30];
gamma_f = [30 90];
all_f = [delta_f; theta_f; alpha_f; beta_f; high_beta_f; gamma_f];

band_data = [];

for i = 1:size(all_power_data,1)
    for j = 1:size(all_f,1)
        [~,start_idx] = min(abs(test_data.F_gait_0(:,1)-all_f(j,1)));
        [~,end_idx] = min(abs(test_data.F_gait_0(:,1)-all_f(j,2)));
        temp_power = mean(all_power_data(i,start_idx:end_idx),2);
        band_data(i,j) = temp_power;
    end
end

band_data = [band_data all_power_data(:,2502)];
band_names = {"delta","theta","alpha","beta","high beta","gamma"};
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
p_hbeta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(2)));
p_gamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(2)));
sig_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma] < 0.05;

figure(1)
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
title('RCS02 Average Power/Frequency in Canonical Frequency Bands - Key0 Pre-Stim')
for i = 1:numGroups
    if sig_cats(i)
        x_pos = i;
        y_pos = max(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == band_names{i})) + 2;
        plot([x_pos-0.25 x_pos+0.25], [y_pos, y_pos], 'k-', 'LineWidth', 1.5);
        x_star = x_pos;
        y_star = y_pos + 0.5;
        text(x_star, y_star, '***', 'HorizontalAlignment', 'center', 'FontSize', 14);
    end
end
b(1).SeriesIndex = 2;
b(2).SeriesIndex = 1;
legend({'Non-Gait','Gait'})
band_names_wranges = {'delta (1-4)','theta (4-8)','alpha (8-12)','beta (12-20)','high beta (20-30)','gamma (30-90)'};
set(gca, 'XTickLabel', band_names_wranges)
hold off;

%% KEY 1 FIGURE GENERATOR: AVERAGE PSD

figure(9)
title('RCS02 Average Power Spectral Density (Key1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(RCS02_prestim_key1.F_gait_1(:,1),10*log10(mean(RCS02_prestim_key1.P_gait_1,2)),'b')
std_gait = std(RCS02_prestim_key1.P_gait_1,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key1.P_gait_1,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key1.P_gait_1,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key1.P_gait_1,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key1.P_gait_1,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key1.F_gait_1(:,1)', fliplr((RCS02_prestim_key1.F_gait_1(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key1.F_nongait_1(:,1),10*log10(mean(RCS02_prestim_key1.P_nongait_1,2)),'r')
std_nongait = std(RCS02_prestim_key1.P_nongait_1,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key1.P_nongait_1,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key1.P_nongait_1,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key1.P_nongait_1,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key1.P_nongait_1,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key1.F_nongait_1(:,1)', fliplr((RCS02_prestim_key1.F_nongait_1(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend('Gait','','Non-Gait')
%rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
%rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
%rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
%rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
grey = [128, 128, 128] / 255;
rectangle('Position',[1.5,-65,18.5,40],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
xlim([1 90])
ylim([-80 -25])
hold off 

figure(10)
hold on 
plot(RCS02_prestim_key1.F_gait_1(:,1),10*log10(mean(RCS02_prestim_key1.P_gait_1,2)),'b')
std_gait = std(RCS02_prestim_key1.P_gait_1,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key1.P_gait_1,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key1.P_gait_1,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key1.P_gait_1,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key1.P_gait_1,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key1.F_gait_1(:,1)', fliplr((RCS02_prestim_key1.F_gait_1(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key1.F_nongait_1(:,1),10*log10(mean(RCS02_prestim_key1.P_nongait_1,2)),'r')
std_nongait = std(RCS02_prestim_key1.P_nongait_1,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key1.P_nongait_1,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key1.P_nongait_1,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key1.P_nongait_1,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key1.P_nongait_1,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key1.F_nongait_1(:,1)', fliplr((RCS02_prestim_key1.F_nongait_1(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend("off")
xlim([1 20])
ylim([-65 -25])
hold off

%% KEY 1 FIGURE GENERATOR: Boxchart comparing average power in canonical bands

test_data = RCS02_prestim_key1;
test_data.P_gait_1 = (test_data.P_gait_1)';
test_data.P_gait_1 = [test_data.P_gait_1 2*ones(size(test_data.P_gait_1,1),1)];
test_data.P_nongait_1 = (test_data.P_nongait_1)';
test_data.P_nongait_1 = [test_data.P_nongait_1 ones(size(test_data.P_nongait_1,1),1)];

all_power_data = [test_data.P_gait_1; test_data.P_nongait_1];

delta_f = [1 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 20];
high_beta_f = [20 30];
gamma_f = [30 90];
all_f = [delta_f; theta_f; alpha_f; beta_f; high_beta_f; gamma_f];

band_data = [];

for i = 1:size(all_power_data,1)
    for j = 1:size(all_f,1)
        [~,start_idx] = min(abs(test_data.F_gait_1(:,1)-all_f(j,1)));
        [~,end_idx] = min(abs(test_data.F_gait_1(:,1)-all_f(j,2)));
        temp_power = mean(all_power_data(i,start_idx:end_idx),2);
        band_data(i,j) = temp_power;
    end
end

band_data = [band_data all_power_data(:,2502)];
band_names = {"delta","theta","alpha","beta","high beta","gamma"};
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
p_hbeta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(2)));
p_gamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(2)));
sig_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma] < 0.05;

figure(1)
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
title('RCS02 Average Power/Frequency in Canonical Frequency Bands - Key1 Pre-Stim')
for i = 1:numGroups
    if sig_cats(i)
        x_pos = i;
        y_pos = max(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == band_names{i})) + 2;
        plot([x_pos-0.25 x_pos+0.25], [y_pos, y_pos], 'k-', 'LineWidth', 1.5);
        x_star = x_pos;
        y_star = y_pos + 0.5;
        text(x_star, y_star, '***', 'HorizontalAlignment', 'center', 'FontSize', 14);
    end
end
b(1).SeriesIndex = 2;
b(2).SeriesIndex = 1;
legend({'Non-Gait','Gait'})
band_names_wranges = {'delta (1-4)','theta (4-8)','alpha (8-12)','beta (12-20)','high beta (20-30)','gamma (30-90)'};
set(gca, 'XTickLabel', band_names_wranges)
hold off;

%% KEY 2 FIGURE GENERATOR: AVERAGE PSD

figure(9)
title('RCS02 Average Power Spectral Density (Key2)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(RCS02_prestim_key2.F_gait_2(:,1),10*log10(mean(RCS02_prestim_key2.P_gait_2,2)),'b')
std_gait = std(RCS02_prestim_key2.P_gait_2,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key2.P_gait_2,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key2.P_gait_2,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key2.P_gait_2,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key2.P_gait_2,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key2.F_gait_2(:,1)', fliplr((RCS02_prestim_key2.F_gait_2(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key2.F_nongait_2(:,1),10*log10(mean(RCS02_prestim_key2.P_nongait_2,2)),'r')
std_nongait = std(RCS02_prestim_key2.P_nongait_2,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key2.P_nongait_2,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key2.P_nongait_2,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key2.P_nongait_2,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key2.P_nongait_2,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key2.F_nongait_2(:,1)', fliplr((RCS02_prestim_key2.F_nongait_2(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend('Gait','','Non-Gait')
%rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
%rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
%rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
%rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
grey = [128, 128, 128] / 255;
rectangle('Position',[1.5,-65,18.5,40],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
xlim([1 90])
ylim([-80 -25])
hold off 

figure(10)
hold on 
plot(RCS02_prestim_key2.F_gait_2(:,1),10*log10(mean(RCS02_prestim_key2.P_gait_2,2)),'b')
std_gait = std(RCS02_prestim_key2.P_gait_2,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key2.P_gait_2,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key2.P_gait_2,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key2.P_gait_2,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key2.P_gait_2,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key2.F_gait_2(:,1)', fliplr((RCS02_prestim_key2.F_gait_2(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key2.F_nongait_2(:,1),10*log10(mean(RCS02_prestim_key2.P_nongait_2,2)),'r')
std_nongait = std(RCS02_prestim_key2.P_nongait_2,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key2.P_nongait_2,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key2.P_nongait_2,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key2.P_nongait_2,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key2.P_nongait_2,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key2.F_nongait_2(:,1)', fliplr((RCS02_prestim_key2.F_nongait_2(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend("off")
xlim([1 20])
ylim([-50 -30])
hold off

%% KEY 2 FIGURE GENERATOR: Boxchart comparing average power in canonical bands

test_data = RCS02_prestim_key2;
test_data.P_gait_2 = (test_data.P_gait_2)';
test_data.P_gait_2 = [test_data.P_gait_2 2*ones(size(test_data.P_gait_2,1),1)];
test_data.P_nongait_2 = (test_data.P_nongait_2)';
test_data.P_nongait_2 = [test_data.P_nongait_2 ones(size(test_data.P_nongait_2,1),1)];

all_power_data = [test_data.P_gait_2; test_data.P_nongait_2];

delta_f = [1 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 20];
high_beta_f = [20 30];
gamma_f = [30 90];
all_f = [delta_f; theta_f; alpha_f; beta_f; high_beta_f; gamma_f];

band_data = [];

for i = 1:size(all_power_data,1)
    for j = 1:size(all_f,1)
        [~,start_idx] = min(abs(test_data.F_gait_2(:,1)-all_f(j,1)));
        [~,end_idx] = min(abs(test_data.F_gait_2(:,1)-all_f(j,2)));
        temp_power = mean(all_power_data(i,start_idx:end_idx),2);
        band_data(i,j) = temp_power;
    end
end

band_data = [band_data all_power_data(:,2502)];
band_names = {"delta","theta","alpha","beta","high beta","gamma"};
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
p_hbeta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(2)));
p_gamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(2)));
p_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma]; 
sig_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma] < 0.05;

figure(1)
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
title('RCS02 Average Power/Frequency in Canonical Frequency Bands - Key2 Pre-Stim')
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
band_names_wranges = {'delta (1-4)','theta (4-8)','alpha (8-12)','beta (12-20)','high beta (20-30)','gamma (30-90)'};
set(gca, 'XTickLabel', band_names_wranges)
hold off;

%% KEY 3 FIGURE GENERATOR: AVERAGE PSD

figure(9)
title('RCS02 Average Power Spectral Density (Key3)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on 
plot(RCS02_prestim_key3.F_gait_3(:,1),10*log10(mean(RCS02_prestim_key3.P_gait_3,2)),'b')
std_gait = std(RCS02_prestim_key3.P_gait_3,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key3.P_gait_3,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key3.P_gait_3,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key3.P_gait_3,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key3.P_gait_3,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key3.F_gait_3(:,1)', fliplr((RCS02_prestim_key3.F_gait_3(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key3.F_nongait_3(:,1),10*log10(mean(RCS02_prestim_key3.P_nongait_3,2)),'r')
std_nongait = std(RCS02_prestim_key3.P_nongait_3,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key3.P_nongait_3,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key3.P_nongait_3,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key3.P_nongait_3,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key3.P_nongait_3,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key3.F_nongait_3(:,1)', fliplr((RCS02_prestim_key3.F_nongait_3(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend('Gait','','Non-Gait')
%rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
%rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
%rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
%rectangle('Position',[70,-100,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
grey = [128, 128, 128] / 255;
rectangle('Position',[1.5,-50,18.5,20],'FaceColor','none','EdgeColor',[0, 0, 0]); % focus region
xlim([1 90])
ylim([-80 -25])
hold off 

figure(10)
hold on 
plot(RCS02_prestim_key3.F_gait_3(:,1),10*log10(mean(RCS02_prestim_key3.P_gait_3,2)),'b')
std_gait = std(RCS02_prestim_key3.P_gait_3,[],2);
se_gait = std_gait / sqrt(size(RCS02_prestim_key3.P_gait_3,2));
alpha = 0.05;
t_gait = tinv(1 - alpha / 2, size(RCS02_prestim_key3.P_gait_3,2)-1);
lower_gait = 10*log10(mean(RCS02_prestim_key3.P_gait_3,2) - t_gait*se_gait);
upper_gait = 10*log10(mean(RCS02_prestim_key3.P_gait_3,2) + t_gait*se_gait);
x_conf_gait = [RCS02_prestim_key3.F_gait_3(:,1)', fliplr((RCS02_prestim_key3.F_gait_3(:,1))')];
y_conf_gait = [lower_gait', fliplr((upper_gait)')];
fill(x_conf_gait,y_conf_gait,'b','FaceAlpha',0.3,'EdgeColor','none')
plot(RCS02_prestim_key3.F_nongait_3(:,1),10*log10(mean(RCS02_prestim_key3.P_nongait_3,2)),'r')
std_nongait = std(RCS02_prestim_key3.P_nongait_3,[],2);
se_nongait = std_nongait / sqrt(size(RCS02_prestim_key3.P_nongait_3,2));
alpha = 0.05;
t_nongait = tinv(1 - alpha / 2, size(RCS02_prestim_key3.P_nongait_3,2)-1);
lower_nongait = 10*log10(mean(RCS02_prestim_key3.P_nongait_3,2) - t_nongait*se_nongait);
upper_nongait = 10*log10(mean(RCS02_prestim_key3.P_nongait_3,2) + t_nongait*se_nongait);
x_conf_nongait = [RCS02_prestim_key3.F_nongait_3(:,1)', fliplr((RCS02_prestim_key3.F_nongait_3(:,1))')];
y_conf_nongait = [lower_nongait', fliplr((upper_nongait)')];
rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta      
rectangle('Position',[4,-100,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
rectangle('Position',[8,-100,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
rectangle('Position',[13,-100,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
fill(x_conf_nongait,y_conf_nongait,'r','FaceAlpha',0.3,'EdgeColor','none')
legend("off")
xlim([1 20])
ylim([-50 -30])
hold off

%% KEY 3 FIGURE GENERATOR: Boxchart comparing average power in canonical bands

test_data = RCS02_prestim_key3;
test_data.P_gait_3 = (test_data.P_gait_3)';
test_data.P_gait_3 = [test_data.P_gait_3 2*ones(size(test_data.P_gait_3,1),1)];
test_data.P_nongait_3 = (test_data.P_nongait_3)';
test_data.P_nongait_3 = [test_data.P_nongait_3 ones(size(test_data.P_nongait_3,1),1)];

all_power_data = [test_data.P_gait_3; test_data.P_nongait_3];

delta_f = [1 4];
theta_f = [4 8];
alpha_f = [8 12];
beta_f = [12 20];
high_beta_f = [20 30];
gamma_f = [30 90];
all_f = [delta_f; theta_f; alpha_f; beta_f; high_beta_f; gamma_f];

band_data = [];

for i = 1:size(all_power_data,1)
    for j = 1:size(all_f,1)
        [~,start_idx] = min(abs(test_data.F_gait_3(:,1)-all_f(j,1)));
        [~,end_idx] = min(abs(test_data.F_gait_3(:,1)-all_f(j,2)));
        temp_power = mean(all_power_data(i,start_idx:end_idx),2);
        band_data(i,j) = temp_power;
    end
end

band_data = [band_data all_power_data(:,2502)];
band_names = {"delta","theta","alpha","beta","high beta","gamma"};
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
p_hbeta = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "high beta" & band_data_tbl.("Movement State") == categorical(2)));
p_gamma = ranksum(band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(1)), band_data_tbl.("Power/Frequency")(band_data_tbl.("Frequency Band") == "gamma" & band_data_tbl.("Movement State") == categorical(2)));
p_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma]; 
sig_cats = [p_delta p_theta p_alpha p_beta p_hbeta p_gamma] < 0.05;

figure(1)
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
title('RCS02 Average Power/Frequency in Canonical Frequency Bands - Key3 Pre-Stim')
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
band_names_wranges = {'delta (1-4)','theta (4-8)','alpha (8-12)','beta (12-20)','high beta (20-30)','gamma (30-90)'};
set(gca, 'XTickLabel', band_names_wranges)
hold off;


%% Some basic machine learning

[B,dev,stats] = mnrfit(band_data(:,1:6),band_data(:,7));

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
