function [P_gait,F_gait,P_nongait,F_nongait] = psd_analysis(post_align_struct,key,fig)

period = post_align_struct.period;
ms = 1000*period;

if key == 0

    new_num_periods = size(post_align_struct.l_gait_periods,1)-1;

    Fs = 500;
    Pxx_key0_gait = [];
    F_key0_gait = [];
    Pxx_key0_nongait = [];
    F_key0_nongait = [];

    for i = 1:new_num_periods
        [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
        [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
        x = post_align_struct.l_rcs_lfp.key0(start_idx:end_idx,:);
        if size(x,1) > 8
            [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
            if post_align_struct.overall_gait_periods.Gait(i,1) == 1
                Pxx_key0_gait = [Pxx_key0_gait Pxx];
                F_key0_gait = [F_key0_gait F];
            else
                Pxx_key0_nongait = [Pxx_key0_nongait Pxx];
                F_key0_nongait = [F_key0_nongait F];
            end
            update = ['Finished processing chunk ' num2str(i)];
            disp(update)
        else
            update = ['Skipped chunk ' num2str(i)];
            disp(update)
        end
    end

    P_gait = Pxx_key0_gait;
    F_gait = F_key0_gait;
    P_nongait = Pxx_key0_nongait;
    F_nongait = F_key0_nongait;

    if fig == 1 || nargin == 2
        figure(8)
        title('Average Power Spectral Density (key 0)')
        xlabel('Frequency (Hz)')
        ylabel('Power/Frequency (dB/Hz)')
        hold on 
        plot(F_key0_gait(:,1),10*log10(mean(Pxx_key0_gait,2)),'b')
        plot(F_key0_nongait(:,1),10*log10(mean(Pxx_key0_nongait,2)),'r')
        legend('Gait','Non-Gait')
        rectangle('Position',[1.5,-125,2.5,100],'FaceColor',[0, 1, 1, 0.1],'EdgeColor','none'); % delta
        rectangle('Position',[4,-125,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
        rectangle('Position',[8,-125,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
        rectangle('Position',[13,-125,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
        rectangle('Position',[70,-125,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
        xlim([0 100])
        ylim([-75 -30])
        hold off 
    end
end

if key == 1

    new_num_periods = size(post_align_struct.l_gait_periods,1);

    Fs = 500;
    Pxx_key1_gait = [];
    F_key1_gait = [];
    Pxx_key1_nongait = [];
    F_key1_nongait = [];

    for i = 1:new_num_periods
        [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
        [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
        x = post_align_struct.l_rcs_lfp.key1(start_idx:end_idx,:);
        if size(x,1) > 8
            [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
            if post_align_struct.overall_gait_periods.Gait(i,1) == 1
                Pxx_key1_gait = [Pxx_key1_gait Pxx];
                F_key1_gait = [F_key1_gait F];
            else
                Pxx_key1_nongait = [Pxx_key1_nongait Pxx];
                F_key1_nongait = [F_key1_nongait F];
            end
            update = ['Finished processing chunk ' num2str(i)];
            disp(update)
        else
            update = ['Skipped chunk ' num2str(i)];
            disp(update)
        end
    end

    P_gait = Pxx_key1_gait;
    F_gait = F_key1_gait;
    P_nongait = Pxx_key1_nongait;
    F_nongait = F_key1_nongait;

    if fig == 1 || nargin == 2
        figure(8)
        title('Average Power Spectral Density (key 1)')
        xlabel('Frequency (Hz)')
        ylabel('Power/Frequency (dB/Hz)')
        hold on 
        plot(F_key1_gait(:,1),10*log10(mean(Pxx_key1_gait,2)),'b')
        plot(F_key1_nongait(:,1),10*log10(mean(Pxx_key1_nongait,2)),'r')
        legend('Gait','Non-Gait')
        rectangle('Position',[4,-125,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
        rectangle('Position',[8,-125,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
        rectangle('Position',[13,-125,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
        rectangle('Position',[70,-125,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
        hold off 
    end
end

if key == 2

    new_num_periods = size(post_align_struct.l_gait_periods,1);

    Fs = 500;
    Pxx_key2_gait = [];
    F_key2_gait = [];
    Pxx_key2_nongait = [];
    F_key2_nongait = [];

    for i = 1:new_num_periods
        [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
        [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
        x = post_align_struct.l_rcs_lfp.key2(start_idx:end_idx,:);
        if size(x,1) > 8
            [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
            if post_align_struct.overall_gait_periods.Gait(i,1) == 1
                Pxx_key2_gait = [Pxx_key2_gait Pxx];
                F_key2_gait = [F_key2_gait F];
            else
                Pxx_key2_nongait = [Pxx_key2_nongait Pxx];
                F_key2_nongait = [F_key2_nongait F];
            end
            update = ['Finished processing chunk ' num2str(i)];
            disp(update)
        else
            update = ['Skipped chunk ' num2str(i)];
            disp(update)
        end
    end

    P_gait = Pxx_key2_gait;
    F_gait = F_key2_gait;
    P_nongait = Pxx_key2_nongait;
    F_nongait = F_key2_nongait;

    if fig == 1 || nargin == 2
        figure(8)
        title('Average Power Spectral Density (key 2)')
        xlabel('Frequency (Hz)')
        ylabel('Power/Frequency (dB/Hz)')
        hold on 
        plot(F_key2_gait(:,1),10*log10(mean(Pxx_key2_gait,2)),'b')
        plot(F_key2_nongait(:,1),10*log10(mean(Pxx_key2_nongait,2)),'r')
        legend('Gait','Non-Gait')
        rectangle('Position',[4,-125,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
        rectangle('Position',[8,-125,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
        rectangle('Position',[13,-125,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
        rectangle('Position',[70,-125,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
        hold off 
    end
end

if key == 3

    new_num_periods = size(post_align_struct.l_gait_periods,1);

    Fs = 500;
    Pxx_key3_gait = [];
    F_key3_gait = [];
    Pxx_key3_nongait = [];
    F_key3_nongait = [];

    for i = 1:new_num_periods
        [~,start_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_start(i)));
        [~,end_idx] = min(abs(post_align_struct.l_rcs_lfp.NewTime - post_align_struct.overall_gait_periods.NewTime_end(i)));
        x = post_align_struct.l_rcs_lfp.key3(start_idx:end_idx,:);
        if size(x,1) > 8
            [Pxx,F] = pwelch(x,[],[],Fs*period,Fs);
            if post_align_struct.overall_gait_periods.Gait(i,1) == 1
                Pxx_key3_gait = [Pxx_key3_gait Pxx];
                F_key3_gait = [F_key3_gait F];
            else
                Pxx_key3_nongait = [Pxx_key3_nongait Pxx];
                F_key3_nongait = [F_key3_nongait F];
            end
            update = ['Finished processing chunk ' num2str(i)];
            disp(update)
        else
            update = ['Skipped chunk ' num2str(i)];
            disp(update)
        end
    end

    P_gait = Pxx_key3_gait;
    F_gait = F_key3_gait;
    P_nongait = Pxx_key3_nongait;
    F_nongait = F_key3_nongait;

    if fig == 1 || nargin == 2
        figure(8)
        title('Average Power Spectral Density (key 3)')
        xlabel('Frequency (Hz)')
        ylabel('Power/Frequency (dB/Hz)')
        hold on 
        plot(F_key3_gait(:,1),10*log10(mean(Pxx_key3_gait,2)),'b')
        plot(F_key3_nongait(:,1),10*log10(mean(Pxx_key3_nongait,2)),'r')
        legend('Gait','Non-Gait')
        rectangle('Position',[4,-125,3,100],'FaceColor',[1, 1, 0, 0.1],'EdgeColor','none'); % theta
        rectangle('Position',[8,-125,4,100],'FaceColor',[0, 1, 0, 0.1],'EdgeColor','none'); % alpha
        rectangle('Position',[13,-125,17,100],'FaceColor',[1, 0, 0, 0.1],'EdgeColor','none'); % beta
        rectangle('Position',[70,-125,20,100],'FaceColor',[0, 0, 1, 0.1],'EdgeColor','none'); % gamma
        hold off 
    end
end

end