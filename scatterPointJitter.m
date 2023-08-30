function jittered_pos = scatterPointJitter(n_vals,min,max)

if ~exist('min','var') || ~exist('max','var') || ~exist('n_vals','var')
    error('Not enough input arguments.');
end

p = 6;
jittered_pos = min + (max - min)*sum(rand(n_vals,p),2)/p;
end