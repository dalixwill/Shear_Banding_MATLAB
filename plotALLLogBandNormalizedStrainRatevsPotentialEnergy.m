% Plot - Log of Band-Normalized Strain Rate vs. Potential Energy
% ALL!

figure
hold on
cmapi = 1;

% allpelog = reshape(pelog{:},1,numel(pelog{:}));
% allsdotlog = reshape(sdotlog{:},1,numel(sdotlog{:}));
allpedata = [];
allsdotdata = [];
for i = 1:nDirs
    allpedata = [pelog{i} allpedata];
    allsdotdata = [sdotlog{i} allsdotdata];
end

% Sort data in order of increasing strain rate
[allsdotdata ix] = sort(allsdotdata);
allpedata = allpedata(ix);

[allsdotdata,allpedata,allsrdev,allpedev] = ...
    computeAverageValues(allsdotdata,allpedata,n_average_points);
% 
% for i = 1:nDirs
    plot(allpedata,allsdotdata,...
        'color',cmap(cmapi,:),...
        'Marker',markermap(i),...
        'MarkerSize',markersize,...
        'MarkerFaceColor','auto',...
        'LineStyle','none')
% end
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

errorbar(allpedata,allsdotdata,allsrdev,...
    'LineStyle','none',...
    'Color',cmap(cmapi,:))
h = herrorbar(allpedata,allsdotdata,allpedev,allpedev,'.');
h(1).Color = cmap(cmapi,:);
h(2).Color = cmap(cmapi,:);
% errorbar(allpedata,allsdotdata,allpedev,'horizontal')
% h = herrorbar(allpedata,allsdotdata,allpedev,allpedev,'.');
% h(1).Color = cmap(i,:);
% h(2).Color = cmap(i,:);
hold off

% Maximize Plot Window
set(gcf,'WindowStyle','docked');