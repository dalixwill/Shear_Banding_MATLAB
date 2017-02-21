% Set Default Parameters

% Include horizontal error bar module
path(path,'/Applications/herrorbar');

% Include Shape Language Modeling tools
path(path,'/Applications/SLMtools/SLMtools/');

% Suppress all warnings
warning('off','all');

% Set output to long fixed-decimal format
format long

% Set figure font size, line width, marker size
fontsize = 34;
linewidth = 4;
markersize = 34;

% Set default strain snapshots to display (units strain)
outconfigs = [1 3 5];

% Assume file location in present working directory if no alternate
% directory is provided.
if nargin == 0                                                          
    SrcDirs = {'.'};                                                    
end

% Assume system should be partitioned into 50 bins
nBins = 50;

% Assume log plots should be partitioned in groups of 50 data points
n_average_points = 50;

% Assume Lancon 2D LJ system
system = 'Lancon';

% Assume no lower limit on strain rate
min_strain_rate_res = 'no';

% Do not show spatially-averaged PE/SR vs. Position plots
show_filtered_data_figs = 'no'; 

% Assume periodic boundaries
periodic_bounds = 'yes';

% Do not display plots of fitting details at each interval
show_data_fit = 'off';

% Assume simulation box remapping
flip_data = 'Yes';

% Assume averaging takes place along potential energy
average_along = 'potentialenergy';

% Do not output fitting criterion on each interval
verbose_fit = 'off';

% Set global color, marker maps for each quench rate
cmap = [222,29,42; 164,131,196; 0,148,189]*(1/255);                     
markermap = ['o','^','s'];

% Default to type 1 species
atomtype = 1;

% Default log increment value
loginc = 1;
 
% Default plots assume constant strain rate
is_constant = 'strain_rate';

% Hide RMS Velocity plots by default
plot_vrms = 'false';

% Default strain increment = 100%
straininc = 1;
