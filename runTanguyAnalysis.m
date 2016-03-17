%% Tanguy Si Glasses, Strain Rate = 0.0005 1/ps

close all

system_1 = '~/Google Drive/Research/Tanguy/qr_5e10/sr_0005/';
system_2 = '~/Google Drive/Research/Tanguy/qr_1e11/sr_0005/';
system_3 = '~/Google Drive/Research/Tanguy/qr_5e11/sr_0005/';

showBanding({system_3,system_2,system_1},...
    'system','Si','nBins',100,'span',20,'averagealong','potentialenergy')

%% Tanguy Si Glasses, Strain Rate = 0.0001 1/ps

close all

system_1 = '~/Google Drive/Research/Tanguy/qr_5e11/sr_0001/';
system_2 = '~/Google Drive/Research/Tanguy/qr_1e11/sr_0001/';
system_3 = '~/Google Drive/Research/Tanguy/qr_5e10/sr_0001/';

showBanding({system_1,system_2,system_3},...
    'system','Si','nBins',100,'span',20,'averagealong','strainrate')

%% Tanguys Si Glasses, Strain Rate = 0.00002 1/ps

close all

system_1 = '~/Google Drive/Research/Tanguy/qr_5e11/sr_00002/';
system_2 = '~/Google Drive/Research/Tanguy/qr_1e11/sr_00002/';
system_3 = '~/Google Drive/Research/Tanguy/qr_5e10/sr_00002/';

showBanding({system_1,system_2,system_3},...
    'system','Si','nBins',100,'span',20,'averagealong','strainrate')

%% Tanguy Si Glasses, Strain Rate = 0.0005 1/ps, Short Run

close all

system_1 = '~/Google Drive/Research/Tanguy/qr_5e10/sr_0005/short/';
system_2 = '~/Google Drive/Research/Tanguy/qr_1e11/sr_0005/short/';
system_3 = '~/Google Drive/Research/Tanguy/qr_5e11/sr_0005/short/';

showBanding({system_3,system_2,system_1},...
    'system','Si','nBins',100,'span',20,'averagealong','strainrate')