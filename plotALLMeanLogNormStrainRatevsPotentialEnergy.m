% Plot Average logNORM(strain rate) vs. Potential Energy

figure                                                          
hold on
peall = reshape(pe_mean{)
for i = 1:nDirs
    plot(pe_mean{i},sr_mean{i},...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineStyle','none',...
        'LineWidth',linewidth);
end

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
legendtitletext = ['Run ',runnum];
set(lgndtitle,'String',legendtitletext);
legend boxoff
for i = 1:nDirs
    errorbar(pe_mean{i},sr_mean{i},sr_dev{i},...
        'LineStyle','none',...
        'Color',cmap(i,:))
    h = herrorbar(pe_mean{i},sr_mean{i},pe_dev{i},pe_dev{i},'.');
    h(1).Color = cmap(i,:);
    h(2).Color = cmap(i,:);
end
set(gca,'FontSize',fontsize)

% Maximize Plot Window
set(gcf,'WindowStyle','docked');
