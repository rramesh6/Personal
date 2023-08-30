load('/Volumes/dwang3_shared/Treadmill/Ramp Up/Aligned + Labeled Data/gait_RCS_02_Treadmill_Ramp_Up_BOTH_STIM_ON_MEDS_labeled.mat')

aligned_data.speeds = zeros(size(aligned_data.gait_events,1),1);
for i = 1:size(aligned_data.gait_events,1)
    start_time = 1000*aligned_data.gait_events.LHS(i);
    end_time = 1000*aligned_data.gait_events.LTO(i);
    for j = 1:size(aligned_data.speed_info_abandon,1)
        if start_time >= aligned_data.speed_info_abandon(j,1) & end_time <= aligned_data.speed_info_abandon(j,2)
            aligned_data.speeds(i) = aligned_data.speed_info_abandon(j,3);
        else 
            continue;
        end
    end
end


speed = 1.0;
aligned_data.gait_events = aligned_data.gait_events(aligned_data.speeds == speed,:);

B = calcRCS_CWT(aligned_data);
GaitCycleAvgSpectrogram(aligned_data,B,'normalizeBy','average_during_walking','normalizationType','zscore','freqLimits',[2.5 50],'subjectID','02','savePlot',true);