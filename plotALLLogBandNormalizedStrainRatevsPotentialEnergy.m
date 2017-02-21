% ---
%
%  Plot - Log of Band-Normalized Strain Rate vs. Potential Energy
%
%    This plot aggregates log(norm(SR)) vs. PE data into a master curve.
%    Should only be used when data represents both constant strain 
%    and quench rate --> i.e. multiple instantiations of same data. 
%
% ---

figure
hold on
cmapi = 1;

% Aggregate log(PE), log(SR) data across all directories (runs) 
% for values of strain >= 200%.
allpedata = [];
allsdotdata = [];
for i = 1:nDirs
    i200pct = find(at_strain==2);
    allpedata = [pelog{i}(i200pct:end) allpedata];
    allsdotdata = [sdotlog{i}(i200pct:end) allsdotdata];
end

% Sort strain rate, PE data in order of increasing strain rate
[allsdotdata,ix] = sort(allsdotdata);
allpedata = allpedata(ix);

% Average along fixed strain increments
 [allpedata,allsdotdata,allpedev,allsrdev] = ...
     binLogData(allpedata,allsdotdata,loginc);

% Plot resultant data points
plot(allpedata,allsdotdata,...
    'color',cmap(cmapi,:),...
    'Marker',markermap(i),...
    'MarkerSize',markersize,...
    'MarkerFaceColor','auto',...
    'LineStyle','none')

% Set x,y axis text, attributes
xlabeltext = ['Potential Energy (' energyunits ')'];
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',fontsize,'interpreter','latex')

% Set title text, attributes
titletext_l1 = 'Scaled Local Strain Rate vs. Potential Energy';
titletext_l2 = [title_name, longtitletext];
title({titletext_l1,titletext_l2});

% Set legend text, attributes
legendtitletext = ['Quench ',quench_type,' (',quenchrateunits,' )'];
figlegnd = legend(quenchduration,'Location','eastoutside');
legendtitle = get(figlegnd,'Title');
set(legendtitle,'string',legendtitletext)
legend boxoff
set(gca,'FontSize',fontsize)

% Plot vertical, horizontal error bars
errorbar(allpedata,allsdotdata,allsrdev,...
    'LineStyle','none',...
    'Color',cmap(cmapi,:))
h = herrorbar(allpedata,allsdotdata,allpedev,allpedev,'.');
h(1).Color = cmap(cmapi,:);
h(2).Color = cmap(cmapi,:);

hold off

% Dock, maximize Plot Window
set(gcf,'WindowStyle','docked');