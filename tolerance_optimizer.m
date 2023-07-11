path = '/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/Rover/Data/Aligned Data';
files = dir(fullfile(path,'*.mat'));
names = {files.name};
addpath(path);

overall_gait_store = struct();
overall_nongait_store = struct();
tolerances = [0.7:0.02:1];

for i = 1:3
    file = names{i};
    update = ['Processing alignment for ' num2str(file)];
    disp(update)
    post_align_struct = post_align(file,0);
    update = ['Labeling ' num2str(file)];
    disp(update)
    post_align_struct = label_rover(post_align_struct,rover_stack);
    update = ['Chunking ' num2str(file)];
    disp(update)
    for tolerance = tolerances
        tolerance_gait_stores = [];
        tolerance_nongait_stores = [];
        fieldname = ['tol_' num2str(tolerance*100)];
        if ~isfield(overall_gait_store,fieldname)
            overall_gait_store.(fieldname) = [];
        end
        if ~isfield(overall_nongait_store,fieldname)
            overall_nongait_store.(fieldname) = [];
        end
        post_align_struct = chunk(post_align_struct,10,tolerance,0);
        for i = 1:size(post_align_struct.overall_gait_periods.Gait,1)
            start_time = post_align_struct.overall_gait_periods.NewTime_start(i);
            end_time = post_align_struct.overall_gait_periods.NewTime_end(i);
            [~,start_idx] = min(abs(post_align_struct.l_rover.NewTime - start_time));
            [~,end_idx] = min(abs(post_align_struct.l_rover.NewTime - end_time));
            temp_chunk = post_align_struct.l_rover.LinearAccelX(start_idx:end_idx,1);
            temp_chunk_accel_std = rms(temp_chunk)^2;
            if post_align_struct.overall_gait_periods.Gait(i) == 1
                tolerance_gait_stores = [tolerance_gait_stores temp_chunk_accel_std];
            elseif post_align_struct.overall_gait_periods.Gait(i) == 0
                tolerance_nongait_stores = [tolerance_nongait_stores temp_chunk_accel_std];
            end
        end
        overall_gait_store.(fieldname) = [overall_gait_store.(fieldname) tolerance_gait_stores];
        overall_nongait_store.(fieldname) = [overall_nongait_store.(fieldname) tolerance_nongait_stores];
    end
end

mean_gait_store = struct();
mean_nongait_store = struct();
for i = 1:size(fieldnames(overall_gait_store),1)
    names = fieldnames(overall_gait_store);
    mean_gait_store.(names{i}) = mean(overall_gait_store.(names{i}));
end
for i = 1:size(fieldnames(overall_nongait_store),1)
    names = fieldnames(overall_nongait_store);
    mean_nongait_store.(names{i}) = mean(overall_nongait_store.(names{i}));
end

output_table = [];
for i = 1:size(fieldnames(overall_gait_store),1)
    names = fieldnames(overall_gait_store);
    compile = [mean_gait_store.(names{i}) mean_nongait_store.(names{i})];
    output_table = [output_table; compile];
end

output_table = [tolerances' output_table];
diff_table = [tolerances' output_table(:,2)-output_table(:,1)];
plot(diff_table(:,1),diff_table(:,2));



