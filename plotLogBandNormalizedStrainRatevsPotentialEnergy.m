% Plot - Log of Band-Normalized Strain Rate vs. Potential Energy

figure
hold on
for i = 1:nDirs
    plot(pelog{i},sdotlog{i},...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerSize',markersize,...
        'MarkerFaceColor','auto',...
        'LineStyle','none')
end
hold off
xlabeltext = ['Potential Energy (' energyunits ')'];
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',fontsize,'interpreter','latex')   
titletext_l1 = 'Log of Strain Rate vs. Potential Energy';
titletext_l2 = [title_name, shorttitletext];
title({titletext_l1,titletext_l2});       
figlegnd = legend(systemnames,'Location','eastoutside');
lgndtitle = get(figlegnd,'Title');
set(lgndtitle,'String',legendtitletext);
titletext_l1 = 'Velocity Profile Evolution';
legend boxoff
set(gca,'FontSize',fontsize)

% Maximize Plot Window
set(gcf,'WindowStyle','docked');