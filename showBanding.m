function showBanding(SrcDirs,varargin)
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

%% Initialization of Data Structures, Defaults and Units
    
    path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module
    path(path,'/Applications/SLMtools/SLMtools/');
    warning('off','all');                                                   % Suppress all warnings
    format long
    
    fontsize = 34;
    linewidth = 4;
    markersize = 34;
    outconfigs = [1 3 5];
    
    % new output based on strain
    
    % Defaults
    if nargin == 0                                                          % Set current working directory as location of
        SrcDirs = {'.'};                                                    % source files should no directory be given.
    end
    nBins = 50;
    n_average_points = 35;
    % Defaults, Switches
    system = 'Lancon';
    min_strain_rate_res = 'no';                                             % Switch governs minimum resolvable shear rate
    show_filtered_data_figs = 'no';                                         % Switch governs display of filtered plots 
    periodic_bounds = 'yes';                                          % Switch 
    show_data_fit = 'off';
    flip_data = 'Yes';
    average_along = 'potentialenergy';
    verbose_fit = 'off';
    % Set global color, marker maps for each quench rate
    cmap = [222,29,42; 164,131,196; 0,148,189]*(1/255);                     
    markermap = ['o','^','s'];
    type = 1;
    
    % Parse Optional Inputs
    parseOptionalInputParameters

    % Determine Number of Input Directories
    [~,nDirs] = size(SrcDirs);                                              

    % Set Default Log-Plot Averaging Value
    if isempty(n_average_points)                                           
        n_average_points = 25;                                              
    end                                                 

    % Set System Units, Default Text Values
    setSystemUnitsDefaults
    
    % Initialize data cells
    PEbin = cell(nDirs,1);                                                  % bin-averaged potential energies
    normVelbin = cell(nDirs,1); 
    
    bandsize = cell(nDirs,1);                                               % shear band size, system units
    bandext = cell(nDirs,1);                                                % indicies of band extents
    pelog = cell(nDirs,1);                                                  % potential energy from log analysis
    sdotlog = cell(nDirs,1);                                                % strain rate from log analysiss
    ux_Bin = cell(nDirs,1);                                                 % bin-averaged displacement in x
    d2udydt = cell(nDirs,1);                                                % strain rate
    pe_mean = cell(nDirs,1);                                                % average potential energy, log 
    sr_mean = cell(nDirs,1);                                                % average strain rate, log plot
    pe_dev = cell(nDirs,1);                                                 % potential energy standard deviation
    sr_dev = cell(nDirs,1);                                                 % strain rate standard deviation    
    dudtBin = cell(nDirs,1);
    PEband = cell(nDirs,1);
    SRband = cell(nDirs,1);

    %% Data acquisition, parsing of each directory
    for i = 1:nDirs      
        
        % Concatonate Text for Title Bar
        longtitletext = [', Quench ',quench_type,' = ',...
            quenchduration{i}, ' ', quenchrateunits, ...
            ', Strain Rate = ',strainrate,' ',strainrateunits];
        shorttitletext = [', Strain Rate = ',strainrate,' ',strainrateunits];
%         
%         function [longtitletext] = longtitletext(i)
%             longtitletext = [', Quench ',quench_type,' = ',...
%                 quenchduration{i}, ' ', timeunits, ...
%                 ', Strain Rate = ',strainrate,' ',strainrateunits];
%         end
        
        SrcDir = char(SrcDirs(i));
        [ntextfiles,~] = size(dir([SrcDir,'*.txt']));
        [ndatafiles,~] = size(dir([SrcDir,'*.data']));
        
        if ntextfiles > ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds,Vel] = sortData(SrcDir,'*.txt');
        elseif ntextfiles < ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds,Vel] = sortData(SrcDir,'*.data');
        else
            errortext = 'Unable to determine file extension.';
            error(errortext);
        end
        
        % Adjust Coordinates for Periodic Boundaries
        switch periodic_bounds
            case {'true','True','Yes','yes'}
                Pos = adjust_for_PBCs(Pos,Flgs,bounds);                     
        end
        
        % Bin Atoms According to Y-Position
        Bins = binData(Pos,nBins,Flgs,bounds);

        % Include only Particular Atom Type
        cType = (Type(:,:,:)==type);
        
        % Calculate Per-Atom, Per-Bin Mean Square Velocity
        vel_sqr = Vel.*Vel; 
        
        vel_sqr_norm = sum(vel_sqr,2);        
        normVelbin{i} = averageBins(Bins,vel_sqr_norm,cType);

        % Plot Mean Square Velocity Profile
        plotMeanSquareVelocityProfile
        
        % Compute Bin-Averaged Potential Energy 
        PEbin{i} = averageBins(Bins,PE,cType);
        
        % Calculate Simulation Length, Bin Height, Time Between Snapshots 
        Ly = bounds(2,2,1) - bounds(2,1,1);                                 
        hBin = Ly/nBins;                                                    
        dt = diff(nsteps,1,2)*tstep; 
        
        % Initialize Cells for Potential Energy, Strain Rate Data
        PEband{i} = zeros(ndatafiles,1);
        PEjam{i} = zeros(ndatafiles,1);
        SRband{i} = zeros(ndatafiles,1);
        PEnorm{i} = zeros(size(PEbin{i}));
        
        % Compute Shear Strain Rate, Displacement
        [d2udydt{i},ux_Bin{i},dudtBin{i}] = ...
            computeShearStrainRate(Pos,hBin,dt,Bins,cType);                 
        
        % Approximate Minimum Resolvable Strain Rate
        switch min_strain_rate_res
            case {'yes','YES','Yes'}
                SRres = log10(eps*hBin*dt(1));                             
            case {'No','no','NO'}
                SRres = -Inf;
        end

        % Approximate Band Extents, Size
        [bandext{i},bandsize{i}] = approx_bandwidth(ux_Bin{i},Ly,...
            'verbosefit',verbose_fit,'showDataFitting',show_data_fit);
             
        % Sort band extents
