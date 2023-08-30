%% RCS02

load('/Volumes/dwang3_shared/Patient Data/RC+S Data/gait_RCS_02/v7_2022-10-31_pre-programming_second_side_implant/Data/Aligned Data/gait_RCS_02_Treadmill_Ramp_Up_BOTH_STIM_ON_MEDS.mat');

%% Plot FSR data

figure()
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
legend('LH','RH','LT','RT')

%% Detect Left Heel Strike 

Left_Heel = aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15;
Left_Heel_Time = aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15;
LHS = [];
LH_threshold = 5;

% % Find local maxima
% maxIndices2 = islocalmax(Left_Heel,"MinProminence",5,...
%     "SamplePoints",Left_Heel_Time);
% 
% % Display results
% figure
% plot(Left_Heel_Time,Left_Heel,"Color",[77 190 238]/255,...
%     "DisplayName","Input data")
% hold on
% 
% % Plot local maxima
% plot(Left_Heel_Time(maxIndices2),Left_Heel(maxIndices2),"^",...
%     "Color",[217 83 25]/255,"MarkerFaceColor",[217 83 25]/255,...
%     "DisplayName","Local maxima")
% title("Potential Left Heel Strikes")
% hold off
% legend
% xlabel("Left_Heel_Time","Interpreter","none")

for i = 2:size(Left_Heel,1)-1
    if Left_Heel(i-1) < LH_threshold & Left_Heel(i) > LH_threshold & Left_Heel(i+2) >= Left_Heel(i)
        LHS = [LHS; Left_Heel_Time(i)];
    end
end

LHS_final = LHS;
for i = 1:size(LHS,1)-1
    if abs(LHS(i+1) - LHS(i)) < 0.2
        LHS_final(i+1) = 0;
    end
end
LHS = LHS_final(LHS_final ~= 0);

figure()
plot(Left_Heel_Time,Left_Heel)
hold on
for i = 1:size(LHS,1)
plot([LHS(i) LHS(i)],[-5 35],'r')
end

%% Detect Left Toe Off

Left_Toe = aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15;
Left_Toe_Time = aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRD_15;
LTO = [];
LT_threshold = 5;

% % Find local maxima
% maxIndices2 = islocalmax(Left_Toe,"MinProminence",5,...
%     "SamplePoints",Left_Toe_Time);
% 
% % Display results
% figure
% plot(Left_Toe_Time,Left_Toe,"Color",[77 190 238]/255,...
%     "DisplayName","Input data")
% hold on
% 
% % Plot local maxima
% plot(Left_Toe_Time(maxIndices2),Left_Toe(maxIndices2),"^",...
%     "Color",[217 83 25]/255,"MarkerFaceColor",[217 83 25]/255,...
%     "DisplayName","Local maxima")
% title("Potential Left Toe Offs")
% hold off
% legend
% xlabel("Left_Toe_Time","Interpreter","none")

for i = 2:size(Left_Toe,1)-1
    if Left_Toe(i-1) > LT_threshold & Left_Toe(i) < LT_threshold & Left_Toe(i+2) <= Left_Toe(i)
        LTO = [LTO; Left_Toe_Time(i)];
    end
end

figure()
plot(Left_Toe_Time,Left_Toe)
hold on
for i = 1:size(LTO,1)
plot([LTO(i) LTO(i)],[-5 35],'r')
end

%% Detect Right Heel Strike

Right_Heel = aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16;
Right_Heel_Time = aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16;
RHS = [];
RH_threshold = 5;

% % Find local maxima
% maxIndices2 = islocalmax(Right_Heel,"MinProminence",0.5,...
%     "SamplePoints",Right_Heel_Time);
% 
% % Display results
% figure
% plot(Right_Heel_Time,Right_Heel,"Color",[77 190 238]/255,...
%     "DisplayName","Input data")
% hold on
% 
% % Plot local maxima
% plot(Right_Heel_Time(maxIndices2),Right_Heel(maxIndices2),"^",...
%     "Color",[217 83 25]/255,"MarkerFaceColor",[217 83 25]/255,...
%     "DisplayName","Local maxima")
% title("Potential Right Heel Strikes")
% hold off
% legend
% xlabel("Right_Heel_Time","Interpreter","none")

for i = 2:size(Right_Heel,1)-1
    if Right_Heel(i-1) < RH_threshold & Right_Heel(i) > RH_threshold & Right_Heel(i+2) >= Right_Heel(i)
        RHS = [RHS; Right_Heel_Time(i)];
    end
