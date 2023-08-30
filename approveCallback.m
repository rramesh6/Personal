function approveCallback(~, ~)
    % Get user input for the marker positions
    [x_RHS, ~] = ginput(1);
    [x_LTO, ~] = ginput(1);
    [x_LHS, ~] = ginput(1);
    
    % Store the selected x-positions in a separate matrix
    markerPositions = [x_RHS, x_LTO, x_LHS];
    disp('Selected marker positions:');
    disp(markerPositions);
end