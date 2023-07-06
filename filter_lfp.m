function post_align_struct = filter_lfp(post_align_struct, filter_above, filter_below, notch)

Fs = 500;

post_align_struct.l_rcs_lfp.key0 = highpass(post_align_struct.l_rcs_lfp.key0,filter_above,Fs);
post_align_struct.l_rcs_lfp.key0 = lowpass(post_align_struct.l_rcs_lfp.key0,filter_below,Fs);

post_align_struct.l_rcs_lfp.key1 = highpass(post_align_struct.l_rcs_lfp.key1,filter_above,Fs);
post_align_struct.l_rcs_lfp.key1 = lowpass(post_align_struct.l_rcs_lfp.key1,filter_below,Fs);

post_align_struct.l_rcs_lfp.key2 = highpass(post_align_struct.l_rcs_lfp.key2,filter_above,Fs);
post_align_struct.l_rcs_lfp.key2 = lowpass(post_align_struct.l_rcs_lfp.key2,filter_below,Fs);

post_align_struct.l_rcs_lfp.key3 = highpass(post_align_struct.l_rcs_lfp.key3,filter_above,Fs);
post_align_struct.l_rcs_lfp.key3 = lowpass(post_align_struct.l_rcs_lfp.key3,filter_below,Fs);

if notch == 1
    Fc = 150.6;
    BW = 25;
    wo = Fc/(Fs/2);
    bw = BW/(Fs/2);
    [b, a] = iirnotch(wo, bw);
    post_align_struct.l_rcs_lfp.key0 = filter(b,a,post_align_struct.l_rcs_lfp.key0);
    post_align_struct.l_rcs_lfp.key1 = filter(b,a,post_align_struct.l_rcs_lfp.key1);
    post_align_struct.l_rcs_lfp.key2 = filter(b,a,post_align_struct.l_rcs_lfp.key2);
    post_align_struct.l_rcs_lfp.key3 = filter(b,a,post_align_struct.l_rcs_lfp.key3);
end

end