end

figure()
plot(Right_Heel_Time,Right_Heel)
hold on
for i = 1:size(RHS,1)
plot([RHS(i) RHS(i)],[-5 35],'r')
end

%% Detect Right Toe Off 

[~, idx] = min(abs(Right_Toe_Time - 102));
Right_Toe = [aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16(1:idx); aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16(idx+1:end) - 6.25];

% Right_Toe = aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16;
% Right_Toe_Time = aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16;
RTO = [];
RT_threshold = 5;


% % Find local maxima
% RTO_times = islocalmax(Right_Toe,"MinProminence",0.5,...
%     "SamplePoints",Right_Toe_Time);
% 
% % Display results
% figure
% plot(Right_Toe_Time,Right_Toe,"Color",[77 190 238]/255,...
%     "DisplayName","Input data")
% hold on
% 
% % Plot local maxima
% plot(Right_Toe_Time(RTO_times),Right_Toe(RTO_times),"^",...
%     "Color",[217 83 25]/255,"MarkerFaceColor",[217 83 25]/255,...
%     "DisplayName","Local maxima")
% title("Potential Right Toe Offs")
% hold off
% legend
% xlabel("Right_Toe_Time","Interpreter","none")

for i = 2:size(Right_Toe,1)-1
    if Right_Toe(i-1) > RT_threshold & Right_Toe(i) < RT_threshold & Right_Toe(i+2) <= Right_Toe(i) 
        RTO = [RTO; Right_Toe_Time(i)];
    end
end

figure()
plot(Right_Toe_Time,Right_Toe)
hold on
for i = 1:size(RTO,1)
plot([RTO(i) RTO(i)],[-5 35],'r')
end

%% Pick cleanest signal as reference and check other events  

LHS_final = [];
RTO_final = [];
RHS_final = [];
LTO_final = [];

for i = 1:size(LHS,1)-1
    start_time = LHS(i);
    end_time = LHS(i+1);
    LHS_temp = LHS(i);

    RTO_isolate = RTO(RTO > start_time & RTO < end_time);
    if size(RTO_isolate,1) == 0
        continue
    elseif size(RTO_isolate,1) == 1
        RTO_temp = RTO_isolate;
        start_time = RTO_temp;
    else
        RTO_temp = RTO_isolate(1);
        start_time = RTO_temp;
    end

    RHS_isolate = RHS(RHS > start_time & RHS < end_time);
    if size(RHS_isolate,1) == 0
        continue
    elseif size(RHS_isolate,1) == 1
        RHS_temp = RHS_isolate;
        start_time = RHS_temp;
    else
        RHS_temp = RHS_isolate(1);
        start_time = RHS_temp;
    end        
    
    LTO_isolate = LTO(LTO > start_time & LTO < end_time);
    if size(LTO_isolate,1) == 0
        continue
    elseif size(LTO_isolate,1) == 1
        LTO_temp = LTO_isolate;
    else
        LTO_temp = LTO_isolate(1);
    end
   
    LHS_final = [LHS_final; LHS_temp];
    RTO_final = [RTO_final; RTO_temp];
    RHS_final = [RHS_final; RHS_temp];
    LTO_final = [LTO_final; LTO_temp];

end

gait_events_array = [LHS_final RTO_final RHS_final LTO_final];


%% Plot labeled data 

figure()
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(gait_events_array,1)
   plot([gait_events_array(i,1) gait_events_array(i,1)],[-5 40],'k-')
end
legend('LH','RH','LT','RT')
title('Left Heel Strikes')

%% Define cleanest signal as the reference 

RTO = Right_Toe_Time(RTO_times)';
RHS = zeros(size(RTO(1:end-1)));
LTO = zeros(size(RTO(1:end-1)));
LHS = zeros(size(RTO(1:end-1)));

%% Extract other gait events

