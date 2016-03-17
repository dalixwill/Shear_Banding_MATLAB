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
    
    % Defaults
    if nargin == 0                                                          % Set current working directory as location of
        SrcDirs = {'.'};                                                    % source files should no directory be given.
    end
    nBins = 50;
    n_average_points = 5;
    % Defaults, Switches
    system = 'Lancon';
    min_strain_rate_res = 'no';                                             % Switch governs minimum resolvable shear rate
    show_filtered_data_figs = 'no';                                         % Switch governs display of filtered plots 
    periodic_bounds = 'yes';                                          % Switch 
    show_data_fit = 'off';
    flip_data = 'Yes';
    average_along = 'potentialenergy';
    verbose_fit = 'off';
    cmap = [222,29,42; 164,131,196; 0,148,189]*(1/255);                     % Set global color map for each quench rate
 
    % Parse optional input parameters
    opvarcount = 1;
    while opvarcount < numel(varargin)
       switch varargin{opvarcount}
           case {'nBins','Nbins','N','numBins','bins','BINS'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               nBins = varargin{opvarcount};
           case {'n_average_points','span','Span','averagingRange'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               n_average_points = varargin{opvarcount};
           case {'system','System','Units','units'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               system = varargin{opvarcount};
           case {'minstrainrate','minStrainRate','MinStrainRate'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               min_strain_rate_res = varargin{opvarcount};
           case {'showSmoothPlots','smoothPlots','filterData','smoothData'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               show_filtered_data_figs = varargin{opvarcount};
           case {'showDataFitting','ShowDataFit','ShowDataFitting'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               show_data_fit = varargin{opvarcount};
           case {'flipdata','FlipData','flipData'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               flip_data = varargin{opvarcount};
           case {'averagealong','AverageAlong','averageAlong'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               average_along = varargin{opvarcount};
           case {'verbosefit','VerboseFit','verboseFit'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               switch lower(varargin{opvarcount});
                   case {'yes','on','true'}
                       verbose_fit = 'true';
                   otherwise
                       verbose_fit = 'false';
               end
           case {'periodicbounds','PeriodicBounds','periodicBounds'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               switch lower(varargin{opvarcount})
                   case {'yes','on','true'}
                       periodic_bounds = 'true';
                   otherwise
                       periodic_bounds = 'false';
               end
           otherwise
               if ~ischar(varargin{opvarcount})
                   errtxt1 = [' ',num2str(varargin{opvarcount})];
                   error_l1 = strcat('Error!:',errtxt1);
               else
                   error_l1 = strcat('Error!:',varargin{opvarcount});
               end
               errorstatement = ' is an unrecognized input parameter.';
               error(strcat(error_l1,errorstatement));
       end
       opvarcount = opvarcount + 1;
    end
    
    
    

    [~,nDirs] = size(SrcDirs);                                              % Determine total number of directories

    % Set the default values for option arguments
    if isempty(n_average_points)                                            % Set default number of log points to consider
        n_average_points = 25;                                              % when averaging band-normalized strain rate.
    end                                                 

    % Allow user to specify units based on material system
    switch system
        case {'Lancon','lancon'}
            distanceunits = '\sigma';
            energyunits = '\epsilon';
            strainrateunits = '\tau^{-1}';
            type = 2; % Select Solute Atoms
            tstep = 0.005; % Default Timestep for LJ
            qrates = {'\boldmath$QR = 1e4 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 5e4 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 1e5 \hspace{.5mm} t_0$'};
            periodic_bounds = 'true';
            
        case {'2DLJ','2Dlj','2dlj'}
            distanceunits = '\sigma';
            energyunits = '\epsilon';
            strainrateunits = '\tau^{-1}';
            type = 2; % Select Solute Atoms
            tstep = 0.005; % Default Timestep for LJ
            qrates = {'\boldmath$QR = 1e5 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 5e5 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 1e6 \hspace{.5mm} t_0$'}; 
        case {'Alix_CuZr'}
            distanceunits = char(197);
            energyunits = 'eV';
            strainrateunits = 'ps^{-1}';
            qrates = {'\boldmath$QR = 1e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e10 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e09 \hspace{.5mm} K/s$'};
            type = 2; % Si
            tstep = 0.002;
            periodic_bounds = 'true';
        case {'Si','aSi','Silicon'}
            distanceunits = char(197);
            energyunits = 'eV';
            strainrateunits = 'ps^{-1}';
            qrates = {'\boldmath$QR = 5e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 5e10 \hspace{.5mm} K/s$'};
            type = 1; % Si
            tstep = 0.002;
            periodic_bounds = 'true';
       case {'3DLJ','3Dlj','3dlj'}
            distanceunits = '\sigma';
            energyunits = '\epsilon';
            strainrateunits = '\tau^{-1}';
            type = 1; % Select Solute Atoms
            tstep = 0.005; % Default Timestep for LJ
            qrates = {'\boldmath$QR = 1e4 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 5e4 \hspace{.5mm} t_0$',...
                        '\boldmath$QR = 1e5 \hspace{.5mm} t_0$'};
        case {'CuZr','CUZR'}
            distanceunits = char(197);
            energyunits = 'eV';
            strainrateunits = 'ps^{-1}';
            type = 2; % Select only Cu Atoms
            qrates = {'\boldmath$QR = 5e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 5e10 \hspace{.5mm} K/s$'};
            tstep = 0.002;
        case {'CuZrHybrid','Hybrid'}
            distanceunits = char(197);
            energyunits = 'eV';
            strainrateunits = 'ps^{-1}';
            type = 2; % Select only Cu Atoms
            qrates = {'\boldmath$QR = 1e12 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e11 \hspace{.5mm} K/s$',...
                        '\boldmath$QR = 1e10 \hspace{.5mm} K/s$'};
            tstep = 0.002;
    end

    % Initialize data cells
    PEbin = cell(nDirs,1);                                                  % bin-averaged potential energies
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
    

    %% Data acquisition, parsing of each directory
    for i = 1:nDirs      
        
        SrcDir = char(SrcDirs(i));
        [ntextfiles,~] = size(dir([SrcDir,'*.txt']));
        [ndatafiles,~] = size(dir([SrcDir,'*.data']));
        
        if ntextfiles > ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds] = sortData(SrcDir,'*.txt');
        elseif ntextfiles < ndatafiles
            [Type,Pos,Flgs,PE,nsteps,bounds] = sortData(SrcDir,'*.data');
        else
            errortext = 'Unable to determine file extension.';
            error(errortext);
        end

        switch periodic_bounds
            case {'true','True','Yes','yes'}
                Pos = adjust_for_PBCs(Pos,Flgs,bounds);                     % Adjust atomic coordinates for periodic bounds
        end
        
        Bins = binData(Pos,nBins,Flgs,bounds);                              % Sort atoms in bins according to position        
        cType = (Type(:,:,:)==type);                                        % Select atoms of desired type       
        PEbin{i} = averageBins(Bins,PE,cType);                              % Compute average PE of each bin
        Ly = bounds(2,2,1) - bounds(2,1,1);                                 % Sim cell length in y-direction
        hBin = Ly/nBins;                                                    % Height of each bin
        dt = diff(nsteps,1,2)*tstep;                                        % elapsed time between configurations    
        [d2udydt{i},ux_Bin{i}] = ...
            computeShearStrainRate(Pos,hBin,dt,Bins,cType);                 % Strain rate, displacement for each configuration
        save('uxbin.mat','ux_Bin')

        switch min_strain_rate_res
            case {'yes','YES','Yes'}
                SRres = log10(eps*hBin*dt(1));                              % Estimate minimum resolvable strain rate 
            case {'No','no','NO'}
                SRres = -Inf;
        end
%         [bandext{i},bandsize{i}] = approxBandExtents(ux_Bin{i},Ly);
        [bandext{i},bandsize{i}] = approx_bandwidth(ux_Bin{i},Ly,...
            'verbosefit',verbose_fit,'showDataFitting',show_data_fit);
%         disp(bandext{i})
%         disp(bandsize{i})
%         pause
%         [bandext{i},bandsize{i}] = findBandExtents(ux_Bin{i},Ly,...
%             'showDataFitting',show_data_fit,...
%             'flipdata',flip_data);           % Estimate band extents
        [pelog{i},sdotlog{i}] = computeLogStrainRate(...
            d2udydt{i},PEbin{i},bandext{i},SRres);                          % Compute log values, error
        
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
%     Points = [2,3,4,6,8];                                                   % Figures to include Points(i)x100 % strain
    Points = [2,3,4,6];
    legendtext = cell(size(Points));                                        % Set default cell size for legend text
    
    %   Potential Energy & Strain Rate vs. y-Position
    for i = 1:nDirs
        figure
        
        f(1) = subplot(1,2,1);
        hold on
        for j = 1:length(Points)
            plot(d2udydt{i}(:,:,Points(j)),linspace(0,Ly,nBins),...
                'LineWidth',2)
            legendtext{j} = [num2str(Points(j)-1) '00-'...
                num2str(Points(j)) '00%'];
        end
        hold off
        set(gca,'FontSize',14)
        xlabeltext = ['Strain Rate (' strainrateunits ')'];
        xlabel({'',xlabeltext},'FontSize',18)
        axis tight
        ylabeltext = ['y-Position (' distanceunits ')'];
        ylabel({ylabeltext,''},'FontSize',18)
        legend(legendtext)
        
        f(2) = subplot(1,2,2);
        hold on
        for j = 1:length(Points)
            plot(PEbin{i}(:,:,Points(j)),linspace(0,Ly,nBins),...
                'LineWidth',2)
        end
        PEshift = min(PEbin{i}(:,:,2)) - max(PEbin{i}(:,:,1));
        set(f(2),'yticklabel',[]);
        plot(PEbin{i}(:,:,1)+PEshift,linspace(0,Ly,nBins),...
            'k--','LineWidth',2)
        hold off
        set(gca,'FontSize',14)        
        xlabeltext = ['Potential Energy (' energyunits ')'];
        xlabel({'',xlabeltext},'FontSize',18)
        axis tight
    end

    %   Log of Band-Normalized Strain Rate vs. Potential Energy 
    figure
    hold on
    for i = 1:nDirs
        plot(pelog{i},sdotlog{i},'color',cmap(i,:),...
            'Marker','o','LineStyle','none')
    end
    hold off
    set(gca,'FontSize',14)
    xlabeltext = ['Potential Energy (' energyunits ')'];
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = ...
        '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
    ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
    titletext = 'Log of Strain Rate vs. Potential Energy';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex')       
   
    %   Log of Strain Rate vs. Potential Energy
    figure
    hold on
    for i = 1:nDirs
        % Flatten Data
        xdata = reshape(PEbin{i}(:,:,2:end),[1,numel(PEbin{i}(:,:,2:end))]);
        ydata = reshape(log(d2udydt{i}),[1,numel(d2udydt{i})]);
        % Filter Data
        xdata = xdata(ydata>SRres);
        ydata = ydata(ydata>SRres);
        % Format and Plot
        plot(xdata,ydata,'color',cmap(i,:),...
            'Marker','o','LineStyle','none');
    end
    hold off
    set(gca,'FontSize',14)
    xlabeltext = ['Potential Energy (' energyunits ')'];
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = '\boldmath$\ln(\dot{\epsilon_{pl}}) \newline$';
    ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
    titletext = 'Log of Strain Rate vs. Potential Energy';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex')       
 
    % Plot Average log(strain rate) vs. Potential Energy
    figure                                                          
    hold on
    for i = 1:nDirs
        plot(pe_mean{i},sr_mean{i},'color',cmap(i,:),...
            'Marker','o','LineStyle','none');
    end
    set(gca,'FontSize',14)
    xlabeltext = ['Potential Energy (' energyunits ')'];
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = ...
        '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
    ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
    titletext = 'Log of Strain Rate vs. Potential Energy';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex') 
    for i = 1:nDirs
        errorbar(pe_mean{i},sr_mean{i},sr_dev{i},'LineStyle','none',...
            'Color',cmap(i,:))
        h = herrorbar(pe_mean{i},sr_mean{i},pe_dev{i},pe_dev{i},'o');
        h(1).Color = cmap(i,:);
        h(2).Color = cmap(i,:);
    end
%     for i = 1:nDirs
%         herrorbar(pe_mean{i},sr_mean{i},pe_dev{i},pe_dev{i},'.')
%     end
    hold off
        
    %   Band Width vs. Percent Shear Strain
    figure
    hold on  
    for i = 1:nDirs
        pcnt = length(bandsize{i});
        plot((1:pcnt)*100,bandsize{i}(1:pcnt),...
            'color',cmap(i,:),'Marker','o','LineWidth',2)
    end  
    hold off
    set(gca,'FontSize',14)
    xlabeltext = 'Shear Strain (%)';
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = ['Band Width (' distanceunits ')'];
    ylabel({ylabeltext,''},'FontSize',18)
    yl = ylim;
    xl = xlim;
    xlim([0 xl(2)])
    ylim([0 yl(2)])
    titletext = 'Band Width Evolution';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex')
 
    %   Band Width vs. Shear Strain^(0.5)    
    figure
    hold on   
    for i = 1:nDirs
        pcnt = length(bandsize{i});
        plot(sqrt(1:pcnt),bandsize{i}(1:pcnt),...
            'color',cmap(i,:),'Marker','o','LineWidth',2)
    end  
    hold off  
    set(gca,'FontSize',14)
    xlabeltext = 'Shear Strain^{0.5}';
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = ['Band Width (' distanceunits ')'];
    ylabel({ylabeltext,''},'FontSize',18)
    yl = ylim;
    xl = xlim;
    xlim([0 xl(2)])
    ylim([0 yl(2)])
    titletext = 'Band Width Evolution';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex')
   
    
    %   Fractional Coverage vs. Shear Strain^(0.5)
    figure
    hold on   
    pcnt = Points(end);
    for i = 1:nDirs
        plot(sqrt(1:pcnt),bandsize{i}(1:pcnt)/Ly,...
            'color',cmap(i,:),'Marker','o','LineWidth',2)
    end  
    hold off  
    set(gca,'FontSize',14)
    xlabeltext = 'Shear Strain^{0.5}';
    xlabel({'',xlabeltext},'FontSize',18)
    ylabeltext = 'Fractional Coverage [--]';
    ylabel({ylabeltext,''},'FontSize',18)
    yl = ylim;
    xl = xlim;
    xlim([0 xl(2)])
    ylim([0 yl(2)])
    titletext = 'Band Width Evolution';
    title({titletext,''},'FontSize',20)
    legend(qrates,'Location','best','interpreter','latex')
    
    switch show_filtered_data_figs
        case {'yes','YES','Yes','on','ON','On'}            
            %   Potential Energy & Strain Rate vs. y-Position, Filtered Data
            legendtext = cell(size(Points));
            for i = 1:nDirs
                figure
                f(1) = subplot(1,2,1);
                hold on
                degree = 3;
                for j = 1:length(Points)          
                    tmpdata = [d2udydt{i}(:,end-degree+1:end,Points(j)) ...
                                d2udydt{i}(:,:,Points(j)) ...
                                d2udydt{i}(:,1:degree,Points(j))];
                    xdata = smooth(tmpdata,'moving');
                    xdata = xdata(degree+1:end-degree);
                    plot(xdata,linspace(0,Ly,nBins),...
                        'LineWidth',2)
                    legendtext{j} = [num2str(Points(j)-1) '00-'...
                        num2str(Points(j)) '00%'];
                end
                hold off
                set(gca,'FontSize',14)
                xlabeltext = ['Strain Rate (' strainrateunits ')'];
                xlabel({'',xlabeltext},'FontSize',18)
                axis tight
                ylabeltext = ['y-Position (' distanceunits ')'];
                ylabel({ylabeltext,''},'FontSize',18)
                legend(legendtext)

                f(2) = subplot(1,2,2);
                hold on
                for j = 1:length(Points)
                    tmpdata = [PEbin{i}(:,end-degree+1:end,Points(j)) ...
                                PEbin{i}(:,:,Points(j)) ...
                                PEbin{i}(:,1:degree,Points(j)) ];
                    xdata = smooth(tmpdata,'moving');
                    xdata = xdata(degree+1:end-degree);
                    plot(xdata,linspace(0,Ly,nBins),...
                        'LineWidth',2)
                end
                PEshift = min(PEbin{i}(:,:,2)) - max(PEbin{i}(:,:,1));
                set(f(2),'yticklabel',[]);
                plot(PEbin{i}(:,:,1)+PEshift,linspace(0,Ly,nBins),...
                    'k--','LineWidth',2)
                hold off
                set(gca,'FontSize',14)

                xlabeltext = ['Potential Energy (' energyunits ')'];
                xlabel({'',xlabeltext},'FontSize',18)
                axis tight
            end    
    end
end



