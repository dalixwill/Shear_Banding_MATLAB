%% Plot Stress - Strain Data.

close all
clear all
path(path,'/Applications/herrorbar');

fontsize = 18;

system = input('What system would  you like to see?\n','s');

switch lower(system)
    case {'cz','copperzirconium','cu64zr36'}
        fpath2 = 'CZ_qALL_sr00010_run';
        systemnames = {'CZ-1','CZ-2','CZ-3'};
    case {'2dlj','lancon','2d-lj','lan'}
        fpath2 = 'Lan_qALL_sr00010_run';
        systemnames = {'2DLJ-1','2DLJ-2','2DLJ-3'};
    case {'3dlj','ka','kob-andersen','3d-lj'}
        fpath2 = 'KA_qrALL_sr00010_run';
        systemnames = {'3DLJ-1','3DLJ-2','3DLJ-3'};
    case {'si','a-si','tanguy','silicon'}
end

cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['^','x','o'];
linewidths = [1,5,1];

fpath1 = '~/Documents/MATLAB/Shear_Banding/';
fpath3 = '/fig/figure4.fig';

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'srmean',[],'pemean',[],...
    'sr_dev',[],'pe_dev',[]);

for runnum = 0:2    
    fullpath = strcat(fpath1,fpath2,num2str(runnum),fpath3);
    open(fullpath)
    fighand = get(gca,'Children');
    for rate = 1:3
        plotdata(rate).xdata = [get(fighand(rate),'XData') plotdata(rate).xdata];
        plotdata(rate).ydata = [get(fighand(rate),'YData') plotdata(rate).ydata];

    end
end

figure
hold on

for rate = 3:-1:1
   [srmean,pemean,sr_dev,pe_dev] = ...
       computeAverageValues(plotdata(rate).ydata,plotdata(rate).xdata,50);
   plotdata(rate).srmean = srmean;
   plotdata(rate).pemean = pemean;
   plotdata(rate).sr_dev = sr_dev;
   plotdata(rate).pe_dev = pe_dev;
   plot(pemean,srmean,'color',cmap(rate,:),...
       'Marker',markermap(rate),...
       'MarkerFaceColor',cmap(rate,:),...
       'MarkerSize',10,...
       'LineWidth',linewidths(rate),...
       'LineStyle','none')
end



xlabeltext = 'Potential Energy (\epsilon)';
xlabel({'',xlabeltext},'FontSize',fontsize)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',fontsize,'interpreter','latex')
legend(systemnames,'Location','eastoutside')
set(gca,'FontSize',fontsize)

for rate = 3:-1:1
   errorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
       plotdata(rate).sr_dev ,...
       'LineStyle','none',...
       'Color',cmap(rate,:))
   h = herrorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
       plotdata(rate).pe_dev,plotdata(rate).pe_dev,'.');
   h(1).Color = cmap(rate,:);
   h(2).Color = cmap(rate,:);
end
