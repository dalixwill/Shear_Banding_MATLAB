% Function "ShowBanding" calculates atomic shear strain rate for LAMMPS
% molecular dynamics simulation data obtained using the fix print command.
%
% showBanding(SrcDirs,nBins,n_average_points,system,varargin)
% showBanding({'SrcDir1',...,'SrcDirN'})
% showBanding({'SrcDir1',...,'SrcDirN'},'ParameterName',ParameterValue)
%
% Required Input(s): None
% Optional Inputs:
%   {'SrcDir1',...,'SrcDirN'} - absolute path to directory(ies) containing
%       LAMMPS dump files. Default values is {'.'}, current working
%       directory.
%   nBins - number of bins by which all configurations are divided. Default
%       value is 50.
%   n_average_points -  number of raw data points for which average and
%       standard deviation are computed on log(strain rate) vs. potential
%       energy plots. Default value is 5.
%   system - the system determines the units, rates, relevant species to
%       include in averages and other parameters for analysis. Default
%       value is 'Lancon', a two-dimensional binary, Lennard Jones glass.
%           Ref. ###
% Default Output(s):
%   *** Figure numbers are only for enumeration in the following list and
%       may vary upon program execution. ***
%   figure 1 - 
%   figure 2 -
%   figure 3 -
%   figure 4 -
% Optional Output(s):
%   figure 1 -
%   figure 2 -
%   figure 3 -