%% See Early Band Initialization

%% Si - run 0 - qr 1e10
close all
dir = '/Volumes/MARCC/scratch/Si/';
dir1 = strcat(dir,'run0/shear/qr_1e10/sr_00010/data/HEAD/');
showBanding({dir1},...
    'system','Si',...
    'nBins',100,...
    'Span',50,...
    'averagealong','strainrate')

