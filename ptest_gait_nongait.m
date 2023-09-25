%% set path to location of aligned data and to all scripts

% add path to all the functions used in this analysis 
scripts_path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Scripts';
addpath(scripts_path);
clear scripts_path;

path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/v5_2023-06-06_Parameter-Testing_1/Data/Aligned Data/Only RCS';
%path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/RCS09/v2_2023-06-21_Parameter-Testing-Clinic/Data/Aligned Data/Only RCS - Rithvik';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

%% create some empty matrices for storing the PSD information 
P_gait_0 = [];
F_gait_0 = [];
chunks_gait_0 = [];
P_nongait_0 = [];
F_nongait_0 = [];
chunks_nongait_0 = [];

% P_gait_1 = [];
% F_gait_1 = [];
% chunks_gait_1 = [];
% P_nongait_1 = [];
% F_nongait_1 = [];
% chunks_nongait_1 = [];

P_gait_2 = [];
F_gait_2 = [];
chunks_gait_2 = [];
P_nongait_2 = [];
F_nongait_2 = [];
chunks_nongait_2 = [];

P_gait_3 = [];
F_gait_3 = [];
chunks_gait_3 = [];
P_nongait_3 = [];
F_nongait_3 = [];
chunks_nongait_3 = [];

for i = 1:size(names,2)
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = rcs_gait_extraction(file);
    update = ['Filtering ' num2str(file)];
    disp(update)
%     if i == 0
%         post_align_struct = filter_lfp(post_align_struct,1,120,1,120,4);
%     elseif i == 2 | i == 3
%         post_align_struct = filter_lfp(post_align_struct,1,120,1,120,3);
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,120,1);
%         post_align_struct = filter_lfp(post_align_struct,1,120,3,120,1);
%     elseif i == 1 | i == 4 
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,130,1);
%     elseif i == 7
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,130,0.5);
%     else
%         post_align_struct = filter_lfp(post_align_struct,1,120,0);
%     end
    post_align_struct = filter_lfp_nokey1(post_align_struct,1,120,4,30,0.01);
    update = ['Analyzing ' num2str(file)];
    disp(update)
    
    % specify which side to run: 0 = left, 1 = right
    side = 0; 

    [P_gait_0_temp,F_gait_0_temp,chunks_gait_0_temp,P_nongait_0_temp,F_nongait_0_temp,chunks_nongait_0_temp] = psd_analysis(post_align_struct,0,0,side);
    P_gait_0 = [P_gait_0 P_gait_0_temp];
    F_gait_0 = [F_gait_0 F_gait_0_temp];
    chunks_gait_0 = [chunks_gait_0 chunks_gait_0_temp];
    P_nongait_0 = [P_nongait_0 P_nongait_0_temp];
    F_nongait_0 = [F_nongait_0 F_nongait_0_temp];
    chunks_nongait_0 = [chunks_nongait_0 chunks_nongait_0_temp];

%     [P_gait_1_temp,F_gait_1_temp,chunks_gait_1_temp,P_nongait_1_temp,F_nongait_1_temp,chunks_nongait_1_temp] = psd_analysis(post_align_struct,1,0,side);
%     P_gait_1 = [P_gait_1 P_gait_1_temp];
%     F_gait_1 = [F_gait_1 F_gait_1_temp];
%     chunks_gait_1 = [chunks_gait_1 chunks_gait_1_temp];
%     P_nongait_1 = [P_nongait_1 P_nongait_1_temp];
%     F_nongait_1 = [F_nongait_1 F_nongait_1_temp];
%     chunks_nongait_1 = [chunks_nongait_1 chunks_nongait_1_temp];

    [P_gait_2_temp,F_gait_2_temp,chunks_gait_2_temp,P_nongait_2_temp,F_nongait_2_temp,chunks_nongait_2_temp] = psd_analysis(post_align_struct,2,0,side);
    P_gait_2 = [P_gait_2 P_gait_2_temp];
    F_gait_2 = [F_gait_2 F_gait_2_temp];
    chunks_gait_2 = [chunks_gait_2 chunks_gait_2_temp];
    P_nongait_2 = [P_nongait_2 P_nongait_2_temp];
    F_nongait_2 = [F_nongait_2 F_nongait_2_temp];
    chunks_nongait_2 = [chunks_nongait_2 chunks_nongait_2_temp];

    [P_gait_3_temp,F_gait_3_temp,chunks_gait_3_temp,P_nongait_3_temp,F_nongait_3_temp,chunks_nongait_3_temp] = psd_analysis(post_align_struct,3,0,side);
    P_gait_3 = [P_gait_3 P_gait_3_temp];
    F_gait_3 = [F_gait_3 F_gait_3_temp];
    chunks_gait_3 = [chunks_gait_3 chunks_gait_3_temp];
    P_nongait_3 = [P_nongait_3 P_nongait_3_temp];
    F_nongait_3 = [F_nongait_3 F_nongait_3_temp];
    chunks_nongait_3 = [chunks_nongait_3 chunks_nongait_3_temp];