%         bandext{i} = sort(bandext{i});
        
        % Approximate PE, Strain Rate Inside Shear Band
        for config = 2:size(PEbin{i},3)
            A = bandext{i}(1,config-1);
            B = bandext{i}(2,config-1);

            PE_1 = PEbin{i}(1,bandext{i}(1,config-1):bandext{i}(2,config-1),config);
            PE_2 = [PEbin{i}(1,1:bandext{i}(1,config-1)-1,config) ...
                PEbin{i}(1,bandext{i}(2,config-1)+1:end,config)];
            PEband{i}(config-1) = max([mean(PE_1) mean(PE_2)]);
            PEjam{i}(config-1) = min([mean(PE_1) mean(PE_2)]);
            SR_1 = d2udydt{i}(1,bandext{i}(1,config-1):bandext{i}(2,config-1),config-1);
            SR_2 = [d2udydt{i}(1,1:bandext{i}(1,config-1)-1,config-1) ...
                d2udydt{i}(1,bandext{i}(2,config-1)+1:end,config-1)];
            SRband{i}(config-1,:) = max([mean(SR_1) mean(SR_2)]);
        end

        % Compute log of PE, Strain Rate 
        [pelog{i},sdotlog{i}] = ...
            computeLogStrainRate(d2udydt{i},PEbin{i},bandext{i},SRres);                          

        % Toggle Between Sorting Data by PE or SR for Log(SR) vs PE Plots
        switch average_along
            case {'strainrate','sr','SR','shearrate'}
                [sr_mean{i},pe_mean{i},sr_dev{i},pe_dev{i}] = ...
            computeAverageValues(sdotlog{i},pelog{i},n_average_points);
            case {'potentialenergy','pe','PE','energy'}
                [pe_mean{i},sr_mean{i},pe_dev{i},sr_dev{i}] = ...
            computeAverageValues(pelog{i},sdotlog{i},n_average_points);
        end
        

    end
    
    %% Figures Subsection
    
    % Desired Simulation Snapshots to Plot (in units strain)
    Points = [2,3,4,6,8];       
    Points = [2 3 4 5 6];
    Points = [2 4 6 8];
    
    if ndatafiles > 31
        % Convert Points from strain values to actual snapshots
        i_Points = ones(size(Points));
        acc_strain = str2num(strainrate)*nsteps*tstep;
        ntol = tstep*str2num(strainrate);
        for n = 1:numel(Points)
            i_Points(n) = find(acc_strain > Points(n) - ntol & ...
                acc_strain < Points(n) + ntol);
        end
    else
       i_Points = Points; 
    end
    
    outconfigs = [1 2 4];
    outconfigs = [1 2 4];
    
    % Default Plot Format Values
    legendtext = cell(size(Points));                                        
    fontsize = 50;
    linewidth = 10;
    markersize = 34;
 

    % Plot Strain Rate, Log Strain Rate, Potential Energy Evolution
    plotStrainRateLogStrainRatePotentialEnergyEvolution
    
    plotStrainRatePotentialEnergyEvolution
% 
%     %  Plot Log of Band-Normalized Strain Rate vs. Potential Energy
    plotALLLogBandNormalizedStrainRatevsPotentialEnergy
    
    plotLogBandNormalizedStrainRatevsPotentialEnergy
% %     % Plot Log of Strain Rate vs. Potential Energy
%     plotLogStrainRatevsPotentialEnergy
% % 
% %     % Plot of Mean Log Norm Strain Rate vs. Potential Energy
%     plotMeanLogNormStrainRatevsPotentialEnergy
% % 
% %     % Plot Band Width vs. Percent Shear Strain
%     plotBandWidthvsPercentShearStrain
% %     
%     % Plot Band Width vs. Shear Strain^(0.5)    
%     plotBandWidthvsSqrtShearStrain
    plotALLBandWidthvsSqrtShearStrain
% %     
%     % Plot Fractional Coverage vs. Shear Strain^(0.5)
%     plotFracCoveragevsSqrtShearStrain
% %     
%     % Plot Strain Rate in Band vs. PE in Band
%     plotBandStrainRatevsBandPE
%     
%     % Plot Strain Rate in Band vs. Percent Strain
%     plotBandStrainRatevsPercentStrain
% 
% %     % Plot Mean Potential Energy vs. Percent Strain
% %     plotPotentialEnergyEvolution
%     
%     % Plot Log(Band Width) vs. Log(Percent Shear Strain)
%     plotloglogBandWidthvsShearStrain
%     
%     % Plot Filtered Strain Rate, Potential Energy Evolution 
%     plotFilteredStrainRatePotentialEnergyEvolution
    
   
end



