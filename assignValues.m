function result = assignValues(numValues)
    step = 1;
    if numValues > 1
        step = 1 / (numValues - 1);
    end
    
    result = (-0.5:step:0.5) * (numValues > 1) + (0:step:1) * (numValues == 1);
    result = result - mean(result);
end