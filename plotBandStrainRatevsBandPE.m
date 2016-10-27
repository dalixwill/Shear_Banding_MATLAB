%% Strain Rate in Band vs. PE in Band

figure
hold on
for i = 1:nDirs
    plot(SRband{i},PEband{i},...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)
end
hold off
set(gca,'FontSize',fontsize)
plotdata = get(gca,'Children');
set(plotdata,'visible','on')
xlabeltext = '\boldmath$\newline\dot{\gamma_{B}}\newline$';
xlabel({'',xlabeltext},'FontSize',fontsize,'interpreter','latex')
ylabeltext = 'PE_B';
ylabel({ylabeltext,''},'FontSize',fontsize)
titletext_l1 = 'Potential Energy vs. Strain Rate Inside Shear Band';
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