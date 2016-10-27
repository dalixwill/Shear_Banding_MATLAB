%% aSi - run 0 - Strain Rate = 0.0005 1/ps

close all

structure_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e12/sr_00050/data/MATLAB/';
structure_2 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e11/sr_00050/data/MATLAB/';
structure_3 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e10/sr_00050/data/MATLAB/';

showBanding({structure_1,structure_2,structure_3},...
    'system','tanguy',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'1.00','0.10','0.01'},...
    'strainrate','0.0005',...
    'runnumber','0')

%% aSi - run 0 - Strain Rate = 0.0001 1/ps

close all

structure_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e12/sr_00010/data/MATLAB/';
structure_2 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e11/sr_00010/data/MATLAB/';
structure_3 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e10/sr_00010/data/MATLAB/';

showBanding({structure_1,structure_2,structure_3},...
    'system','tanguy',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'1.00','0.10','0.01'},...
    'strainrate','0.0001',...
    'runnumber','0')

%% aSi - run 0 - Quench Rate = 0.01 K/ps - Strain Rate = 0.00002 1/ps

close all

structure_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e12/sr_00002/data/MATLAB/';
structure_2 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e11/sr_00002/data/MATLAB/';
structure_3 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e10/sr_00002/data/MATLAB/';

showBanding({structure_1,structure_2,structure_3},...
    'system','tanguy',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'1.00','0.10','0.01'},...
    'strainrate','0.00002',...
    'runnumber','0')

%% aSi - run 1 - Strain Rate = 0.0001 1/ps

close all

structure_1 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e12/sr_00010/data/MATLAB/';
structure_2 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e11/sr_00010/data/MATLAB/';
structure_3 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e10/sr_00010/data/MATLAB/';

showBanding({structure_1,structure_2,structure_3},...
    'system','tanguy',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'1.00','0.10','0.01'},...
    'strainrate','0.0001',...
    'runnumber','1')

%% aSi - run 2 - Strain Rate = 0.0001 1/ps

close all

structure_1 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e12/sr_00010/data/MATLAB/';
structure_2 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e11/sr_00010/data/MATLAB/';
structure_3 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e10/sr_00010/data/MATLAB/';

showBanding({structure_1,structure_2,structure_3},...
    'system','tanguy',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'1.00','0.10','0.01'},...
    'strainrate','0.0001',...
    'runnumber','2')
