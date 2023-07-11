figure(8)
title('Average Power Spectral Density (key 1)')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
hold on
for i = 1:size(Pxx_key1_gait,2)
plot(F_key1_gait(:,1),10*log10(Pxx_key1_gait(:,i)),Color=[0,0,1,0.02])
end
plot(F_key1_gait(:,1),10*log10(mean(Pxx_key1_gait,2)),'b','LineWidth',1)
for i = 1:size(Pxx_key1_nongait,2)
plot(F_key1_gait(:,1),10*log10(Pxx_key1_nongait(:,i)),Color=[1,0,0,0.02])
end
plot(F_key1_nongait(:,1),10*log10(mean(Pxx_key1_nongait,2)),'r','LineWidth',1)
legend('Gait','Non-Gait')