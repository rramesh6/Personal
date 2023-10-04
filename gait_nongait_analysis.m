% add path to all the functions used in this analysis 
scripts_path = '/Users/Rithvik/Documents/UCSF/Research/wang_lab/Scripts';
addpath(scripts_path);
clear scripts_path;

% set path to location of aligned data 
%path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_05/v5_2023-06-06_Parameter-Testing_1/Data/Aligned Data/Aligned_Rover/At-Home Biomarker Validation';
path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

% read rover excel files for specified subject 
rover_stack = rover_report('RCS_02');

%%

% create some empty matrices for storing the PSD information 
P_gait_0 = [];
F_gait_0 = [];
chunks_gait_0 = [];
P_nongait_0 = [];
F_nongait_0 = [];
chunks_nongait_0 = [];

P_gait_1 = [];
F_gait_1 = [];
chunks_gait_1 = [];
P_nongait_1 = [];
F_nongait_1 = [];
chunks_nongait_1 = [];

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

% coh_1_2_gait = [];
% coh_2_3_gait = [];
% coh_1_3_gait = [];
% coh_1_2_nongait = [];
% coh_2_3_nongait = [];
% coh_1_3_nongait = [];


% Use anything in i = 14:24 for RCS-02 pre-stim data, everything else = post 
% For RCS_04, use [1,2,4,6,9,10]
% For RCS_05 poststim, use 16:size(names,2)

for i = 1:13
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = post_align(file,1);
    update = ['Labeling ' num2str(file)];
    disp(update)
    post_align_struct = label_rover(post_align_struct,rover_stack);
    update = ['Chunking ' num2str(file)];
    disp(update)
    post_align_struct = chunk(post_align_struct,10,1,0);
    update = ['Filtering ' num2str(file)];
    disp(update)
    post_align_struct = filter_lfp(post_align_struct,1,120,4,150.6,1);
%     if i == 2 
%         post_align_struct = filter_lfp(post_align_struct,1,120,1,120,4);
%     elseif i == 3 
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

    [P_gait_1_temp,F_gait_1_temp,chunks_gait_1_temp,P_nongait_1_temp,F_nongait_1_temp,chunks_nongait_1_temp] = psd_analysis(post_align_struct,1,0,side);
    P_gait_1 = [P_gait_1 P_gait_1_temp];
    F_gait_1 = [F_gait_1 F_gait_1_temp];
    chunks_gait_1 = [chunks_gait_1 chunks_gait_1_temp];
    P_nongait_1 = [P_nongait_1 P_nongait_1_temp];
    F_nongait_1 = [F_nongait_1 F_nongait_1_temp];
    chunks_nongait_1 = [chunks_nongait_1 chunks_nongait_1_temp];

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

%     [C_1_2_gait, C_2_3_gait, C_1_3_gait, C_1_2_nongait, C_2_3_nongait, C_1_3_nongait] = coherence_analysis(post_align_struct);
% 
%     coh_1_2_gait = [coh_1_2_gait C_1_2_gait];
%     coh_2_3_gait = [coh_2_3_gait C_2_3_gait];
%     coh_1_3_gait = [coh_1_3_gait C_1_3_gait];
%     coh_1_2_nongait = [coh_1_2_nongait C_1_2_nongait];
%     coh_2_3_nongait = [coh_2_3_nongait C_2_3_nongait];
%     coh_1_3_nongait = [coh_1_3_nongait C_1_3_nongait];


end

%% Create structures

RCS02_test_key1 = struct();
RCS02_test_key1.P_gait_1 = P_gait_1;
RCS02_test_key1.F_gait_1 = F_gait_1;
RCS02_test_key1.chunks_gait_1 = chunks_gait_1;
RCS02_test_key1.P_nongait_1 = P_nongait_1;
RCS02_test_key1.F_nongait_1 = F_nongait_1;
RCS02_test_key1.chunks_nongait_1 = chunks_nongait_1;

RCS02_prestim_key0 = struct();
RCS02_prestim_key0.P_gait_0 = P_gait_0;
RCS02_prestim_key0.F_gait_0 = F_gait_0;
RCS02_prestim_key0.chunks_gait_0 = chunks_gait_0;
RCS02_prestim_key0.P_nongait_0 = P_nongait_0;
RCS02_prestim_key0.F_nongait_0 = F_nongait_0;
RCS02_prestim_key0.chunks_nongait_0 = chunks_nongait_0;

