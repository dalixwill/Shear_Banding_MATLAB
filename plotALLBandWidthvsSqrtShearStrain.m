% Plot Band Width vs Square Root of Shear Strain
% ALL@!

figure
hold on 
cmapi = 1;

allstraindata  = zeros(nDirs,10);
allbandwidthdata = zeros(nDirs,10);

for i = 1:nDirs
    allstraindata(i,:) = sqrt(1:10);
    allbandwidthdata(i,:) = bandsize{i};
end

bwavg = mean(allbandwidthdata);
savg = mean(allstraindata);
bwerr = std(allbandwidthdata)/sqrt(3);
% [allstraindata, ix] = sort(allstraindata);
% allbandwidthdata = allbandwidthdata(ix);
% 
% [allbandwidthdata,allstraindata,bwdev,sdev] = ...
%     computeAverageValues(allbandwidthdata,allstraindata,3);

plot(savg,bwavg,...
        'color',cmap(cmapi,:),...
        'Marker',markermap(cmapi),...
        'MarkerFaceColor','auto',...
        'MarkerSize',markersize,...
        'LineWidth',linewidth)

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


errorbar(savg,bwavg,bwerr,...
    'LineStyle','none',...
    'Color',cmap(cmapi,:));
% 
% h(1).Color = cmap(cmapi,:);
% h(2).Color = cmap(cmapi,:);

hold off
% Plot Figure Window
set(gcf,'WindowStyle','docked');