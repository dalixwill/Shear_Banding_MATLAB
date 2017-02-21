% ---
%
%   generateShearBandFigures.m
%
%   Created By:     Darius Alix-Williams
%   Created On:     Wednesday, November 2nd, 2016
%   Last Updated:   Thursday, November 3rd, 2016
%
%   Description:
%
%       This script runs 'showBanding.m' using LAMMPS output data from
%       various simulations of shear banding in amorphous solids. The
%       results include figures of strain rate as a function of potential
%       energy as well as the strain evolution of the shear band.
%
%   Parameters:
%
%       For a complete list of parameters, see the documentation for
%       "showBanding.m" The chosen input parameters for the default runs
%       are as follows:
%
%       (1) system - toggle between silicon (si), Cu64Zr36 (cz) or
%       two-dimensional Lennard-Jones quasi-crystal (lancon). Choosing a
%       system sets defaults such as time step, atom type and units.
%       Default system is two-dimensional Lennard-Jones (2DLJ).
%
%       (2) nBins - set the number of spatial bins to which per-atom 
%       properties such as potential energy and displacement are
%       calculated. These bins are generated along the y-direction.
%       Default is 50 bins.
%
%       (3) span - control the number of data points by which log(strain)
%       as a function of potential energy data is aggregated and averaged.
%       Larger values reduce resolution and error, but may not capture the
%       values of high-strain where material is transitioning from jammed
%       to flowing in systems where interfaces are sharp.
%       Default is 50 points.
%       
%       (4) is_constant - toggle that controls the generation of
%       system-averaged band width evolution and log(strain rate) plots.
%       By default this toggle is off.
%
%       (5) average_along - for calculation of system-specific figures,
%       determine whether to average over increasing values of strain rate
%       or potential energy. This parameter works in conjunction with
%       'average_along' to generate log(strain rate) figures. Averaging is
%       done along potential energy by default.
%
%       (6) match_strain - for file directories where many system snapshots
%       are located, but should not be used to generate figures, control
%       the strain values that are used in the analysis. Input is in the
%       form of an array whose values correspond to desired strain
%       increments. By default, integer values from 0 - 10 are included.
%
%       (7) quench_duration - this value is used in figure legends and
%       corresponds to the labels of each system. If the LAMMPS data
%       corresponds to simulations at constant quench rate/duration, can
%       substitute cell values for strain rates. Required, no default.
%
%       (8) strainrate - set the imposed strain rate for the chosen system.
%       This value has no defaults and is required.
%       
%       (9) runnumber - this value is used in figure titles, legends and
%       corresponds to the run number of a particular simulation. It is
%       required and has no default.
%
%       (10) straininc - this value will be discontinued in a future update
%       but corresponds to the smallest desired strain increment between
%       simulations whose directory contain many superfluous snapshots.
%
%   Notes:
%
%       (1) To run this program, click into each section to highlight it,
%       then press "Run Section" in the Editor toolbar.
%
%       (2) Requisite files are on HHPC and MARCC clusters. To access,
%       please mount these drives prior to running Step 2.
%
%       (3) At present, this function only outputs data to screen but does
%       not generate/save tables or function values. This functionality is
%       to be included in a future release.
%
%       (4) Due to the large nature of data generated and system memory
%       constraints, this code is designed to work with, at maximum, three 
%       directories with up to 110 files in each. A less memory-intensive
%       version of the code will be available in a future release.
%
% ---

%% Step 1 - Clear Workspace, Close Open Figures

clc
close all
clear all

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Silicon (Si) 
%       Runs:           ALL
%       Quench Rate:    1e10 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e10/sr_00010/data/';
system_2 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e10/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e10/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','si',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.4 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'.010','.010','.010'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Silicon (Si) 
%       Runs:           ALL
%       Quench Rate:    1e11 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e11/sr_00010/data/';
system_2 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e11/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e11/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','si',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'.100','.100','.100'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Silicon (Si) 
%       Runs:           ALL
%       Quench Rate:    1e12 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/Si/run0/shear/qr_1e12/sr_00010/data/';
system_2 = '/Volumes/MARCC/scratch/Si/run1/shear/qr_1e12/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e12/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','si',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'1.00','1.00','1.00'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Cu64Zr36 (CZ) 
%       Runs:           ALL
%       Quench Rate:    1e09 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e09/run0/sr_0001/DATA/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e09/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e09/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'.001','.001','.001'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'loginc',2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Cu64Zr36 (CZ) 
%       Runs:           ALL
%       Quench Rate:    1e10 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e10/run0/sr_00010/DATA/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e10/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e10/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'.010','.010','.010'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'loginc',2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:         Cu64Zr36 (CZ) 
%       Runs:           ALL
%       Quench Rate:    1e09 K/ps 
%       Strain Rate:    0.00010 1/ps
%
% ---

