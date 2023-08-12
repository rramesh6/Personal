function merged_structure = merge_align(alignment1, alignment2)
    l_lower_bound = max(alignment1.left_Accel_table.DerivedTime(1), alignment2.left_Accel_table.DerivedTime(1));
    l_upper_bound = min(alignment1.left_Accel_table.DerivedTime(end), alignment2.left_Accel_table.DerivedTime(end));
    
    merged_structure = struct();

    if alignment1.left_Accel_table.DerivedTime(1) > alignment2.left_Accel_table.DerivedTime(1)
        merged_structure.left_Accel_table = alignment1.left_Accel_table;
    else
        merged_structure.left_Accel_table = alignment2.left_Accel_table;
    end
    
    [~, cutoff_idx] = min(abs(merged_structure.left_Accel_table.DerivedTime - l_upper_bound));
    merged_structure.left_Accel_table = merged_structure.left_Accel_table(1:cutoff_idx,:);
    
    merged_structure.left_accel_taxis = (merged_structure.left_Accel_table.DerivedTime - merged_structure.left_Accel_table.DerivedTime(1))/1000;

    [~, delsys_start_idx] = min(abs(alignment1.left_Accel_table.DerivedTime - l_lower_bound));
    delsys_start_time = alignment1.left_accel_taxis(delsys_start_idx);
    [~, delsys_start_idx] = min(abs(alignment1.Delsys.Time.FSR_adapter_15_Left_FSRA_15 - delsys_start_time));
    
    [~, delsys_end_idx] = min(abs(alignment1.left_Accel_table.DerivedTime - l_upper_bound));
    delsys_end_time = alignment1.left_accel_taxis(delsys_end_idx);
    [~, delsys_end_idx] = min(abs(alignment1.Delsys.Time.FSR_adapter_15_Left_FSRA_15 - delsys_end_time));

    merged_structure.Delsys = alignment1.Delsys;
    merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRA_15 = merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRA_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRB_15 = merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRB_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRC_15 = merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRC_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRD_15 = merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRD_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRA_15 = merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRA_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRB_15 = merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRB_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRC_15 = merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRC_15(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRD_15 = merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRD_15(delsys_start_idx:delsys_end_idx);

    figure()
    ax(1) = subplot(211);
    plot(merged_structure.left_accel_taxis,merged_structure.left_Accel_table.XSamples)
    ax(2) = subplot(212)
    plot(merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRA_15, merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRA_15)
    linkaxes(ax, 'x')
    
    alignment2.Rover.Left.taxis = seconds(alignment2.Rover.Left.DateTime - alignment2.Rover.Left.DateTime(1));
    [~, rover_start_idx] = min(abs(alignment2.left_Accel_table.DerivedTime - l_lower_bound));
    rover_start_time = alignment2.left_accel_taxis(rover_start_idx);
    [~, rover_start_idx] = min(abs(alignment2.Rover.Left.taxis - rover_start_time));
    [~, rover_end_idx] = min(abs(alignment1.left_Accel_table.DerivedTime - l_upper_bound));
    rover_end_time = alignment1.left_accel_taxis(rover_end_idx);
    [~, rover_end_idx] = min(abs(alignment2.Rover.Left.taxis - rover_end_time));
    merged_structure.Rover.Left = alignment2.Rover.Left(rover_start_idx:rover_end_idx,:);
    merged_structure.Rover.Left.taxis = seconds(merged_structure.Rover.Left.DateTime - merged_structure.Rover.Left.DateTime(1));
    
    % 

    r_lower_bound = max(alignment1.right_Accel_table.DerivedTime(1), alignment2.right_Accel_table.DerivedTime(1));
    r_upper_bound = min(alignment1.right_Accel_table.DerivedTime(end), alignment2.right_Accel_table.DerivedTime(end));

    if alignment1.right_Accel_table.DerivedTime(1) > alignment2.right_Accel_table.DerivedTime(1)
        merged_structure.right_Accel_table = alignment1.right_Accel_table;
    else
        merged_structure.right_Accel_table = alignment2.right_Accel_table;
    end
    
    [~, cutoff_idx] = min(abs(merged_structure.right_Accel_table.DerivedTime - r_upper_bound));
    merged_structure.right_Accel_table = merged_structure.right_Accel_table(1:cutoff_idx,:);
    
    merged_structure.right_accel_taxis = (merged_structure.right_Accel_table.DerivedTime - merged_structure.right_Accel_table.DerivedTime(1))/1000;

    [~, delsys_start_idx] = min(abs(alignment1.right_Accel_table.DerivedTime - r_lower_bound));
    delsys_start_time = alignment1.right_accel_taxis(delsys_start_idx);
    [~, delsys_start_idx] = min(abs(alignment1.Delsys.Time.FSR_adapter_16_Right_FSRA_16 - delsys_start_time));
    
    [~, delsys_end_idx] = min(abs(alignment1.right_Accel_table.DerivedTime - r_upper_bound));
    delsys_end_time = alignment1.right_accel_taxis(delsys_end_idx);
    [~, delsys_end_idx] = min(abs(alignment1.Delsys.Time.FSR_adapter_16_Right_FSRA_16 - delsys_end_time));

    merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRA_16 = merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRA_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRB_16 = merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRB_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRC_16 = merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRC_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRD_16 = merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRD_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRA_16 = merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRA_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRB_16 = merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRB_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRC_16 = merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRC_16(delsys_start_idx:delsys_end_idx);
    merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRD_16 = merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRD_16(delsys_start_idx:delsys_end_idx);

    figure()
    ax(1) = subplot(211);
    plot(merged_structure.right_accel_taxis, merged_structure.right_Accel_table.XSamples)
    ax(2) = subplot(212)
    plot(merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRA_16, merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRA_16)
    linkaxes(ax, 'x')
    
    alignment2.Rover.Right.taxis = seconds(alignment2.Rover.Right.DateTime - alignment2.Rover.Right.DateTime(1));
    [~, rover_start_idx] = min(abs(alignment2.right_Accel_table.DerivedTime - r_lower_bound));
    rover_start_time = alignment2.right_accel_taxis(rover_start_idx);
    [~, rover_start_idx] = min(abs(alignment2.Rover.Right.taxis - rover_start_time));
    [~, rover_end_idx] = min(abs(alignment1.right_Accel_table.DerivedTime - r_upper_bound));
    rover_end_time = alignment1.right_accel_taxis(rover_end_idx);
    [~, rover_end_idx] = min(abs(alignment2.Rover.Right.taxis - rover_end_time));
    merged_structure.Rover.Right = alignment2.Rover.Right(rover_start_idx:rover_end_idx,:);
    merged_structure.Rover.Right.taxis = seconds(merged_structure.Rover.Right.DateTime - merged_structure.Rover.Right.DateTime(1));
    
    figure()
    ax(1) = subplot(322);
    plot(merged_structure.right_accel_taxis,merged_structure.right_Accel_table.XSamples);
    hold on
    title('R RCS Accel')
    hold off
    ax(2) = subplot(324);
    plot(merged_structure.Rover.Right.taxis, merged_structure.Rover.Right.LinearAccelX);
    hold on
    title('R Rover Accel')
    hold off
    ax(3) = subplot(326);
    plot(merged_structure.Delsys.Time.FSR_adapter_16_Right_FSRA_16, merged_structure.Delsys.Data.FSR_adapter_16_Right_FSRA_16)
    hold on
    title('R Heel FSR')
    ax(4) = subplot(321);
    plot(merged_structure.left_accel_taxis,merged_structure.left_Accel_table.XSamples);
    hold on
    title('L RCS Accel')
    hold off
    ax(5) = subplot(323);
    plot(merged_structure.Rover.Left.taxis, merged_structure.Rover.Left.LinearAccelX);
    hold on
    title('L Rover Accel')
    hold off
    ax(6) = subplot(325);
    plot(merged_structure.Delsys.Time.FSR_adapter_15_Left_FSRA_15, merged_structure.Delsys.Data.FSR_adapter_15_Left_FSRA_15)
    hold on
    title('L Heel FSR')
    linkaxes(ax,'x')

    [~, lfp_start_idx] = min(abs(alignment1.left_Accel_table.DerivedTime - l_lower_bound));
    lfp_start_time = alignment1.left_accel_taxis(lfp_start_idx);
    [~, lfp_start_idx] = min(abs(alignment1.left_taxis - lfp_start_time));

    [~, lfp_end_idx] = min(abs(alignment1.left_Accel_table.DerivedTime - l_upper_bound));
    lfp_end_time = alignment1.left_accel_taxis(lfp_end_idx);
    [~, lfp_end_idx] = min(abs(alignment1.left_taxis - lfp_end_time));
    
    merged_structure.left_LFP_table = alignment1.left_LFP_table(lfp_start_idx:lfp_end_idx,:);
    merged_structure.left_taxis = seconds((merged_structure.left_LFP_table.DerivedTime - merged_structure.left_LFP_table.DerivedTime(1))/1000);

    [~, lfp_start_idx] = min(abs(alignment1.right_Accel_table.DerivedTime - r_lower_bound));
    lfp_start_time = alignment1.right_accel_taxis(lfp_start_idx);
    [~, lfp_start_idx] = min(abs(alignment1.right_taxis - lfp_start_time));

    [~, lfp_end_idx] = min(abs(alignment1.right_Accel_table.DerivedTime - r_upper_bound));
    lfp_end_time = alignment1.right_accel_taxis(lfp_end_idx);
    [~, lfp_end_idx] = min(abs(alignment1.right_taxis - lfp_end_time));
    
    merged_structure.right_LFP_table = alignment1.right_LFP_table(lfp_start_idx:lfp_end_idx,:);
    merged_structure.right_taxis = seconds((merged_structure.right_LFP_table.DerivedTime - merged_structure.right_LFP_table.DerivedTime(1))/1000);

end