RCS02_prestim_key1 = struct();
RCS02_prestim_key1.P_gait_1 = P_gait_1;
RCS02_prestim_key1.F_gait_1 = F_gait_1;
RCS02_prestim_key1.chunks_gait_1 = chunks_gait_1;
RCS02_prestim_key1.P_nongait_1 = P_nongait_1;
RCS02_prestim_key1.F_nongait_1 = F_nongait_1;
RCS02_prestim_key1.chunks_nongait_1 = chunks_nongait_1;

RCS02_prestim_key2 = struct();
RCS02_prestim_key2.P_gait_2 = P_gait_2;
RCS02_prestim_key2.F_gait_2 = F_gait_2;
RCS02_prestim_key2.chunks_gait_2 = chunks_gait_2;
RCS02_prestim_key2.P_nongait_2 = P_nongait_2;
RCS02_prestim_key2.F_nongait_2 = F_nongait_2;
RCS02_prestim_key2.chunks_nongait_2 = chunks_nongait_2;

RCS02_prestim_key3 = struct();
RCS02_prestim_key3.P_gait_3 = P_gait_3;
RCS02_prestim_key3.F_gait_3 = F_gait_3;
RCS02_prestim_key3.chunks_gait_3 = chunks_gait_3;
RCS02_prestim_key3.P_nongait_3 = P_nongait_3;
RCS02_prestim_key3.F_nongait_3 = F_nongait_3;
RCS02_prestim_key3.chunks_nongait_3 = chunks_nongait_3;

%% FOR RCS05 

RCS05_key0_poststim = throw_session(RCS05_key0,'020223');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'020523');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'020923');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'021223');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'021523');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'021923');
RCS05_key0_poststim = throw_session(RCS05_key0_poststim,'030123');

RCS05_key1_poststim = throw_session(RCS05_key1,'020223');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'020523');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'020923');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'021223');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'021523');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'021923');
RCS05_key1_poststim = throw_session(RCS05_key1_poststim,'030123');

RCS05_key2_poststim = throw_session(RCS05_key2,'020223');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'020523');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'020923');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'021223');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'021523');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'021923');
RCS05_key2_poststim = throw_session(RCS05_key2_poststim,'030123');

RCS05_key3_poststim = throw_session(RCS05_key3,'020223');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'020523');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'020923');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'021223');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'021523');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'021923');
RCS05_key3_poststim = throw_session(RCS05_key3_poststim,'030123');

%%

RCS05_prefilter_key0 = struct();
RCS05_prefilter_key0.P_gait_0 = P_gait_0;
RCS05_prefilter_key0.F_gait_0 = F_gait_0;
RCS05_prefilter_key0.chunks_gait_0 = chunks_gait_0;
RCS05_prefilter_key0.P_nongait_0 = P_nongait_0;
RCS05_prefilter_key0.F_nongait_0 = F_nongait_0;
RCS05_prefilter_key0.chunks_nongait_0 = chunks_nongait_0;

RCS05_prefilter_key1 = struct();
RCS05_prefilter_key1.P_gait_1 = P_gait_1;
RCS05_prefilter_key1.F_gait_1 = F_gait_1;
RCS05_prefilter_key1.chunks_gait_1 = chunks_gait_1;
RCS05_prefilter_key1.P_nongait_1 = P_nongait_1;
RCS05_prefilter_key1.F_nongait_1 = F_nongait_1;
RCS05_prefilter_key1.chunks_nongait_1 = chunks_nongait_1;

RCS05_prefilter_key2 = struct();
RCS05_prefilter_key2.P_gait_2 = P_gait_2;
RCS05_prefilter_key2.F_gait_2 = F_gait_2;
RCS05_prefilter_key2.chunks_gait_2 = chunks_gait_2;
RCS05_prefilter_key2.P_nongait_2 = P_nongait_2;
RCS05_prefilter_key2.F_nongait_2 = F_nongait_2;
RCS05_prefilter_key2.chunks_nongait_2 = chunks_nongait_2;

RCS05_prefilter_key3 = struct();
RCS05_prefilter_key3.P_gait_3 = P_gait_3;
RCS05_prefilter_key3.F_gait_3 = F_gait_3;
RCS05_prefilter_key3.chunks_gait_3 = chunks_gait_3;
RCS05_prefilter_key3.P_nongait_3 = P_nongait_3;
RCS05_prefilter_key3.F_nongait_3 = F_nongait_3;
RCS05_prefilter_key3.chunks_nongait_3 = chunks_nongait_3;

