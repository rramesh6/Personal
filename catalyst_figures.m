%% Average PSDs 

figure()
subplot(121)
mean_psd_fig(RCS05_poststim_noroverloss_key0,0)
title('GP')
xlim([0 50])
ylim([-85 -45])
subplot(122)
mean_psd_fig(RCS05_poststim_noroverloss_key2,2)
title('M1')
xlim([0 50])
ylim([-75 -35])
