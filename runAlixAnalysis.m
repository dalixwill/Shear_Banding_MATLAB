% Alix CuZr Analysis

%% These systems follow Ding's quench schedule, with the addition of 
%   a relaxation (energy minimization) step. In all cases, a single shear
%   band nucleates and grows.

close all

system_3 = '~/Google Drive/Research/Alix-CuZr/qr_1e09/sr_00010/';
system_2 = '~/Google Drive/Research/Alix-CuZr/qr_1e10/sr_00010/';
system_1 = '~/Google Drive/Research/Alix-CuZr/qr_1e11/sr_00010/';


showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'minstrainrate','Yes','Span',20,'averagealong','strainrate')

%% These systems follow Ding's quench schedule, with the addition of 
%   a relaxation (energy minimization) step. In all cases, a single shear
%   band nucleates and grows.

close all

system_3 = '~/Google Drive/Research/Alix-CuZr/qr_1e09/sr_00010/';
system_2 = '~/Google Drive/Research/Alix-CuZr/qr_1e10/sr_00010/';
system_1 = '~/Google Drive/Research/Alix-CuZr/qr_1e11/sr_00010/';


showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%%
close all
% File ID = CZ_q1e09_sr00010_run0_HHPC
% This run is missing strains for qr1e10, qr1e11. Was used to verify that
% quench at the slower rate would yield shear bands.

system_1 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/DATA/OVITO/';
showBanding({system_1},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%% RUN 0 (Good Run)
% File ID - CZ_qALL_sr00010_run0

close all
system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/qr_1e11/run0/sr0001/DATA/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/qr_1e10/run0/sr0001/DATA/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/qr_1e09/run0/sr_0001/DATA/MATLAB/';
showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%%
% File ID - CZ_qALL_sr00010_run1
% This file is essentially the same as the first run with the addition of a
% relaxation step. Will not consider it a unique run.

close all
system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e11/run0/sr0001/DATA/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e10/run0/sr0001/DATA/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e09/run0/sr_0001/DATA/MATLAB/';
showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',50,'averagealong','strainrate')

%%
% File ID - CZ_qALL_sr00010_run1
% This file is essentially the same as the first run with the addition of a
% relaxation step. Will not consider it a unique run.

close all
system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e11/run1/sr_0001/DATA/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e10/run1/sr_0001/DATA/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e09/run1/sr_0001/DATA/MATLAB/';
showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%%

close all
% File ID - CZ_qALL_sr00050_run0_HHPC
% Multiple bands form is system quenched at 1e09 K/s (system_3)

close all
system_1 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e11/sr_00050/DATA/MATLAB/';
system_2 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e10/sr_00050/DATA/MATLAB/';
system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00050/DATA/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%% SAME AS MARCC RUN. NOT UNIQUE.

close all
% File ID - CZ_qALL_sr00010_run0_HHPC
% Multiple bands form is system quenched at 1e10 K/s (system_3)

close all
system_1 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e11/sr_00010/DATA/MATLAB/';
system_2 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e10/sr_00010/DATA/MATLAB/';
% system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/qr_1e10/run0/sr0001/DATA/MATLAB/';
system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/DATA/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')

%% MARCC RUN - CZ (RUN0)
% Missing strain for qr=1e9 (system_3). Using another system as a placeholder.
% File ID - CZ_qALL_sr00010_run2

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e11/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e10/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e09/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/DATA/MATLAB/';

showBanding({system_1,system_2},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',20,'averagealong','strainrate')


%% MARCC RUN - CZ (RUN3)
% Missing strain for qr=1e9 (system_3). Using another system as a placeholder.
% File ID - CZ_qALL_sr00010_run2

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e11/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00010/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/DATA/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',30,'averagealong','strainrate')

%% MARCC RUN - CZ (RUN2)
% File ID - CZ_qALL_sr00010_run2

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e11/sr_00050/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00050/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00050/data/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',100,'Span',30,'averagealong','strainrate')

%% Cu64Zr36 - run2 - Strain Rate = 0.00050 1/ps

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e11/sr_00050/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00050/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00050/data/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0005',...
    'runnumber','2')

%% Cu64Zr36 - run1 - Strain Rate = 0.00010 1/ps

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e11/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e10/sr_00010/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e09/sr_00010/data/MATLAB/';

showBanding({system_1},...
    'system','cz',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0001',...
    'runnumber','1')

%% Cu64Zr36 - run0 - Strain Rate = 0.00050 1/ps

close all

system_1 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e11/sr_00050/DATA/MATLAB/';
system_2 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e10/sr_00050/DATA/MATLAB/';
system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00050/DATA/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0005',...
    'runnumber','0')

%% Cu64Zr36 - run0 - Strain Rate = 0.00010 1/ps

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e11/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e10/sr_00010/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/data/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0001',...
    'runnumber','0')

%% Cu64Zr36 - run2 - Strain Rate = 0.00010 1/ps

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e11/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00010/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',20,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0001',...
    'runnumber','2')

%% MARCC RUN - CZ (RUN###)
% Missing strain for qr=1e9 (system_3). Using another system as a placeholder.
% File ID - UNASSIGNED

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e09/run1/sr_0001/DATA/MATLAB/';
% system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e09/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/MATLAB/';

% system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/MATLAB/';
% system_3 = '/Volumes/HHPC/Research/runs/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/DATA/MATLAB/';
%system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e12/sr_00010/data/MATLAB/';

showBanding({system_1},...
    'system','Alix_CuZr','ShowDataFit','off',...
    'nBins',90,'Span',10,'averagealong','strainrate')


%% Cu64Zr36 - run2 - Strain Rate = 0.00010 1/ps

close all

system_3 = '/Volumes/MCCOY/Research/Shear_Banding/Cu64Zr36/AR_4x20x1/run_02/qr_1e09/sr_00010/MATLAB/';
system_2 = '/Volumes/MCCOY/Research/Shear_Banding/Cu64Zr36/AR_4x20x1/run_02/qr_1e10/sr_00010/MATLAB/';
system_1 = '/Volumes/MCCOY/Research/Shear_Banding/Cu64Zr36/AR_4x20x1/run_02/qr_1e11/sr_00010/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',80,...
    'span',10,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0001',...
    'runnumber','2')

%% Cu64Zr36 - ALL RUNS - Strain Rate = 0.00010 1/ps

close all

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/shear/qr_1e09/sr_00010/data/MATLAB/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e09/sr_00010/data/MATLAB/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/MATLAB/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',100,...
    'averagealong','strainrate',...
    'quenchduration',{'.100','.010','.001'},...
    'strainrate','0.0001',...
    'runnumber','1')