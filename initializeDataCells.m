% Initialize Data Cells

% Bin-Average Potential Energies
PEbin = cell(nDirs,1);

% V2_RMS 
normVelbin = cell(nDirs,1); 

% Shear Band Size in Length Units
bandsize = cell(nDirs,1);

% Bin Indicies of Shear Band Extents
bandext = cell(nDirs,1);                                                

% Log(PE) 
pelog = cell(nDirs,1); 

% Log(Strain Rate)
sdotlog = cell(nDirs,1);                                                

% x-Displacement, time-rate of change of displacement, strain rate
ux_Bin = cell(nDirs,1);                                                 
d2udydt = cell(nDirs,1);
dudtBin = cell(nDirs,1);

% Average PE, Strain rate and respective standard error 
%   across n data points for log plot where 
%   n = n_average_points (see "setDefaultParameters.m")
pe_mean = cell(nDirs,1);                                                
sr_mean = cell(nDirs,1);                                                
pe_dev = cell(nDirs,1);                                                 
sr_dev = cell(nDirs,1);                                                     

% PE, strain rate inside shear band
PEband = cell(nDirs,1);
SRband = cell(nDirs,1);