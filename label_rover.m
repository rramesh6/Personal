function post_align_struct = label_rover(post_align_struct, rover_stack)

% generate ms by ms gait labels based on rover stack

post_align_struct.l_gait = table();
post_align_struct.l_gait = addvars(post_align_struct.l_gait,[0:1:post_align_struct.l_rover.NewTime(end,1)]','NewVariableNames','NewTime');
post_align_struct.l_gait = addvars(post_align_struct.l_gait, (repmat(post_align_struct.l_rover.DateTime(1),size(post_align_struct.l_gait(:,1))) + seconds(post_align_struct.l_gait.NewTime/1000)),'NewVariableNames','DateTime');
if post_align_struct.year == 2021
    post_align_struct.l_gait.DateTime.Year = 2021;
elseif post_align_struct.year == 2022
    post_align_struct.l_gait.DateTime.Year = 2022;
else
    post_align_struct.l_gait.DateTime.Year = 2023;
end
post_align_struct.l_gait = addvars(post_align_struct.l_gait, zeros(size(post_align_struct.l_gait.NewTime)),'NewVariableNames','Gait');

post_align_struct.r_gait = table();
post_align_struct.r_gait = addvars(post_align_struct.r_gait,[0:1:post_align_struct.r_rover.NewTime(end,1)]','NewVariableNames','NewTime');
post_align_struct.r_gait = addvars(post_align_struct.r_gait, (repmat(post_align_struct.r_rover.DateTime(1),size(post_align_struct.r_gait(:,1))) + seconds(post_align_struct.r_gait.NewTime/1000)),'NewVariableNames','DateTime');
if post_align_struct.year == 2021
    post_align_struct.r_gait.DateTime.Year = 2021;
elseif post_align_struct.year == 2022
    post_align_struct.r_gait.DateTime.Year = 2022;
else
    post_align_struct.r_gait.DateTime.Year = 2023;
end
post_align_struct.r_gait = addvars(post_align_struct.r_gait, zeros(size(post_align_struct.r_gait.NewTime)),'NewVariableNames','Gait');

rover_stack_left = rover_stack(rover_stack.LeftRight == "Left",:);
rover_stack_right = rover_stack(rover_stack.LeftRight == "right",:);

for i = 1:size(rover_stack_left,1)
    if (rover_stack_left.Time(i) < post_align_struct.l_gait.DateTime(1) & rover_stack_left.End(i) < post_align_struct.l_gait.DateTime(1)) || (rover_stack_left.Time(i) > post_align_struct.l_gait.DateTime(end) & rover_stack_left.End(i) > post_align_struct.l_gait.DateTime(end))      
        continue
    else
        start_time = rover_stack_left.Time(i);
        [~, start_idx] = min(abs(post_align_struct.l_gait.DateTime - start_time));
        end_time = rover_stack_left.End(i);
        [~, end_idx] = min(abs(post_align_struct.l_gait.DateTime - end_time));
        post_align_struct.l_gait.Gait(start_idx:end_idx) = 1;
    end
end

for i = 1:size(rover_stack_right,1)
    if (rover_stack_right.Time(i) < post_align_struct.r_gait.DateTime(1) & rover_stack_right.End(i) < post_align_struct.r_gait.DateTime(1)) || (rover_stack_right.Time(i) > post_align_struct.r_gait.DateTime(end) & rover_stack_right.End(i) > post_align_struct.r_gait.DateTime(end))      
        continue
    else
        start_time = rover_stack_right.Time(i);
        [~, start_idx] = min(abs(post_align_struct.r_gait.DateTime - start_time));
        end_time = rover_stack_right.End(i);
        [~, end_idx] = min(abs(post_align_struct.r_gait.DateTime - end_time));
        post_align_struct.r_gait.Gait(start_idx:end_idx) = 1;
    end
end
