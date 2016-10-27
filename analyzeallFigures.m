%% Lancon 2D-LJ -
% Plot all strain-rate_vs_potential-energy plots on single figure
% Take averages at every 50 data points, sorted by strain rate


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','x','^'];
markermap = ['^','x','o'];
systemnames = {'2DLJ-1','2DLJ-2','2DLJ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'srmean',[],'pemean',[],...
    'sr_dev',[],'pe_dev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'Lan_qALL_sr00010_run';
    fpath3 = '/fig/figure4.fig';
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
       'Marker',markermap(rate),'LineStyle','none')
end



xlabeltext = 'Potential Energy (\epsilon)';
xlabel({'',xlabeltext},'FontSize',18)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

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

%% Kob-Andersen 3D-LJ -
% Plot all strain-rate_vs_potential-energy plots on single figure
% Take averages at every 50 data points, sorted by strain rate


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','+','^'];
markermap = ['^','+','o'];
systemnames = {'3DLJ-1','3DLJ-2','3DLJ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'srmean',[],'pemean',[],...
    'sr_dev',[],'pe_dev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'KA_qrALL_sr00010_run';
    fpath3 = '/fig/figure4.fig';
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
       'Marker',markermap(rate),'LineStyle','none')
end



xlabeltext = 'Potential Energy (\epsilon)';
xlabel({'',xlabeltext},'FontSize',18)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

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

%% Cu64Zr36 -
% Plot all strain-rate_vs_potential-energy plots on single figure
% Take averages at every 50 data points, sorted by strain rate


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','+','^'];
markermap = ['^','+','o'];
systemnames = {'CZ-1','CZ-2','CZ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'srmean',[],'pemean',[],...
    'sr_dev',[],'pe_dev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'CZ_qALL_sr00010_run';
    fpath3 = '/fig/figure4.fig';
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
       'Marker',markermap(rate),'LineStyle','none')
end



xlabeltext = 'Potential Energy (\epsilon)';
xlabel({'',xlabeltext},'FontSize',18)
ylabeltext = ...
    '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

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

%% Kob-Andersen 3D-LJ - Band Evolution Plots
% Plot all Fractional Coverage vs Shear Strain plots on single figure
% Include error bars


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','s','^'];
markermap = ['^','s','o'];
systemnames = {'3DLJ-1','3DLJ-2','3DLJ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'xmean',[],'ymean',[],...
    'sr_dev',[],'ydev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'KA_qrALL_sr00010_run';
    fpath3 = '/fig/figure9.fig';
    fullpath = strcat(fpath1,fpath2,num2str(runnum),fpath3);
    open(fullpath)
    fighand = get(gca,'Children');
    for rate = 1:3
        plotdata(rate).xdata(runnum+1,:) = get(fighand(rate),'XData');
        plotdata(rate).ydata(runnum+1,:) = get(fighand(rate),'YData');

    end
end

figure
hold on

for rate = 3:-1:1
%    [srmean,pemean,sr_dev,pe_dev] = ...
%        computeAverageValues(plotdata(rate).ydata,plotdata(rate).xdata,50);
   plotdata(rate).xmean = mean(plotdata(rate).xdata);
   plotdata(rate).ymean = mean(plotdata(rate).ydata);
   plotdata(rate).ydev = std(plotdata(rate).ydata);
   std(plotdata(rate).ydata)
%    plotdata(rate).sr_dev = sr_dev;
%    plotdata(rate).pe_dev = pe_dev;
   plot(plotdata(rate).xmean,plotdata(rate).ymean,...
       'color',cmap(rate,:),...
       'Marker',markermap(rate),...
       'MarkerFaceColor',cmap(rate,:),...
       'MarkerSize',10,...
       'LineWidth',1,...
       'LineStyle',':')
end



% xlabeltext = 'Potential Energy (\epsilon)';
% xlabel({'',xlabeltext},'FontSize',18)
xlabel({'','Shear Strain^{0.5}'})
% ylabeltext = ...
%     '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
% ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
ylabel({'Fractional Coverage [--]',''})
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

for rate = 3:-1:1
   errorbar(plotdata(rate).xmean,plotdata(rate).ymean,plotdata(rate).ydev,...
       'LineStyle','none',...
       'Color',cmap(rate,:))
%    h = herrorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
%        plotdata(rate).pe_dev,plotdata(rate).pe_dev,'.');
%    h(1).Color = cmap(rate,:);
%    h(2).Color = cmap(rate,:);
end

