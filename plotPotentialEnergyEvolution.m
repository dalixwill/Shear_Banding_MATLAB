% Figure - Mean Potential Energy vs. Percent Strain

figure
hold on
for i = 1:nDirs
    meanPE = mean(PEbin{i});
    meanPE = reshape(meanPE,1,numel(meanPE));
    meanPE(1) = [];
    plot((1:numel(meanPE))*100,meanPE,...
        (1:numel(PEband{i}))*100,PEband{i},...
        (1:numel(PEjam{i}))*100,PEjam{i},...
        'LineWidth',linewidth)
end
hold off
plotdata = get(gca,'Children');
set(plotdata,'visible','on')
xlabeltext = 'Percent Strain';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = 'Global Potential Energy';
ylabel({ylabeltext,''},'FontSize',fontsize)
titletext_l1 = 'Potential Energy vs. Strain';
titletext_l2 = [title_name, ', Strain Rate = 0.000# t_0^{-1}'];
title({titletext_l1,titletext_l2});
figlegnd = legend({'Total','Inside Band','Outside Band'},'Location','eastoutside');
lgndtitle = get(figlegnd,'Title');
set(lgndtitle,'String','Run #')
legend boxoff
set(gca,'FontSize',fontsize)

% Maximize Plot Window
set(gcf,'WindowStyle','docked');
    