    % Figure - Strain Rate in Band vs. Percent Strain
    
    figure
    hold on
    for i = 1:nDirs
        maxstrain = numel(SRband{i});
        plot((1:maxstrain)*100,SRband{i},...
            'color',cmap(i,:),...
            'Marker',markermap(i),...
            'MarkerFaceColor','auto',...
            'MarkerSize',markersize,...
            'LineWidth',linewidth)
    end
    hold off
    
    plotdata = get(gca,'Children');
    set(plotdata,'visible','on')
    xlabeltext = 'Percent Strain';
    xlabel({'',xlabeltext},'FontSize',fontsize)
    ylabeltext = 'Strain Rate in Band';
    ylabel({ylabeltext,''},'FontSize',fontsize)
    titletext_l1 = 'Strain Rate vs. Percent Strain';
    titletext_l2 = [title_name,shorttitletext];
    title({titletext_l1,titletext_l2});
    figlegnd = legend(systemnames,'Location','eastoutside');
    lgndtitle = get(figlegnd,'Title');
    legendtitletext = ['Run ',runnum];
    set(lgndtitle,'String',legendtitletext);
    legend boxoff
    set(gca,'FontSize',fontsize)
    
    % Maximize Plot Window
    set(gcf,'WindowStyle','docked');
    