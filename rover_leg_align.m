path = '/Users/Rithvik/Documents/UCSF/Wang Lab/Data/RCS_02/Rover/Left';
files = dir(fullfile(path,'*.CSV')); 

for i = 1:length(files)
    fname = fullfile(files(i).folder, files(i).name)
    opts = detectImportOptions(fname,'NumHeaderLines',6);
    opts = setvaropts(opts, 'Date', 'InputFormat', 'MM/dd/yy');
    df = readtable(fname, opts);
    df.Properties.VariableNames = {'Date','Time','QuatW','QuatX','QuatY','QuatZ','QuatSeqNum','AccelX','AccelY','AccelZ','AccelSeqNum'};
    