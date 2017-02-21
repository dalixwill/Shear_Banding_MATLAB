% ---
%
%  Plot - Band Width vs. Shear Strain
%
%    This plot aggregates data into a master curve.
%    Should only be used when data represents both constant strain 
%    and quench rate --> i.e. multiple instantiations of same data. 
%
% ---

figure
hold on 
cmapi = 1;

% Aggregate strain, bandwidth data across all directories (runs) 
% for all values of strain 
allstraindata = [];
allbandwidthdata = [];

% Store strain, bandwidth data for each system as row of matrix
for i = 1:nDirs
    allstraindata = [sqrt(at_strain(2:end)); allstraindata];
    allbandwidthdata = [bandsize{i}'; allbandwidthdata];
end

% Calculate column averages of bandwidth, strain
bwavg = mean(allbandwidthdata);
savg = mean(allstraindata);

% Calculate bandwidth standard error
bwerr = std(allbandwidthdata)/sqrt(nDirs);

% Plot band width vs. strain
plot(savg,bwavg,...
        'color',cmap(cmapi,:),...
        'Marker',markermap(cmapi),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)

% Set x,y axis text, attributes
xlabeltext = 'Shear Strain^{0.5}';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ['Band Width (' distanceunits ')'];
ylabel({ylabeltext,''},'FontSize',fontsize)

% Set x,y axis limits
yl = ylim;
xl = xlim;
xlim([0 xl(2)])
ylim([0 yl(2)])

% Set title text, attributes
titletext_l1 = 'Band Width Evolution';
titletext_l2 = [title_name, longtitletext];
title({titletext_l1,titletext_l2});

% Set legend text, attributes
legendtitletext = ['Quench ',quench_type,' (',quenchrateunits,' )'];
figlegnd = legend(quenchduration,'Location','eastoutside');
legendtitle = get(figlegnd,'Title');
set(legendtitle,'String',legendtitletext);
legend boxoff
set(gca,'FontSize',fontsize)

% Plot veritical error bars
errorbar(savg,bwavg,bwerr,...
    'LineStyle','none',...
    'Color',cmap(cmapi,:));

hold off

% Dock plot window
set(gcf,'WindowStyle','docked');