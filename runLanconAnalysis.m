%% Lancon Binary LJ Glasses, Strain Rate = 0.0001 1/t0

close all

structure_1 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e5/sr_0001/';
structure_2 = '~/Google Drive/Research/Lancon-et-al/shear/t0_5e4/sr_0001/';
structure_3 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e4/sr_0001/';

showBanding({structure_3,structure_2,structure_1},...
    'system','lancon','nBins',100,'span',20,'averagealong','potentialenergy')

%% Lancon Binary LJ Glasses, Strain Rate = 0.0005 1/t0

close all

structure_1 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e5/sr_0005/';
structure_2 = '~/Google Drive/Research/Lancon-et-al/shear/t0_5e4/sr_0005/';
structure_3 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e4/sr_0005/';

showBanding({structure_3,structure_2,structure_1},...
    'system','lancon','nBins',100,'span',20,'averagealong','strainrate')

%% Lancon Binary LJ Glasses, Strain Rate = 0.00002 1/t0

close all

structure_1 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e5/sr_00002/';
structure_2 = '~/Google Drive/Research/Lancon-et-al/shear/t0_5e4/sr_00002/';
structure_3 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e4/sr_00002/';

showBanding({structure_3,structure_2,structure_1},...
    'system','lancon','nBins',100,'span',20,'averagealong','potentialenergy')
