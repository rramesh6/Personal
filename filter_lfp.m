function post_align_struct = filter_lfp(post_align_struct, filter_above, filter_below, notch)

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
post_align_struct.l_rcs_lfp.key1 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key1);
post_align_struct.l_rcs_lfp.key2 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key2);
post_align_struct.l_rcs_lfp.key3 = filtfilt(b,a,post_align_struct.l_rcs_lfp.key3);

if notch == 1
    Fc = 150.6;
    BW = 50;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);

    Fc = 150.6/2;
    BW = 1;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);
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