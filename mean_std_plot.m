function varargout = mean_std_plot(time,mu,std,axes,color_val,shade_alpha)
if isempty(axes)
    figure;
    axes = gca;
end

if isempty(mu) || isempty(std)
    error('Function needs at least the mean and standard deviation vectors');
end

if isempty(time)
    time = 1:length(mu);
end

if isempty(color_val)
    color_val = 'b';
end

if isempty(shade_alpha)
    shade_alpha = 0.4;
end

mu = mu(:)';        % Make sure it is a row vector
std = std(:)';      % Make sure it is a row vector
time = time(:)';    % Make sure it is a row vector

shade_range = [mu-std, fliplr(mu+std)];

patch_hand = patch(axes,[time,fliplr(time)],shade_range,...
    color_val,...
    'facealpha',shade_alpha,...
    'edgecolor','none');

hold(axes,'on');
line_hand = plot(axes,time,mu,'Color',color_val,'linewidth',1.5);
hold(axes,'off');

varargout{1} = patch_hand;
varargout{2} = line_hand;
end