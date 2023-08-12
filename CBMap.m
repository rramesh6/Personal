function cmat = CBMap(mapName,nColors)

Pastel1 = [141,211,199;
255,255,179;
190,186,218;
251,128,114;
128,177,211;
253,180,98;
179,222,105;
252,205,229;
217,217,217;
188,128,189;
204,235,197;
255,237,111]./255;

Set1 = [228,26,28;
    55,126,184;
    77,175,74;
    152,78,163;
    255,127,0;
    255,255,51;
    166,86,40;
    247,129,191;
    153,153,153]./255;

Paired = [166,206,227;
31,120,180;
178,223,138;
51,160,44;
251,154,153;
227,26,28;
253,191,111;
255,127,0;
202,178,214]./255;

GaitEvents = [0, 158, 115;  % Green   = LHS
    0, 114, 178;            % Blue    = LTO
    213, 94, 0;             % Red     = RHS
    204, 121, 167]./255;    % Pink    = RTO

GaitEvents_OLD = [0, 0, 0;  % Black     = LHS
    144, 0, 23;             % Maroon    = LTO
    255, 14, 14;            % Red       = RHS
    255, 144, 33]./255;     % Orange    = RTO

% CommonBands = [100, 143, 255;   % Delta
%     120, 94, 240;               % Theta
%     220, 38, 127;               % Alpha
%     254, 97, 0;                 % Beta
%     255, 176, 0]./255;         % Gamma

CommonBands = [100, 143, 255;   % Delta
    0,0,0;                      % Theta
    0, 177, 159;                % Alpha
    240, 228,  66;              % Beta
    255,  84, 237]./255;        % Gamma

if strcmp(mapName,'GaitEvents')
    cmat.LHS = GaitEvents(1,:);
    cmat.LTO = GaitEvents(2,:);
    cmat.RHS = GaitEvents(3,:);
    cmat.RTO = GaitEvents(4,:);
elseif strcmp(mapName,'CommonBands')
    cmat.Delta = CommonBands(1,:);
    cmat.Theta = CommonBands(2,:);
    cmat.Alpha = CommonBands(3,:);
    cmat.Beta = CommonBands(4,:);
    cmat.Gamma = CommonBands(5,:);
else
    nValues = eval("size("+mapName+",1)");
    if nColors > nValues
        cmat = eval(mapName);
    else
        cmat = zeros(nColors,3);
        for i = 1:nColors
            cmat(i,:) = eval(mapName+"(i,:)");
        end
    end
end

end