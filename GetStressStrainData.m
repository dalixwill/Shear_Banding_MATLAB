function GetStressStrainData(filepaths,units)
% Plots stress-strain data for multiple LAMMPS dump files on single figure.
% Includes main plot up to 20% strain, subplot from 200 - 1000% strain, and
% text corresponding to steady-state stress values for each specimen.

    % Determine the number of datafiles
    [~,nFiles] = size(filepaths);   
    
    

    stress = cell(nFiles,1);
    strain = cell(nFiles,1);
    timestep = cell(nFiles,1);
    cmap = colormap('lines');
    
    switch units
        case {'LJ','lj','LennardJones'}
            quenchrateunits = '\tau';
            stressunits = '';
        case {'Metal','metal'}
            quenchrateunits = 'K ps^{-1}';
            stressunits = 'GPa';
    end
    hold on
    for i = 1:nFiles
        filename = char(filepaths(i));
        filedata = importdata(filename,' ',1);
        plot(filedata.data(:,11),filedata.data(:,10))
    end
    hold off
    xlim([0 0.2])
     return
     

    for i = 1:nFiles
        
        filename = char(filepaths(i));
        filedata = importdata(filename, ' ', 1);        
        [nrow,ncol] = size(filedata.data(:,1));
        
%         plot(filedata.data(:,11),filedata.data(:,10))
%         return
        % Ensure that first data point corresponds to time == 0.
        if filedata.data(1,11) == 0
%             strain{i} = filedata.data(:,12);
%             stress{i} = filedata.data(:,11);
%             timestep{i} = filedata.data(:,1);
            strain{i} = filedata.data(:,11);
            stress{i} = filedata.data(:,10);
            timestep{i} = filedata.data(:,1);
        else
            strain{i} = zeros(nrow+1,ncol);
            stress{i} = zeros(nrow+1,ncol);
            timestep{i} = zeros(nrow+1,ncol);
%             strain{i}(2:end,1) = filedata.data(:,12);
%             stress{i}(2:end,1) = filedata.data(:,11);
%             timestep{i}(2:end,1) = filedata.data(:,1);
            strain{i}(2:end,1) = filedata.data(:,11);
            stress{i}(2:end,1) = filedata.data(:,10);
            timestep{i}(2:end,1) = filedata.data(:,1);
        end

        switch units
            case {'LJ','lj','LennardJones'}
                stress{i} = stress{i}*10000;
        end
        
        % Determine the total magnitude of strain drop (box flipping).
        emax = max(strain{i}); 
        emin = min(strain{i}); 
        dele = abs(emin-emax);
        diffe = diff(strain{i});
        imax = find(abs(diffe) > dele/2) + 1; % Indices where flips occur
        count_max = length(imax);
        
        % Create temporary strain array containing monotomically increasing
        % strain values. Replace original strain array.
        e = zeros(length(strain{i}),1);
        e(1:imax(1)) = strain{i}(1:imax(1));
        count = 1;
        while count <= count_max
            if count == count_max
                e(imax(count):end) = ...
                    strain{i}(imax(count):end)+count*dele;
            else
                e(imax(count):imax(count+1)) = ...
                    strain{i}(imax(count):imax(count+1))+count*dele;
            end
            count = count + 1;
        end
        strain{i} = e; 

    end
    
    % Plot stress-strain data for multiple quench rates in a single figure
    % window. Plots up to 20% strain on main axes with subplot of strain
    % from 200 - 1000% in smaller subplot.
    
    for i = 1:nFiles
        if max(stress{i}(:)) > 3
            stress{i}(:) = stress{i}(:)/10000;
        end
    end
    
    % Main plot (parent figure)      
    legendtext = cell(nFiles,1);
    sigmean = cell(nFiles,1);
    f3 = figure;
    hold on
    for i = 1:nFiles
        plot(strain{i},stress{i},'LineWidth',2,...
            'color',cmap(i,:))
        sigmean{i} = mean(stress{i}(strain{i}>2));
        legendtext{i} = ['QR ' quenchrateunits ...
            ' ; \sigma_{ss} = ' num2str(sigmean{i}) ' ' stressunits];
    end
    hold off
    axis tight;
    xlim([0 1])
    title({'Stress vs. Strain',''});
    xlabel({'','Strain'});
    ylabeltext = ['Stress (' stressunits ')'];
    ylabel({ylabeltext,''});
    legend(legendtext,'Location','northeast')

    % Subplot (child figure)
    ax2 = axes('Parent',f3,'Position',[.35,.16,.51,.23]);    
    hold on
    for i = 1:nFiles
        esmooth = smooth(stress{i},500); 
        plot(strain{i},esmooth,'color',cmap(i,:),...
            'LineWidth',2,'Parent',ax2)
%         plot(strain{i},stress{i},':',...
%             'color',cmap(i,:))
    end
    hold off
    axis tight;
    xlim([2 10]);

end

function plotFileData(dataval,colheaders,xlabel,ylabel)

    nFiles = size(dataval,2);
    ncolheaders = size(colheaders,2);
    
    for i = 1:ncolheaders
        switch colheaders{i}
            case 'Step'
            case 'Temp'
            case 'Press'
            case 'PotEng'
            case 'TotEng'
            case 'Volume'
            case 'Pxx'
            case 'Pyy'
            case 'Pzz'
            case 'Pxy'
            case 'Xy'
        end              
    end
end