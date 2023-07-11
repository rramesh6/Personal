function band_search(structure,key,step,freq_lim)

key_struct = struct();
key_struct.P = [structure.(['P_gait_' num2str(key)])' ones(size(structure.(['P_gait_' num2str(key)])',1),1); structure.(['P_nongait_' num2str(key)])' zeros(size(structure.(['P_nongait_' num2str(key)])',1),1)];
key_struct.F = structure.(['F_gait_' num2str(key)])(1:2001,1)';

u_map = [];
% p_map = [];
num_bands = [1:step:200];

for bs = num_bands

    band_vals = 0:(200/bs):200;
    
    band_idx = [];
    for i = 1:size(band_vals,2)
        [~,temp_idx] = min(abs(key_struct.F - band_vals(i)));
        band_idx = [band_idx temp_idx];
    end
    
    chunked = ones(size(key_struct.P,1),size(band_vals,2)-1);
    for i = 1:size(chunked,2)
        chunked(:,i) = mean(key_struct.P(:,band_idx(i):band_idx(i+1)),2);
    end
    
    u_chunks = [];
%     p_chunks = [];
    for i = 1:size(chunked,2)
        [p_chunk,h,stats] = ranksum(chunked(key_struct.P(:,end) == 1,i),chunked(key_struct.P(:,end) == 0,i));
        u_chunk = stats.ranksum;
        u_chunks = [u_chunks u_chunk];
%         p_chunks = [p_chunks p_chunk];
    end
    
    temp_u_vals = ones(size(key_struct.F));
%     temp_p_vals = ones(size(key_struct.F));
    for i = 1:size(u_chunks,2)
       temp_u_vals(band_idx(i):band_idx(i+1)) = u_chunks(i);
%        temp_p_vals(band_idx(i):band_idx(i+1)) = p_chunks(i);
    end
    
    u_map = [u_map; temp_u_vals];
%     p_map = [p_map; temp_p_vals];

end

figure()
h = heatmap(flip(u_map(:,1:freq_lim*10+1)),'GridVisible','off');
xlabel('Frequency (Hz)')
ylabel('Number of Bands')
title(['RCS02 Band Search - Wilcoxon Rank Sum - Key ' num2str(key)])
frequencies = cellfun(@num2str, num2cell(key_struct.F(1,1:freq_lim*10+1)), 'UniformOutput', false);
frequencies = string(frequencies);
frequencies(mod(key_struct.F(1,1:freq_lim*10+1),5) ~= 0) = " ";
h.XDisplayLabels = frequencies;
band_sizes = string(num_bands');
band_sizes(mod(num_bands(1,:),10) ~= 0) = " ";
band_sizes = flip(band_sizes);
h.YDisplayLabels = band_sizes;

% figure(13)
% h = heatmap(p_map,'GridVisible','off')
% xlabel('Frequency (Hz)')
% ylabel('Band Size (Hz)')
% title(['RCS02 Band Search - P-Values - Key ' num2str(key)])
% frequencies = cellfun(@num2str, num2cell(key_struct.F(1,:)), 'UniformOutput', false);
% frequencies = string(frequencies);
% frequencies(mod(key_struct.F(1,:),5) ~= 0) = " ";
% h.XDisplayLabels = frequencies;
% band_sizes = string(num_bands');
% band_sizes(mod(num_bands(1,:),10) ~= 0) = " ";
% band_sizes = flip(band_sizes);
% h.YDisplayLabels = band_sizes;
% colormap(flipud(colormap));

end













