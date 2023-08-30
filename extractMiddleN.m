function middleValues = extractMiddleN(inputArray, n)
    if n > length(inputArray)
        error('n should not be greater than the length of the input array');
    end
    
    middleIndex = ceil(length(inputArray) / 2);
    halfWindowSize = floor(n / 2);
    
    if mod(n,2) == 0
        startIndex = middleIndex - (halfWindowSize - 1);
        endIndex = middleIndex + halfWindowSize;
    else
        startIndex = middleIndex - halfWindowSize;
        endIndex = middleIndex + halfWindowSize;
    end
    
    middleValues = inputArray(startIndex:endIndex);
end