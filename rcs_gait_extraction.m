
function post_align_struct = rcs_gait_extraction(file)

load(file);

period = 10;
ms = period*1000;

post_align_struct = aligned_data;

post_align_struct.left_Accel_table.NewTime = (post_align_struct.left_Accel_table.DerivedTime(:) - post_align_struct.left_Accel_table.DerivedTime(1));
num_periods = floor(post_align_struct.left_Accel_table.NewTime(end)/ms);

post_align_struct.overall_gait_periods = table();
post_align_struct.overall_gait_periods = addvars(post_align_struct.overall_gait_periods,[0:ms:ms*(num_periods-1)]','NewVariableNames','NewTime_start');
post_align_struct.overall_gait_periods = addvars(post_align_struct.overall_gait_periods,[ms:ms:(ms*num_periods)]','NewVariableNames','NewTime_end');
post_align_struct.overall_gait_periods.Gait(:) = 0;

for i = 1:size(post_align_struct.overall_gait_periods,1)
    [~, start_idx] = min(abs(post_align_struct.left_Accel_table.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
    [~, end_idx] = min(abs(post_align_struct.left_Accel_table.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
    signal = post_align_struct.left_Accel_table.XSamples(start_idx:end_idx);
    filtered_signal = bandpass(signal,[2 20],500);
    var = std(filtered_signal);
    % for RCS05 ptest, threshold = 20, var > 3
    % for RCS02 ptest, threshold = 15, var > 3
    % for RCS09 ptest1, threshold = 15, var > 3
    % for RCS09 ptest2 and ptest3 threshold = 10, var > 3
    threshold = 10;
    if var > 3
        crossings = (filtered_signal(1:end-1) < threshold & filtered_signal(2:end) >= threshold) | ...
            (filtered_signal(1:end-1) >= threshold & filtered_signal(2:end) < threshold);
        if sum(crossings) > 5
            post_align_struct.overall_gait_periods.Gait(i) = 1;
        else
            post_align_struct.overall_gait_periods.Gait(i) = 2;  
        end
    end
end

post_align_struct.l_rcs_accel = post_align_struct.left_Accel_table;
overall_gait_periods = post_align_struct.overall_gait_periods;

figure()
plot(post_align_struct.l_rcs_accel.NewTime,post_align_struct.l_rcs_accel.XSamples)
title('L RCS Accelerometry')
hold on
for i = 1:size(overall_gait_periods,1)
    x = overall_gait_periods.NewTime_start(i);
    y = 0 - max(post_align_struct.l_rcs_accel.XSamples);
    width = overall_gait_periods.NewTime_end(i)-overall_gait_periods.NewTime_start(i);
    height = 2.1*max(post_align_struct.l_rcs_accel.XSamples);
    if overall_gait_periods.Gait(i) == 1
            rectangle('Position',[x,y,width,height],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none');
    elseif overall_gait_periods.Gait(i) == 0
            rectangle('Position',[x,y,width,height],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none');
    end
end

%% 

post_align_struct.l_rcs_lfp = post_align_struct.left_LFP_table;
post_align_struct.l_rcs_lfp.NewTime = post_align_struct.l_rcs_lfp.DerivedTime(:) - post_align_struct.l_rcs_lfp.DerivedTime(1);

if isfield(post_align_struct,'right_LFP_table')
    post_align_struct.r_rcs_lfp = post_align_struct.right_LFP_table;
    post_align_struct.r_rcs_lfp.NewTime = post_align_struct.r_rcs_lfp.DerivedTime(:) - post_align_struct.r_rcs_lfp.DerivedTime(1);
end
    
%%

post_align_struct.filename = 'test';
side = 0;
post_align_struct.period = period;

end