%% Lancon 2D-LJ - Band Evolution Plots
% Plot all Fractional Coverage vs Shear Strain plots on single figure
% Include error bars


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','s','^'];
markermap = ['^','s','o'];
systemnames = {'2DLJ-1','2DLJ-2','2DLJ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'xmean',[],'ymean',[],...
    'sr_dev',[],'ydev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'Lan_qALL_sr00010_run';
    fpath3 = '/fig/figure9.fig';
    fullpath = strcat(fpath1,fpath2,num2str(runnum),fpath3);
    open(fullpath)
    fighand = get(gca,'Children');
    for rate = 1:3
        plotdata(rate).xdata(runnum+1,:) = get(fighand(rate),'XData');
        plotdata(rate).ydata(runnum+1,:) = get(fighand(rate),'YData');

    end
end

figure
hold on

for rate = 3:-1:1
%    [srmean,pemean,sr_dev,pe_dev] = ...
%        computeAverageValues(plotdata(rate).ydata,plotdata(rate).xdata,50);
   plotdata(rate).xmean = mean(plotdata(rate).xdata);
   plotdata(rate).ymean = mean(plotdata(rate).ydata);
   plotdata(rate).ydev = std(plotdata(rate).ydata);
   std(plotdata(rate).ydata)
%    plotdata(rate).sr_dev = sr_dev;
%    plotdata(rate).pe_dev = pe_dev;
   plot(plotdata(rate).xmean,plotdata(rate).ymean,...
       'color',cmap(rate,:),...
       'Marker',markermap(rate),...
       'MarkerFaceColor',cmap(rate,:),...
       'MarkerSize',10,...
       'LineWidth',1,...
       'LineStyle',':')
end



% xlabeltext = 'Potential Energy (\epsilon)';
% xlabel({'',xlabeltext},'FontSize',18)
xlabel({'','Shear Strain^{0.5}'})
% ylabeltext = ...
%     '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
% ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
ylabel({'Fractional Coverage [--]',''})
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

for rate = 3:-1:1
   errorbar(plotdata(rate).xmean,plotdata(rate).ymean,plotdata(rate).ydev,...
       'LineStyle','none',...
       'Color',cmap(rate,:))
%    h = herrorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
%        plotdata(rate).pe_dev,plotdata(rate).pe_dev,'.');
%    h(1).Color = cmap(rate,:);
%    h(2).Color = cmap(rate,:);
end

%% Cu64Zr36 - Band Evolution Plots
% Plot all Fractional Coverage vs Shear Strain plots on single figure
% Include error bars


close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

cmap = [222,29,42; 164,131,196; 0,148,189 ]*(1/255);
cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['o','s','^'];
markermap = ['^','s','o'];
systemnames = {'CZ-1','CZ-2','CZ-3'};

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'xmean',[],'ymean',[],...
    'sr_dev',[],'ydev',[]);

for runnum = 0:2    
    fpath1 = '~/Documents/MATLAB/Shear_Banding/';
    fpath2 = 'CZ_qALL_sr00010_run';
    fpath3 = '/fig/figure9.fig';
    fullpath = strcat(fpath1,fpath2,num2str(runnum),fpath3);
    open(fullpath)
    fighand = get(gca,'Children');
    for rate = 1:3
        plotdata(rate).xdata(runnum+1,:) = get(fighand(rate),'XData');
        plotdata(rate).ydata(runnum+1,:) = get(fighand(rate),'YData');

    end
end

figure
hold on

for rate = 3:-1:1
%    [srmean,pemean,sr_dev,pe_dev] = ...
%        computeAverageValues(plotdata(rate).ydata,plotdata(rate).xdata,50);
   plotdata(rate).xmean = mean(plotdata(rate).xdata);
   plotdata(rate).ymean = mean(plotdata(rate).ydata);
   plotdata(rate).ydev = std(plotdata(rate).ydata);
   std(plotdata(rate).ydata)
%    plotdata(rate).sr_dev = sr_dev;
%    plotdata(rate).pe_dev = pe_dev;
   plot(plotdata(rate).xmean,plotdata(rate).ymean,...
       'color',cmap(rate,:),...
       'Marker',markermap(rate),...
       'MarkerFaceColor',cmap(rate,:),...
       'MarkerSize',10,...
       'LineWidth',1,...
       'LineStyle',':')
end



% xlabeltext = 'Potential Energy (\epsilon)';
% xlabel({'',xlabeltext},'FontSize',18)
xlabel({'','Shear Strain^{0.5}'})
% ylabeltext = ...
%     '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
% ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
ylabel({'Fractional Coverage [--]',''})
legend(systemnames,'Location','best')
set(gca,'FontSize',14)

for rate = 3:-1:1
   errorbar(plotdata(rate).xmean,plotdata(rate).ymean,plotdata(rate).ydev,...
       'LineStyle','none',...
       'Color',cmap(rate,:))
%    h = herrorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
%        plotdata(rate).pe_dev,plotdata(rate).pe_dev,'.');
%    h(1).Color = cmap(rate,:);
%    h(2).Color = cmap(rate,:);
end


%% References
% 1. https://www.mathworks.com/matlabcentral/newsreader/view_thread/29952 