for i = 1:size(RTO,1)-1
    
    start_time = RTO(i);
    end_time = RTO(i+1);
    [~, start_idx] = min(abs(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15 - start_time));
    [~, end_idx] = min(abs(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15 - end_time));
    span = end_idx - start_idx;
    
    [~, RHS_idx] = max(Right_Heel(start_idx:end_idx));
    RHS_idx = RHS_idx + start_idx - 1;
    RHS_time = Right_Heel_Time(RHS_idx);
    start_idx = RHS_idx;

    [~, LTO_idx] = max(Left_Toe(start_idx:end_idx));
    LTO_idx = LTO_idx + start_idx - 1;
    LTO_time = Left_Toe_Time(LTO_idx);
    start_idx = LTO_idx;

    [~, LHS_idx] = max(Left_Heel(start_idx:end_idx));
    LHS_idx = LHS_idx + start_idx - 1;
    LHS_time = Left_Heel_Time(LHS_idx);

   if LHS_idx >= end_idx - 0.05*span;
       isolate = Left_Heel(start_idx:end_idx);
       pot_LHS_idx = islocalmax(isolate,"MinProminence",1,"SamplePoints",Left_Heel_Time(start_idx:end_idx));
       pot_LHS_val = isolate(pot_LHS_idx);
       max_LHS = max(pot_LHS_val);
       LHS_idx = find(isolate == max_LHS);
       LHS_idx = LHS_idx + start_idx - 1;
       LHS_time = Left_Heel_Time(LHS_idx);
   end

    [~, start_idx] = min(abs(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15 - start_time));

    figure(1);
    clf;  % Clear the figure

    % Plot the data
    plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx), aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx), 'b')
    hold on;
    plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx), aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16(start_idx:end_idx), 'r')
    plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx), aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15(start_idx:end_idx), 'b:')
    plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx), aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16(start_idx:end_idx), 'r:')
    
    % Create scatter plots for markers
    RHS_marker = scatter(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(RHS_idx), Right_Heel(RHS_idx), "^", "Color", 'g', "MarkerFaceColor", 'g', "DisplayName", "RHS");
    LTO_marker = scatter(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(LTO_idx), Left_Toe(LTO_idx), "^", "Color", 'g', "MarkerFaceColor", 'g', "DisplayName", "LTO");
    LHS_marker = scatter(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(LHS_idx), Left_Heel(LHS_idx), "^", "Color", 'g', "MarkerFaceColor", 'g', "DisplayName", "LHS");
    
%     uicontrol('Style', 'pushbutton', 'String', 'RHS', 'Position', [10 10 50 20], 'Callback', @(src, event) selectMarker('RHS', Right_Heel(start_idx:end_idx)));
%     uicontrol('Style', 'pushbutton', 'String', 'LTO', 'Position', [10 40 50 20], 'Callback', @(src, event) selectMarker('LTO', Left_Toe(start_idx:end_idx)));
%     uicontrol('Style', 'pushbutton', 'String', 'LHS', 'Position', [10 70 50 20], 'Callback', @(src, event) selectMarker('LHS', Left_Heel(start_idx:end_idx)));
  
    time = aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15(start_idx:end_idx);
    
    uicontrol('Style', 'pushbutton', 'String', 'RHS', 'Position', [130, 10, 50, 30], 'Callback', @(src, event) set(gcf, 'WindowButtonDownFcn', @(src, event) moveMarker(src, event, RHS_marker, time, Right_Heel(start_idx:end_idx))));
    uicontrol('Style', 'pushbutton', 'String', 'LTO', 'Position', [190, 10, 50, 30], 'Callback', @(src, event) set(gcf, 'WindowButtonDownFcn', @(src, event) moveMarker(src, event, LTO_marker, time, Left_Toe(start_idx:end_idx))));
    uicontrol('Style', 'pushbutton', 'String', 'LHS', 'Position', [250, 10, 50, 30], 'Callback', @(src, event) set(gcf, 'WindowButtonDownFcn', @(src, event) moveMarker(src, event, LHS_marker, time, Left_Heel(start_idx:end_idx))));
   
    approveButton = uicontrol('Style', 'pushbutton', 'String', 'Approve', 'Position', [400, 10, 70, 30], 'Callback', @(src, event) approveCallback(RHS_marker, LTO_marker, LHS_marker, RHS, LTO, LHS, i));
    
    title(['Gait Cycle ', num2str(i), ' of ', num2str(size(RHS,1)-1)]); % Set the title with the iteration number
    
    legend('LH', 'RH', 'LT', 'RT')
    hold off;
    
    waitfor(approveButton, 'UserData', 1); % Wait for the 'approved' variable to become true

end

first_RTO = RTO(1:end-1);
next_RTO = RTO(2:end);

gait_events_array = [first_RTO RHS LTO LHS next_RTO];
gait_events = array2table(gait_events_array, 'VariableNames',{'RTO','RHS','LTO','LHS','Next RTO'});

