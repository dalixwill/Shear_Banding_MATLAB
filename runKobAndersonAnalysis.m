%% Kob-Anderson Binary LJ Glasses, Strain Rate = 0.0001 1/t0

close all

structure_1 = '~/Google Drive/Research/Lancon-et-al/shear/t0_1e5/sr_0001/';
structure_2 = '~/Google Drive/Research/Lancon-et-al/shear/t0_5e4/sr_0001/';
structure_3 = '~/Google Drive/Research/Kob-Anderson/t0_1e5/sr_00010/';
structure_2 = '~/Google Drive/Research/Kob-Anderson/t0_2e5/sr_00010/';
structure_1 = '~/Google Drive/Research/Kob-Anderson/t0_1e4/sr_00010/';
showBanding({structure_1},...
    'system','lancon','nBins',30,'span',20,'averagealong','strainrate',...
    'verbosefit','on')

%% Kob-Anderson Binary LJ Glass,
%   Orinal Dimensions
%   Shear Rate = 0.0005 1/t0

close all

structure_1 = '~/Google Drive/Research/Kob-Anderson/t0_5e4/sr_00050/';
structure_2 = '~/Google Drive/Research/Kob-Anderson/t0_1e5/sr_00050/';
structure_3 = '~/Google Drive/Research/Kob-Anderson/t0_2e5/sr_00050/';

showBanding({structure_1,structure_2,structure_3},...
    'system','lancon','nBins',50,'span',20,'averagealong','strainrate',...
    'verbosefit','off ','periodicbounds','false')

%% Kob-Anderson Binary LJ Glass,
%   Original Dimensions
%   Shear Rate = 0.0001 1/t0

close all
structure_1 = '~/Google Drive/Research/Kob-Anderson/t0_5e4/sr_00010/';
showBanding({structure_1},...
    'system','lancon','nBins',50,'span',20,'averagealong','strainrate',...
    'verbosefit','off ','periodicbounds','false')