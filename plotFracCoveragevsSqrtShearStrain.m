%%  Plot Fractional Coverage vs. Shear Strain^(0.5)

figure
hold on   

% Plot all available snapshots
for i = 1:nDirs
    plot(sqrt(nsteps(2:end)*tstep*str2num(strainrate)),bandsize{i}/Ly,...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)
end  
hold off 

xlabeltext = 'Shear Strain^{0.5}';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = 'Fractional Coverage [--]';
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
legend boxoff
legendtitletext = ['Run ',runnum];
set(lgndtitle,'String',legendtitletext);
set(gca,'FontSize',fontsize)

% Maximize Plot Window
set(gcf,'WindowStyle','docked');