%% Clean gait events

% mean_LHS_LTO = mean(gait_events_array(:,4) - gait_events_array(:,1));
% std_LHS_LTO = std(gait_events_array(:,4) - gait_events_array(:,1));
% gait_events_array((gait_events_array(:,4) - gait_events_array(:,1)) > mean_LHS_LTO + 2.5*std_LHS_LTO,:) = [];

is_ordered = (gait_events_array(:,4) > gait_events_array(:,3)) & (gait_events_array(:,3) > gait_events_array(:,2)) & (gait_events_array(:,2) > gait_events_array(:,1));
gait_events_array(~is_ordered, :) = [];

%% %% Plot labeled data 

figure()
ax(1) = subplot(2,2,1);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b','LineWidth',2)
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(gait_events_array,1)
    plot([gait_events_array(i,1) gait_events_array(i,1)], [-5 40], 'k-')
%     plot([gait_events_array(i,2) gait_events_array(i,2)], [-5 40], 'r-')
%     plot([gait_events_array(i,3) gait_events_array(i,3)], [-5 40], 'b-')
%     plot([gait_events_array(i,4) gait_events_array(i,4)], [-5 40], 'c-')
end
title('Left Heel Strikes')
legend('LH','RH','LT','RT')
hold off
ax(2) = subplot(2,2,2);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:','LineWidth',2)
for i = 1:size(gait_events_array,1)
    plot([gait_events_array(i,2) gait_events_array(i,2)], [-5 40], 'k-')
end
title('Right Toe Offs')
legend('LH','RH','LT','RT')
hold off
ax(3) = subplot(2,2,3);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r','LineWidth',2)
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(gait_events_array,1)
    plot([gait_events_array(i,3) gait_events_array(i,3)], [-5 40], 'k-')
end
title('Right Heel Strikes')
legend('LH','RH','LT','RT')
hold off
ax(4) = subplot(2,2,4);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:','LineWidth',2)
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(gait_events_array,1)
    plot([gait_events_array(i,4) gait_events_array(i,4)], [-5 40], 'k-')
end
title('Left Toe Offs')
legend('LH','RH','LT','RT')
hold off
linkaxes(ax,'x')

%% Plot all events on one 

figure()
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b','LineWidth',2)
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(gait_events_array,1)
    plot([gait_events_array(i,1) gait_events_array(i,1)], [-5 40], 'k-')
    plot([gait_events_array(i,2) gait_events_array(i,2)], [-5 40], 'r-')
    plot([gait_events_array(i,3) gait_events_array(i,3)], [-5 40], 'b-')
    plot([gait_events_array(i,4) gait_events_array(i,4)], [-5 40], 'c-')
end
title('Left Heel Strikes')
legend('LH','RH','LT','RT')
hold off

%% %% Plot RAW labeled data 

figure()
ax(1) = subplot(2,2,1);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b','LineWidth',2)
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(LHS,1)
    plot([LHS(i) LHS(i)], [-5 40], 'k-')
end
title('Left Heel Strikes')
legend('LH','RH','LT','RT')
hold off
ax(2) = subplot(2,2,2);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:','LineWidth',2)
for i = 1:size(RTO,1)
    plot([RTO(i) RTO(i)], [-5 40], 'k-')
end
title('Right Toe Offs')
legend('LH','RH','LT','RT')
hold off
ax(3) = subplot(2,2,3);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r','LineWidth',2)
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:')
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(RHS,1)
    plot([RHS(i) RHS(i)], [-5 40], 'k-')
end
title('Right Heel Strikes')
legend('LH','RH','LT','RT')
hold off
ax(4) = subplot(2,2,4);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'b')
hold on
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'r')
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'b:','LineWidth',2)
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'r:')
for i = 1:size(LTO,1)
    plot([LTO(i) LTO(i)], [-5 40], 'k-')
end
title('Left Toe Offs')
legend('LH','RH','LT','RT')
hold off
linkaxes(ax,'x')


%% Add table to structure

gait_events = array2table(gait_events_array,'VariableNames',{'LHS','RTO','RHS','LTO'});
aligned_data.gait_events = gait_events;

%% For Rover Data

figure()
ax(1) = subplot(211);
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRA_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRA_16,'k')
hold on
for i = 1:size(gait_events.RHS,1)
    plot([gait_events.RHS(i) gait_events.RHS(i)], [-5 50],'b')
