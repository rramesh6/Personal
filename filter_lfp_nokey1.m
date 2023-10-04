function post_align_struct = filter_lfp_nokey1(post_align_struct, filter_above, filter_below, notch, notch_f, bandwidth)

Fs = 500;

% post_align_struct.l_rcs_lfp.key0 = highpass(post_align_struct.l_rcs_lfp.key0,filter_above,Fs);
% post_align_struct.l_rcs_lfp.key0 = lowpass(post_align_struct.l_rcs_lfp.key0,filter_below,Fs);
% 
% post_align_struct.l_rcs_lfp.key1 = highpass(post_align_struct.l_rcs_lfp.key1,filter_above,Fs);
% post_align_struct.l_rcs_lfp.key1 = lowpass(post_align_struct.l_rcs_lfp.key1,filter_below,Fs);
% 
% post_align_struct.l_rcs_lfp.key2 = highpass(post_align_struct.l_rcs_lfp.key2,filter_above,Fs);
% post_align_struct.l_rcs_lfp.key2 = lowpass(post_align_struct.l_rcs_lfp.key2,filter_below,Fs);
% 
% post_align_struct.l_rcs_lfp.key3 = highpass(post_align_struct.l_rcs_lfp.key3,filter_above,Fs);
% post_align_struct.l_rcs_lfp.key3 = lowpass(post_align_struct.l_rcs_lfp.key3,filter_below,Fs);


% [b,a] = butter(9,filter_above/(Fs/2),'high');
% post_align_struct.l_rcs_lfp.key0 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key0);
% post_align_struct.l_rcs_lfp.key1 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key1);
% post_align_struct.l_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key2);
% post_align_struct.l_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key3);

% [b,a] = butter(9,filter_below/(Fs/2),'low');
% post_align_struct.l_rcs_lfp.key0 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key0);
% post_align_struct.l_rcs_lfp.key1 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key1);
% post_align_struct.l_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key2);
% post_align_struct.l_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key3);

[b,a] = butter(6,[filter_above/(Fs/2) filter_below/(Fs/2)],'bandpass');
post_align_struct.l_rcs_lfp.key0 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key0);
%post_align_struct.l_rcs_lfp.key1 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key1);
post_align_struct.l_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key2);
post_align_struct.l_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key3);

if notch == 1
    for i = 1:size(notch_f,2)
        freqRatio = 2*(notch_f(i))/500;
        notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,bandwidth,0.1);
        notchFilt = design(notchSpecs,'SystemObject',true);
        post_align_struct.l_rcs_lfp.key0 = notchFilt(post_align_struct.l_rcs_lfp.key0);
    end
end

if notch == 2
    for i = 1:size(notch_f,2)
        freqRatio = 2*(notch_f(i))/500;
        notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,bandwidth,0.1);
        notchFilt = design(notchSpecs,'SystemObject',true);
        post_align_struct.l_rcs_lfp.key2 = notchFilt(post_align_struct.l_rcs_lfp.key2);
    end
end

if notch == 3
    for i = 1:size(notch_f,2)
        freqRatio = 2*(notch_f(i))/500;
        notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,bandwidth,0.1);
        notchFilt = design(notchSpecs,'SystemObject',true);
        post_align_struct.l_rcs_lfp.key3 = notchFilt(post_align_struct.l_rcs_lfp.key3);
    end
end

if notch == 4    
    for i = 1:size(notch_f,2)
        freqRatio = 2*(notch_f(i))/500;
        notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,bandwidth,0.1);
        notchFilt = design(notchSpecs,'SystemObject',true);
        post_align_struct.l_rcs_lfp.key0 = notchFilt(post_align_struct.l_rcs_lfp.key0);
        post_align_struct.l_rcs_lfp.key2 = notchFilt(post_align_struct.l_rcs_lfp.key2);
        post_align_struct.l_rcs_lfp.key3 = notchFilt(post_align_struct.l_rcs_lfp.key3);
    end
end


if isfield(post_align_struct,"r_rcs_lfp") == 1

    [b,a] = butter(6,[filter_above/(Fs/2) filter_below/(Fs/2)],'bandpass');
    post_align_struct.r_rcs_lfp.key0 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key0);
    post_align_struct.r_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key2);
    post_align_struct.r_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key3);
    
    if notch == 4
        for i = 1:size(notch_f,2)
            freqRatio = 2*(notch_f(i))/500;
            notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,bandwidth,0.1);
            notchFilt = design(notchSpecs,'SystemObject',true);
            post_align_struct.r_rcs_lfp.key0 = notchFilt(post_align_struct.r_rcs_lfp.key0);
            post_align_struct.r_rcs_lfp.key2 = notchFilt(post_align_struct.r_rcs_lfp.key2);
            post_align_struct.r_rcs_lfp.key3 = notchFilt(post_align_struct.r_rcs_lfp.key3);
        end
    end

end

end