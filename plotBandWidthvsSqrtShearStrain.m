% Plot Band Width vs Square Root of Shear Strain

figure
hold on   
for i = 1:nDirs
    pcnt = length(bandsize{i});
    plot(sqrt(1:pcnt),bandsize{i}(1:pcnt),...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)
end  
hold off  

xlabeltext = 'Shear Strain^{0.5}';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ['Band Width (' distanceunits ')'];
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

% Plot Figure Window
set(gcf,'WindowStyle','docked');