end

%%

RCS05_ptest1_key0 = struct();
RCS05_ptest1_key0.P_gait_0 = P_gait_0;
RCS05_ptest1_key0.F_gait_0 = F_gait_0;
RCS05_ptest1_key0.chunks_gait_0 = chunks_gait_0;
RCS05_ptest1_key0.P_nongait_0 = P_nongait_0;
RCS05_ptest1_key0.F_nongait_0 = F_nongait_0;
RCS05_ptest1_key0.chunks_nongait_0 = chunks_nongait_0;

RCS05_ptest1_key1 = struct();
RCS05_ptest1_key1.P_gait_1 = P_gait_1;
RCS05_ptest1_key1.F_gait_1 = F_gait_1;
RCS05_ptest1_key1.chunks_gait_1 = chunks_gait_1;
RCS05_ptest1_key1.P_nongait_1 = P_nongait_1;
RCS05_ptest1_key1.F_nongait_1 = F_nongait_1;
RCS05_ptest1_key1.chunks_nongait_1 = chunks_nongait_1;

RCS05_ptest1_key2 = struct();
RCS05_ptest1_key2.P_gait_2 = P_gait_2;
RCS05_ptest1_key2.F_gait_2 = F_gait_2;
RCS05_ptest1_key2.chunks_gait_2 = chunks_gait_2;
RCS05_ptest1_key2.P_nongait_2 = P_nongait_2;
RCS05_ptest1_key2.F_nongait_2 = F_nongait_2;
RCS05_ptest1_key2.chunks_nongait_2 = chunks_nongait_2;

RCS05_ptest1_key3 = struct();
RCS05_ptest1_key3.P_gait_3 = P_gait_3;
RCS05_ptest1_key3.F_gait_3 = F_gait_3;
RCS05_ptest1_key3.chunks_gait_3 = chunks_gait_3;
RCS05_ptest1_key3.P_nongait_3 = P_nongait_3;
RCS05_ptest1_key3.F_nongait_3 = F_nongait_3;
RCS05_ptest1_key3.chunks_nongait_3 = chunks_nongait_3;

%% set path to location of aligned data 
%path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/v5_2023-06-06_Parameter-Testing_1/Data/Aligned Data/Only RCS';
path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/RCS09/v2_2023-06-21_Parameter-Testing-Clinic/Data/Aligned Data/Only RCS - Rithvik';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

%% create some empty matrices for storing the PSD information 
P_gait_0 = [];
F_gait_0 = [];
chunks_gait_0 = [];
P_nongait_0 = [];
F_nongait_0 = [];
chunks_nongait_0 = [];

% P_gait_1 = [];
% F_gait_1 = [];
% chunks_gait_1 = [];
% P_nongait_1 = [];
% F_nongait_1 = [];
% chunks_nongait_1 = [];

P_gait_2 = [];
F_gait_2 = [];
chunks_gait_2 = [];
P_nongait_2 = [];
F_nongait_2 = [];
chunks_nongait_2 = [];

P_gait_3 = [];
F_gait_3 = [];
chunks_gait_3 = [];
P_nongait_3 = [];
F_nongait_3 = [];
chunks_nongait_3 = [];

for i = 1:size(names,2)
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = rcs_gait_extraction(file);
    update = ['Filtering ' num2str(file)];
    disp(update)
%     if i == 0
%         post_align_struct = filter_lfp(post_align_struct,1,120,1,120,4);
%     elseif i == 2 | i == 3
%         post_align_struct = filter_lfp(post_align_struct,1,120,1,120,3);
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,120,1);
%         post_align_struct = filter_lfp(post_align_struct,1,120,3,120,1);
%     elseif i == 1 | i == 4 
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,130,1);
%     elseif i == 7
%         post_align_struct = filter_lfp(post_align_struct,1,120,2,130,0.5);
%     else
%         post_align_struct = filter_lfp(post_align_struct,1,120,0);
%     end
    post_align_struct = filter_lfp_nokey1(post_align_struct,1,120,0);
    update = ['Analyzing ' num2str(file)];
    disp(update)
    
    % specify which side to run: 0 = left, 1 = right
    side = 0; 

    [P_gait_0_temp,F_gait_0_temp,chunks_gait_0_temp,P_nongait_0_temp,F_nongait_0_temp,chunks_nongait_0_temp] = psd_analysis(post_align_struct,0,0,side);
    P_gait_0 = [P_gait_0 P_gait_0_temp];
    F_gait_0 = [F_gait_0 F_gait_0_temp];
    chunks_gait_0 = [chunks_gait_0 chunks_gait_0_temp];
    P_nongait_0 = [P_nongait_0 P_nongait_0_temp];
    F_nongait_0 = [F_nongait_0 F_nongait_0_temp];
    chunks_nongait_0 = [chunks_nongait_0 chunks_nongait_0_temp];

