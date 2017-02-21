function showBanding(SrcDirs,varargin)
functionHeader

%% Initialization of Data Structures, Defaults and Units

    % Set default parameters
    setDefaultParameters
    
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
    
    % Initialize Data Cells
    initializeDataCells
    
    pe0_mean = zeros(nDirs,1);
    pe0_dev = zeros(nDirs,1);
    dbwdt = zeros(nDirs,1);

    %% Data acquisition, parsing of each directory
    for i = 1:nDirs      
        
        % Concatonate Text for Title Bar
        longtitletext = [', Quench ',quench_type,' = ',...
            quenchduration{i}, ' ', quenchrateunits, ...
            ', Strain Rate = ',strainrate,' ',strainrateunits];
        shorttitletext = [', Strain Rate = ',strainrate,' ',strainrateunits];
        
        % Determine file extension, store data to arrays
        SrcDir = char(SrcDirs(i));
        [ntextfiles,~] = size(dir([SrcDir,'*.txt']));
        [ndatafiles,~] = size(dir([SrcDir,'*.data']));
        
        % Appropriate extension corresponds to most abundate files, browse
        % files and append data to corresponding cells.
        if ntextfiles > ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds,Vel] = ...
                sortData(SrcDir,'*.txt',...
                'at_strains',at_strain,...
                'alldata',straininc,...
                'strainrate',str2double(strainrate),...
                'timestep',tstep);
        elseif ntextfiles < ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds,Vel] = ...
                sortData(SrcDir,'*.data',...
                'at_strains',at_strain,...
                'alldata',straininc,...
                'strainrate',str2double(strainrate),...
                'timestep',tstep);
        else
            errortext = 'Unable to determine file extension.';
            error(errortext);
        end
        
        % Adjust Coordinates for Periodic Boundaries
        switch periodic_bounds
            case {'true','True','Yes','yes'}
                Pos = adjust_for_PBCs(Pos,Flgs,bounds);                     
        end
        
        % Compute Mean, Deviation of Initial PE
        pe0_mean(i) = mean(PE(Type(:,:,1)==atomtype,:,1));
        pe0_dev(i) = std(PE(Type(:,:,1)==atomtype,:,1));
        
        % Bin Atoms According to Y-Position
        Bins = binData(Pos,nBins,Flgs,bounds);

        % Include only Particular Atom Type
        cType = (Type(:,:,:)==atomtype);

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

        % Approximate PE, Strain Rate Inside Shear Band
        for config = 2:size(PEbin{i},3)
            A = bandext{i}(1,config-1);
            B = bandext{i}(2,config-1);
            PE_1 = PEbin{i}(1,A:B,config);
            PE_2 = [PEbin{i}(1,1:A-1,config) PEbin{i}(1,B+1:end,config)];
            PEband{i}(config-1) = max([mean(PE_1) mean(PE_2)]);
            PEjam{i}(config-1) = min([mean(PE_1) mean(PE_2)]);
            SR_1 = d2udydt{i}(1,A:B,config-1);
            SR_2 = [d2udydt{i}(1,1:A-1,config-1) ...
                        d2udydt{i}(1,B+1:end,config-1)];
            SRband{i}(config-1,:) = max([mean(SR_1) mean(SR_2)]);
        end
        
        % Free memory, delete variables
        clearvars A B PE_1 PE_2 SR_1 SR_2

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
    Points = [2 4 6 8];
    outconfigs = [1 2 4];
%     
    if ndatafiles > 11
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
 
    
    % Default Plot Format Values
    legendtext = cell(size(Points));                                        
    fontsize = 50;
    linewidth = 10;
    markersize = 34;
    
    % Toggle between figures for constant strain , quench rates
    switch is_constant
        
        case {'strain_rate'}

            
        case {'quench_rate'}

        
        % This case represents the overlay of several replicas on a single
        % figure, and should include error bars.
        case {'both'}

            %  aggregate data, plot Log of Band-Normalized Strain Rate 
            %  vs. Potential Energy with error bars.
            plotALLLogBandNormalizedStrainRatevsPotentialEnergy 
            
            % aggregate data, plot band width vs sqrt(shear strain) 
            % with error bars
            plotALLBandWidthvsSqrtShearStrain
        
    end
    
 
    % Plot Strain Rate, Log Strain Rate, Potential Energy Evolution
    plotStrainRateLogStrainRatePotentialEnergyEvolution
    
    % Plot log of band-normalized strain rate vs. Potential Energy
    plotLogBandNormalizedStrainRatevsPotentialEnergy

    % Plot Log of Strain Rate vs. Potential Energy
    plotLogStrainRatevsPotentialEnergy
% % % 
% % %     % Plot of Mean Log Norm Strain Rate vs. Potential Energy
%     plotMeanLogNormStrainRatevsPotentialEnergy
% % % 
% %     % Plot Band Width vs. Percent Shear Strain
%     plotBandWidthvsPercentShearStrain
% %     
    % Plot Band Width vs. Shear Strain^(0.5)    
    plotBandWidthvsSqrtShearStrain
% %     
    % Plot Fractional Coverage vs. Shear Strain^(0.5)
    plotFracCoveragevsSqrtShearStrain
    
    % Plot Scatter of Band Behavior
    scatter(pe0_mean,pe0_dev,50,dbwdt,'filled')
    
    % Plot Strain Rate vs. PE Band
    figure
    strain05 = sqrt(nsteps(2:end)*tstep*str2double(strainrate));
    hold on
    for i = 1:nDirs
       plot(strain05,PEband{i},...
           'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)
    end
    hold off
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



