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
    Fc = notch_f;
    BW = 50;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    %post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    %post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);

    Fc = notch_f/2;
    % for RCS02 and RCS05, BW = 1
    BW = bandwidth;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    %post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    %post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);
end

if notch == 2
    Fc = notch_f;
    BW = 50;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    %post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    %post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    %post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);

    Fc = notch_f/2;
    % for RCS02 and RCS05, BW = 1
    BW = bandwidth;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    %post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    %post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    %post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);
end

if notch == 3
    Fc = notch_f;
    BW = 50;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    %post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    %post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    %post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);

    Fc = notch_f/2;
    % for RCS02 and RCS05, BW = 1
    BW = bandwidth;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    %post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    %post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    %post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);
end

if notch == 4
%     Fc = notch_f;
%     BW = 50;
%     wo = Fc/(Fs/2);
%     bw = BW/(Fs/2);
%     [b, a] = iirnotch(wo, bw);
%     post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
%     %post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
%     post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
%     post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);

    freqRatio = 2*notch_f/500;
    notchSpecs  = fdesign.notch('N,F0,Q,Ap',2,freqRatio,4,0.1);
    notchFilt = design(notchSpecs,'SystemObject',true);
    post_align_struct.l_rcs_lfp.key0 = notchFilt(post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key2 = notchFilt(post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = notchFilt(post_align_struct.l_rcs_lfp.key3);

end


if isfield(post_align_struct,"r_rcs_lfp") == 1
    
    [b,a] = butter(6,[filter_above/(Fs/2) filter_below/(Fs/2)],'bandpass');
    post_align_struct.r_rcs_lfp.key0 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key0);
    post_align_struct.r_rcs_lfp.key1 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key1);
    post_align_struct.r_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key2);
    post_align_struct.r_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.r_rcs_lfp.key3);

    if notch == 1
        Fc = 150.6;
        BW = 50;
        wo = Fc/(Fs/2);
        bw = BW/(Fs/2);
        [b, a] = iirnotch(wo, bw);
        post_align_struct.r_rcs_lfp.key0 = filter(b,a,post_align_struct.r_rcs_lfp.key0);
        post_align_struct.r_rcs_lfp.key1 = filter(b,a,post_align_struct.r_rcs_lfp.key1);
        post_align_struct.r_rcs_lfp.key2 = filter(b,a,post_align_struct.r_rcs_lfp.key2);
        post_align_struct.r_rcs_lfp.key3 = filter(b,a,post_align_struct.r_rcs_lfp.key3);
    
        Fc = 150.6/2;
        BW = 1;
        wo = Fc/(Fs/2);
        bw = BW/(Fs/2);
        [b, a] = iirnotch(wo, bw);
        post_align_struct.r_rcs_lfp.key0 = filter(b,a,post_align_struct.r_rcs_lfp.key0);
        post_align_struct.r_rcs_lfp.key1 = filter(b,a,post_align_struct.r_rcs_lfp.key1);
        post_align_struct.r_rcs_lfp.key2 = filter(b,a,post_align_struct.r_rcs_lfp.key2);
        post_align_struct.r_rcs_lfp.key3 = filter(b,a,post_align_struct.r_rcs_lfp.key3);
    end

end

end