system_1 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run0/qr_1e11/run0/sr_00010/DATA/';
system_2 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run1/shear/qr_1e11/sr_00010/data/';
system_3 = '/Volumes/MARCC/scratch/CuZr/4x20x1_Cu64Zr36_Glasses/run2/shear/qr_1e11/sr_00010/data/';

showBanding({system_1,system_2,system_3},...
    'system','cz',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'.100','.100','.100'},...
    'strainrate','0.0001',...
    'straininc',0.2,...
    'runnumber','1')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:             Lancon (LJ) 
%       Runs:               ALL
%       Quench Duration:    1e4 t0 
%       Strain Rate:        0.00010 1/t0
%

structure_1 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run0/shear/t0_1e4/sr_00002/data/';
structure_2 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run1/shear/t0_1e4/sr_00002/data/';
structure_3 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run2/shear/t0_1e4/sr_00002/data/';


showBanding({structure_1,structure_2,structure_3},...
    'system','lancon',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'1e4','1e4','1e4'},...
    'strainrate','0.00002',...
    'straininc',0.2,...
    'runnumber','0')

%%  Step 2 - Choose Input File Directory(ies), Run 'showBanding.m'
%
%       System:             Lancon (LJ) 
%       Runs:               ALL
%       Quench Duration:    1e5 t0 
%       Strain Rate:        0.00010 1/t0
%

structure_1 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run0/shear/t0_1e5/sr_00002/data/';
structure_2 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run1/shear/t0_1e5/sr_00002/data/';
structure_3 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run2/shear/t0_1e5/sr_00002/data/';


showBanding({structure_1,structure_2,structure_3},...
    'system','lancon',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 0.6 0.8 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'1e5','1e5','1e5'},...
    'strainrate','0.00002',...
    'straininc',0.2,...
    'runnumber','0')

%% 2DLJ Quench Duration = 1e5 t0
% Log(Strain Rate) vs. Potential Energy

close all

structure_1 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run0/shear/t0_1e5/sr_00002/data/';
structure_2 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run1/shear/t0_1e5/sr_00002/data/';
structure_3 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run2/shear/t0_1e5/sr_00002/data/';


showBanding({structure_1,structure_2,structure_3},...
    'system','lancon',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'1e5','1e5','1e5'},...
    'strainrate','0.00002',...
    'straininc',0.2,...
    'runnumber','0')


%% 2DLJ Quench Duration = 1e6 t0
% Log(Strain Rate) vs. Potential Energy

close all

structure_1 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run0/shear/t0_1e6/sr_00002/data/';
structure_2 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run1/shear/t0_1e6/sr_00002/data/';
structure_3 = '/Volumes/HHPC/Research/runs/LJ/Lancon-et-al/run2/shear/t0_1e6/sr_00002/data/';


showBanding({structure_1,structure_2,structure_3},...
    'system','lancon',...
    'nBins',100,...
    'span',50,...
    'is_constant','both',...
    'averagealong','strainrate',...
    'match_strain',[0 1 2 3 4 5 6 7 8 9 10],...
    'quenchduration',{'1e6','1e6','1e6'},...
    'strainrate','0.00002',...
    'straininc',0.2,...
    'loginc',1,...
    'runnumber','0')

%%  Step 3 - Save Figures 
%       NOTE: User input required - see MATLAB workspace for prompts.

% Prompt user to save figures, store response as string
saveme = input('Would you like to save these figures?\n','s');

switch lower(saveme)
    % If a positive response is give, prompt user for directory name then
    % save figures as .png, .fig files in respective subdirectories.
    case {'yes','y','true','ok','okay'}
        dirname = input('What should we name the directory?\n','s');
        mkdir(dirname);
        mkdir(dirname,'png')
        mkdir(dirname,'fig')
        h = get(0,'children');
        for i = 1:length(h)
            saveas(h(i),strcat(dirname,'/png/figure',num2str(get(h(i),'Number'))),'png')
            saveas(h(i),strcat(dirname,'/fig/figure',num2str(get(h(i),'Number'))),'fig')
        end
    % Otherwise, promt user that nothing was saved.
    otherwise
        disp('No figures were saved.')
end