end
title('R FSRA RHS')
hold off
ax(2) = subplot(212);
plot(merged_structure.Rover.Right.taxis, merged_structure.Rover.Right.LinearAccelX,'k');
hold on
title('R Rover Accel RHS')
for i = 1:size(gait_events.RHS,1)
    plot([gait_events.RHS(i) gait_events.RHS(i)], [-8000 6000],'b')
end
hold off
linkaxes(ax,'x')

figure()
ax(1) = subplot(211);
plot(aligned_data.Delsys.Time.FSR_adapter_16_Right_FSRD_16,aligned_data.Delsys.Data.FSR_adapter_16_Right_FSRD_16,'k')
hold on
for i = 1:size(gait_events.RTO,1)
    plot([gait_events.RTO(i) gait_events.RTO(i)], [-5 50],'b')
end
title('R FSRD RTO')
hold off
ax(2) = subplot(212);
plot(merged_structure.Rover.Right.taxis, merged_structure.Rover.Right.LinearAccelX,'k');
hold on
title('R Rover Accel RTO')
for i = 1:size(gait_events.RTO,1)
    plot([gait_events.RTO(i) gait_events.RTO(i)], [-8000 6000],'b')
end
hold off
linkaxes(ax,'x')

figure()
ax(1) = subplot(211);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRA_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRA_15,'k')
hold on
for i = 1:size(gait_events.LHS,1)
    plot([gait_events.LHS(i) gait_events.LHS(i)], [-5 50],'b')
end
title('L FSRA LHS')
hold off
ax(2) = subplot(212);
plot(merged_structure.Rover.Left.taxis, merged_structure.Rover.Left.LinearAccelX,'k');
hold on
title('L Rover Accel LHS')
for i = 1:size(gait_events.LHS,1)
    plot([gait_events.LHS(i) gait_events.LHS(i)], [-8000 10000],'b')
end
hold off
linkaxes(ax,'x')

figure()
ax(1) = subplot(211);
plot(aligned_data.Delsys.Time.FSR_adapter_15_Left_FSRD_15,aligned_data.Delsys.Data.FSR_adapter_15_Left_FSRD_15,'k')
hold on
for i = 1:size(gait_events.LTO,1)
    plot([gait_events.LTO(i) gait_events.LTO(i)], [-5 50],'b')
end
title('L FSRD LTO')
hold off
ax(2) = subplot(212);
plot(merged_structure.Rover.Left.taxis, merged_structure.Rover.Left.LinearAccelX,'k');
hold on
title('L Rover Accel LTO')
for i = 1:size(gait_events.LTO,1)
    plot([gait_events.LTO(i) gait_events.LTO(i)], [-8000 10000],'b')
end
hold off
linkaxes(ax,'x')

%% Functions

% Callback function to move the marker
function moveMarker(~, ~, marker, x, y)
    selected_marker = gco; % Get the selected marker
    
    if isempty(selected_marker)
        return;
    end
    
    current_point = get(gca, 'CurrentPoint');
    x_new = current_point(1, 1); % Get the new X-coordinate
    
    % Find the nearest index in the data
    [~, idx] = min(abs(x - x_new));
    
    % Update the marker position to the nearest data point
    set(marker, 'XData', x(idx), 'YData', y(idx));
    
    % Set the figure's WindowButtonUpFcn to finish moving the marker
    set(gcf, 'WindowButtonMotionFcn', '', 'WindowButtonUpFcn', @(src, event) finishMoveMarker(src, event, marker));
end

% Callback function to finish moving the marker
function finishMoveMarker(~, ~, marker)
    set(gcf, 'WindowButtonMotionFcn', '', 'WindowButtonUpFcn', ''); % Clear the callbacks
    uiresume; % Resume the UI event loop
end

% Callback function to select a marker
function selectMarker(marker, signal)
    assignin('base','marker_of_interest',marker);
    assignin('base', 'y', signal);
end

function approveCallback(RHS_marker, LTO_marker, LHS_marker, RHS, LTO, LHS, i)
    LHS(i) = LHS_marker.XData;
    RHS(i) = RHS_marker.XData;
    LTO(i) = LTO_marker.XData;
    assignin("base",'LHS',LHS);
    assignin("base",'RHS',RHS);
    assignin("base",'LTO',LTO);
    uiresume; % Resume the UI event loop to exit uiwait
end















