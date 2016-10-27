% Plot Log of Strain Rate vs. Potential Energy

figure
hold on
for i = 1:nDirs
    % Flatten Data
    xdata = reshape(PEbin{i}(:,:,2:end),[1,numel(PEbin{i}(:,:,2:end))]);
    ydata = reshape(log(d2udydt{i}),[1,numel(d2udydt{i})]);
    % Filter Data
    xdata = xdata(ydata>SRres);
    ydata = ydata(ydata>SRres);
    % Format and Plot
    plot(xdata,ydata,...
        'color',cmap(i,:),...
        'Marker',markermap(i),...
        'MarkerSize',markersize,...
        'MarkerFaceColor','auto',...
        'LineStyle','none');
end
hold off   
xlabeltext = ['Potential Energy (' energyunits ')'];
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = '\boldmath$\ln(\dot{\epsilon_{pl}}) \newline$';
ylabel({ylabeltext,''},'FontSize',fontsize,'interpreter','latex') 
titletext_l1 = 'Log of Strain Rate vs. Potential Energy';
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