%%
RCS05_postfilter_key0 = struct();
RCS05_postfilter_key0.P_gait_0 = P_gait_0;
RCS05_postfilter_key0.F_gait_0 = F_gait_0;
RCS05_postfilter_key0.chunks_gait_0 = chunks_gait_0;
RCS05_postfilter_key0.P_nongait_0 = P_nongait_0;
RCS05_postfilter_key0.F_nongait_0 = F_nongait_0;
RCS05_postfilter_key0.chunks_nongait_0 = chunks_nongait_0;

RCS05_postfilter_key1 = struct();
RCS05_postfilter_key1.P_gait_1 = P_gait_1;
RCS05_postfilter_key1.F_gait_1 = F_gait_1;
RCS05_postfilter_key1.chunks_gait_1 = chunks_gait_1;
RCS05_postfilter_key1.P_nongait_1 = P_nongait_1;
RCS05_postfilter_key1.F_nongait_1 = F_nongait_1;
RCS05_postfilter_key1.chunks_nongait_1 = chunks_nongait_1;

RCS05_postfilter_key2 = struct();
RCS05_postfilter_key2.P_gait_2 = P_gait_2;
RCS05_postfilter_key2.F_gait_2 = F_gait_2;
RCS05_postfilter_key2.chunks_gait_2 = chunks_gait_2;
RCS05_postfilter_key2.P_nongait_2 = P_nongait_2;
RCS05_postfilter_key2.F_nongait_2 = F_nongait_2;
RCS05_postfilter_key2.chunks_nongait_2 = chunks_nongait_2;

RCS05_postfilter_key3 = struct();
RCS05_postfilter_key3.P_gait_3 = P_gait_3;
RCS05_postfilter_key3.F_gait_3 = F_gait_3;
RCS05_postfilter_key3.chunks_gait_3 = chunks_gait_3;
RCS05_postfilter_key3.P_nongait_3 = P_nongait_3;
RCS05_postfilter_key3.F_nongait_3 = F_nongait_3;
RCS05_postfilter_key3.chunks_nongait_3 = chunks_nongait_3;

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

%%

RCS05_poststim_noroverloss_key0 = struct();
RCS05_poststim_noroverloss_key0.P_gait_0 = P_gait_0;
RCS05_poststim_noroverloss_key0.F_gait_0 = F_gait_0;
RCS05_poststim_noroverloss_key0.chunks_gait_0 = chunks_gait_0;
RCS05_poststim_noroverloss_key0.P_nongait_0 = P_nongait_0;
RCS05_poststim_noroverloss_key0.F_nongait_0 = F_nongait_0;
RCS05_poststim_noroverloss_key0.chunks_nongait_0 = chunks_nongait_0;

RCS05_poststim_noroverloss_key1 = struct();
RCS05_poststim_noroverloss_key1.P_gait_1 = P_gait_1;
RCS05_poststim_noroverloss_key1.F_gait_1 = F_gait_1;
RCS05_poststim_noroverloss_key1.chunks_gait_1 = chunks_gait_1;
RCS05_poststim_noroverloss_key1.P_nongait_1 = P_nongait_1;
RCS05_poststim_noroverloss_key1.F_nongait_1 = F_nongait_1;
RCS05_poststim_noroverloss_key1.chunks_nongait_1 = chunks_nongait_1;

RCS05_poststim_noroverloss_key2 = struct();
RCS05_poststim_noroverloss_key2.P_gait_2 = P_gait_2;
RCS05_poststim_noroverloss_key2.F_gait_2 = F_gait_2;
RCS05_poststim_noroverloss_key2.chunks_gait_2 = chunks_gait_2;
RCS05_poststim_noroverloss_key2.P_nongait_2 = P_nongait_2;
RCS05_poststim_noroverloss_key2.F_nongait_2 = F_nongait_2;
RCS05_poststim_noroverloss_key2.chunks_nongait_2 = chunks_nongait_2;

RCS05_poststim_noroverloss_key3 = struct();
RCS05_poststim_noroverloss_key3.P_gait_3 = P_gait_3;
RCS05_poststim_noroverloss_key3.F_gait_3 = F_gait_3;
RCS05_poststim_noroverloss_key3.chunks_gait_3 = chunks_gait_3;
RCS05_poststim_noroverloss_key3.P_nongait_3 = P_nongait_3;
RCS05_poststim_noroverloss_key3.F_nongait_3 = F_nongait_3;
RCS05_poststim_noroverloss_key3.chunks_nongait_3 = chunks_nongait_3;


