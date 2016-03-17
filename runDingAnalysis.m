%% Run Din Analysis
% qr = 1e9 -> g(r) 2st max @ ~4.34 Angstroms -> Bin width ~ 9 Angstroms
%  Have 55 bins in y-direction

close all
system_1 = '~/Google Drive/Research/Ding-et-al/qr_1e11/sr_0001/';
system_2 = '~/Google Drive/Research/Ding-et-al/qr_1e10/sr_0001/';
system_3 = '~/Google Drive/Research/Ding-et-al/qr_1e9/sr_0001/';
% 
% showBanding({system_1},...
%     'nBins',55,'span',10,'system','CuZr','ShowDataFit','off',...
%     'minstrainrate','no','filterData','off','averagealong','strainrate',...
%     'showDataFitting','off','flipdata','no')

showBanding({system_3},...
    'system','CuZr','ShowDataFit','no','nBins',80)

%% This is a system quenched following Ding's protocol, with my dimension.
%   In many cases multiple shear bands nucleate. 

close all

system_1 = '~/Google Drive/Research/Ding-et-al/qr_1e11/sr_0005/';
system_2 = '~/Google Drive/Research/Ding-et-al/qr_1e10/sr_0005/';
system_3 = '~/Google Drive/Research/Ding-et-al/qr_1e9/sr_0005/';

showBanding({system_1,system_2,system_3},...
    'system','CuZr','ShowDataFit','no',...
    'nBins',80,'minstrainrate','Yes')

%% These systems follow Ding's quench schedule, with the addition of 
%   a relaxation (energy minimization) step. In all cases, a single shear
%   band nucleates and grows.

close all

system_3 = '~/Google Drive/Research/Alix-CuZr/qr_1e09/sr_0005/';
system_2 = '~/Google Drive/Research/Alix-CuZr/qr_1e10/sr_0005/';
system_1 = '~/Google Drive/Research/Alix-CuZr/qr_1e11/sr_0005/';


showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'minstrainrate','Yes','Span',20,'averagealong','strainrate')

%% These systems follow Ding's quench schedule, with the addition of
%   a relaxation (energy minimization) step. These systems have 1 x 3 x 1
%   aspect ratio. They were generated using Ding's restart files,
%   replicated in the y-direction, then minimized with respect energy while
%   allowing the simulation volume to adjust.

close all

system_1 = '~/Google Drive/Research/Hybrid-CuZr/run_0/qr_1e11/sr_0001/';
system_2 = '~/Google Drive/Research/Hybrid-CuZr/run_0/qr_1e10/sr_0001/';
system_3 = '~/Google Drive/Research/Hybrid-CuZr/run_0/qr_1e09/sr_0001/';

showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',50,'minstrainrate','Yes','Span',10,'averagealong','strainrate')