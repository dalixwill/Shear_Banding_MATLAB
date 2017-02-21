%   Figure - Strain Rate, Log Strain Rate, Potential Energy Evolution

% Desired strain increments on figure
outstrain = [2 4 6 8];

for i = 1:nDirs
    longtitletext = [', Quench ',quench_type,' = ',...
            quenchduration{i}, ' ', quenchrateunits, ...
            ', Strain Rate = ',strainrate,' ',strainrateunits];      
    
    % Plot strain rate vs. bin   
    figure
    f(1) = subplot(1,3,1);
    hold on
    for j = 1:length(outstrain)
        strain_idx = find(at_strain==(outstrain(j)));
        plot(d2udydt{i}(:,:,strain_idx),linspace(0,Ly,nBins),...
            'LineWidth',linewidth)
    end
    hold off
    set(gca,'FontSize',fontsize)
    xlabeltext = ['Strain Rate (' strainrateunits ')'];
    xlabel({'',xlabeltext},'FontSize',fontsize)
    axis tight
    ylabeltext = ['y-Position (' distanceunits ')'];
    ylabel({ylabeltext,''},'FontSize',fontsize)
    set(gca,'FontSize',fontsize)

    % Plot log(strain rate) vs. bin
    f(2) = subplot(1,3,2);
    hold on
    for j = 1:length(outstrain)
        strain_idx = find(at_strain==(outstrain(j)));
        plot(log(d2udydt{i}(:,:,strain_idx)),linspace(0,Ly,nBins),...
            'LineWidth',linewidth)
    end
    hold off        
    xlabeltext = ['Log Strain Rate (' strainrateunits ')'];
    xlabel({'',xlabeltext},'FontSize',fontsize)
    titletext_l1 = ...
        'Strain Rate, Log of Strain Rate and Potential Energy Evolution';
    titletext_l2 = [title_name, longtitletext];
    title({titletext_l1,titletext_l2});
    axis tight
    set(gca,'FontSize',fontsize)
    
    % Plot PE vs. bin
    f(3) = subplot(1,3,3);
    hold on
    plot(PEbin{i}(:,:,1),linspace(0,Ly,nBins),...
        'k--','LineWidth',linewidth)
    legendtext = cell(size(Points));
    legendtext{1} = '    0%';
    for j = 1:length(outstrain)
        strain_idx = find(at_strain==(outstrain(j)));
        plot(PEbin{i}(:,:,strain_idx),linspace(0,Ly,nBins),...
            'LineWidth',linewidth)
        legendtext{j+1} = ['    ', num2str(outstrain(j)) '00%'];
    end       
    hold off
    xlabeltext = ['Potential Energy (' energyunits ')'];
    xlabel({'',xlabeltext},'FontSize',fontsize)
    axis tight        
    figlegnd = legend(legendtext,...
        'Orientation','vertical',...
        'Location','none',...
        'Position',[0.855,0.44,0.109,0.169]);
    lgndtitle = get(figlegnd,'Title');
    legendtitletext = ['Run ',runnum];
    set(lgndtitle,'String',legendtitletext);
    legend boxoff
    set(gca,'FontSize',fontsize) 
    
    % Remove Tick Marks from Subplots 2,3
    set(f(2),'yticklabel',[]);
    set(f(3),'yticklabel',[]);
    
    % Set Figure Positions
    leftstart = 0.125;
    leftoffset = 0.23;
    bottomoffset = 0.20;
    height = 0.66;
    width = 0.22;
    set(f(1),'Position',[leftstart,bottomoffset,width,height],...
        'LooseInset',[0,0,0,0]);
    set(f(2),'Position',[leftstart+leftoffset,bottomoffset,width,height],...
        'LooseInset',[0,0,0,0]);
    set(f(3),'Position',[leftstart+2*leftoffset,bottomoffset,width,height],...
        'LooseInset',[0,0,0,0]); 
    
    % Maximize Plot Window
    set(gcf,'WindowStyle','docked');
    
end