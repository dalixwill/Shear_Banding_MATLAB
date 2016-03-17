% Alix CuZr Analysis

%% These systems follow Ding's quench schedule, with the addition of 
%   a relaxation (energy minimization) step. In all cases, a single shear
%   band nucleates and grows.

close all

system_3 = '~/Google Drive/Research/Alix-CuZr/qr_1e09/sr_00010/';
system_2 = '~/Google Drive/Research/Alix-CuZr/qr_1e10/sr_00010/';
system_1 = '~/Google Drive/Research/Alix-CuZr/qr_1e11/sr_00010/';


showBanding({system_1},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'minstrainrate','Yes','Span',20,'averagealong','strainrate')