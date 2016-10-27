% Figure - LogLog Plot of Band Width vs. Percent Shear Strain

figure
hold on  
for i = 1:nDirs
    pcnt = length(bandsize{i});
    loglog(log((1:pcnt)),log(bandsize{i}(1:pcnt)),...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)
end  
hold off
xlabeltext = 'Log of Shear Strain';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ['Log of Band Width (' distanceunits ')'];
ylabel({ylabeltext,''},'FontSize',fontsize)
yl = ylim;
xl = xlim;
xlim([0 xl(2)])
ylim([0 yl(2)])
titletext_l1 = 'Band Width Evolution';
titletext_l2 = [title_name, shorttitletext];
title({titletext_l1,titletext_l2});
figlegnd = legend(systemnames,'Location','eastoutside');
lgndtitle = get(figlegnd,'Title');
legendtitletext = ['Run ',runnum];
set(lgndtitle,'String',legendtitletext);
legend boxoff
set(gca,'FontSize',fontsize)

% Maximize Plot Window
set(gcf,'WindowStyle','docked');