%     [P_gait_1_temp,F_gait_1_temp,chunks_gait_1_temp,P_nongait_1_temp,F_nongait_1_temp,chunks_nongait_1_temp] = psd_analysis(post_align_struct,1,0,side);
%     P_gait_1 = [P_gait_1 P_gait_1_temp];
%     F_gait_1 = [F_gait_1 F_gait_1_temp];
%     chunks_gait_1 = [chunks_gait_1 chunks_gait_1_temp];
%     P_nongait_1 = [P_nongait_1 P_nongait_1_temp];
%     F_nongait_1 = [F_nongait_1 F_nongait_1_temp];
%     chunks_nongait_1 = [chunks_nongait_1 chunks_nongait_1_temp];

    [P_gait_2_temp,F_gait_2_temp,chunks_gait_2_temp,P_nongait_2_temp,F_nongait_2_temp,chunks_nongait_2_temp] = psd_analysis(post_align_struct,2,0,side);
    P_gait_2 = [P_gait_2 P_gait_2_temp];
    F_gait_2 = [F_gait_2 F_gait_2_temp];
    chunks_gait_2 = [chunks_gait_2 chunks_gait_2_temp];
    P_nongait_2 = [P_nongait_2 P_nongait_2_temp];
    F_nongait_2 = [F_nongait_2 F_nongait_2_temp];
    chunks_nongait_2 = [chunks_nongait_2 chunks_nongait_2_temp];

    [P_gait_3_temp,F_gait_3_temp,chunks_gait_3_temp,P_nongait_3_temp,F_nongait_3_temp,chunks_nongait_3_temp] = psd_analysis(post_align_struct,3,0,side);
    P_gait_3 = [P_gait_3 P_gait_3_temp];
    F_gait_3 = [F_gait_3 F_gait_3_temp];
    chunks_gait_3 = [chunks_gait_3 chunks_gait_3_temp];
    P_nongait_3 = [P_nongait_3 P_nongait_3_temp];
    F_nongait_3 = [F_nongait_3 F_nongait_3_temp];
    chunks_nongait_3 = [chunks_nongait_3 chunks_nongait_3_temp];

end

%%

RCS09_ptest1_key0 = struct();
RCS09_ptest1_key0.P_gait_0 = P_gait_0;
RCS09_ptest1_key0.F_gait_0 = F_gait_0;
RCS09_ptest1_key0.chunks_gait_0 = chunks_gait_0;
RCS09_ptest1_key0.P_nongait_0 = P_nongait_0;
RCS09_ptest1_key0.F_nongait_0 = F_nongait_0;
RCS09_ptest1_key0.chunks_nongait_0 = chunks_nongait_0;

% RCS09_ptest1_key1 = struct();
% RCS09_ptest1_key1.P_gait_1 = P_gait_1;
% RCS09_ptest1_key1.F_gait_1 = F_gait_1;
% RCS09_ptest1_key1.chunks_gait_1 = chunks_gait_1;
% RCS09_ptest1_key1.P_nongait_1 = P_nongait_1;
% RCS09_ptest1_key1.F_nongait_1 = F_nongait_1;
% RCS09_ptest1_key1.chunks_nongait_1 = chunks_nongait_1;

RCS09_ptest1_key2 = struct();
RCS09_ptest1_key2.P_gait_2 = P_gait_2;
RCS09_ptest1_key2.F_gait_2 = F_gait_2;
RCS09_ptest1_key2.chunks_gait_2 = chunks_gait_2;
RCS09_ptest1_key2.P_nongait_2 = P_nongait_2;
RCS09_ptest1_key2.F_nongait_2 = F_nongait_2;
RCS09_ptest1_key2.chunks_nongait_2 = chunks_nongait_2;

RCS09_ptest1_key3 = struct();
RCS09_ptest1_key3.P_gait_3 = P_gait_3;
RCS09_ptest1_key3.F_gait_3 = F_gait_3;
RCS09_ptest1_key3.chunks_gait_3 = chunks_gait_3;
RCS09_ptest1_key3.P_nongait_3 = P_nongait_3;
RCS09_ptest1_key3.F_nongait_3 = F_nongait_3;
RCS09_ptest1_key3.chunks_nongait_3 = chunks_nongait_3;



