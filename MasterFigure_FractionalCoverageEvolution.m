%% Plot Fractional Coverage of Band as a Function of Strain
close all
clear all
path(path,'/Applications/herrorbar');                                   % Include horizontal error bar module

system = input('What system would  you like to see?\n','s');

switch lower(system)
    case {'cz','copperzirconium','cu64zr36'}
        fpath2 = 'CZ_qALL_sr00010_run';
        systemnames = {'CZ-1','CZ-2','CZ-3'};
        x0 = 0.1^0.5; 
    case {'2dlj','lancon','2d-lj','lan'}
        fpath2 = 'Lan_qALL_sr00010_run';
        systemnames = {'2DLJ-1','2DLJ-2','2DLJ-3'};
        x0 = 0.2^0.5;
    case {'3dlj','ka','kob-andersen','3d-lj'}
        fpath2 = 'KA_qrALL_sr00010_run';
        systemnames = {'3DLJ-1','3DLJ-2','3DLJ-3'};
        x0 = 0.1^0.5;
    case {'si','a-si','tanguy','silicon'}
        fpath2 = 'Si_qrALL_sr00010_run';
        systemnames = {'Si-1','Si-2','Si-3'};
        x0 = 0.02^0.5;
end

cmap = [  0,148,189;164,131,196;222,29,42; ]*(1/255);
markermap = ['^','x','o'];
markersize = 5;
linewidths = [1,5,1];
fontsize = 12;

fpath1 = '~/Documents/MATLAB/Shear_Banding/';
fpath3 = '/fig/figure9.fig';

plotdata(3) = struct('name','','filepath','',...
    'xdata',[],'ydata',[],...
    'xmean',[],'ymean',[],...
    'sr_dev',[],'ydev',[]);


for runnum = 0:1    
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
       'MarkerSize',markersize,...
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
set(gca,'FontSize',fontsize)

for rate = 3:-1:1
   errorbar(plotdata(rate).xmean,plotdata(rate).ymean,plotdata(rate).ydev,...
       'LineStyle','none',...
       'Color',cmap(rate,:))
%    h = herrorbar(plotdata(rate).pemean,plotdata(rate).srmean,...
%        plotdata(rate).pe_dev,plotdata(rate).pe_dev,'.');
%    h(1).Color = cmap(rate,:);
%    h(2).Color = cmap(rate,:);
end

% Plot of all data on single axes

figure
hold on
for runnum = 1:2    
    for rate = 3:-1:1
        xpos = plotdata(rate).xdata(runnum,:);
        ypos = plotdata(rate).ydata(runnum,:);
        plot(xpos,ypos,...
                   'color',cmap(rate,:),...
       'Marker',markermap(rate),...
       'MarkerFaceColor',cmap(rate,:),...
       'MarkerSize',markersize,...
       'LineWidth',linewidths(rate),...
       'LineStyle','none');

    end
end

xlabel({'','Shear Strain^{0.5}'})
% ylabeltext = ...
%     '\boldmath$\ln(\dot{\epsilon_{pl}} / \dot{\epsilon_{b}}) \newline$';
% ylabel({ylabeltext,''},'FontSize',18,'interpreter','latex')
ylabel({'Fractional Coverage [--]',''})
legend(systemnames,'Location','eastoutside')
set(gca,'FontSize',fontsize)

for rate = 3:-1:1
    n = numel(plotdata(rate).xdata);
    x = reshape(plotdata(rate).xdata,n,1);
    y = reshape(plotdata(rate).ydata,n,1);
   linfit = fit(x,y,'poly1');
   c = coeffvalues(linfit);
   plot([x0,x(end)],[x0*c(1)+c(2),x(end)*c(1)+c(2)],...
       'Color',cmap(rate,:),...
       'LineStyle','--',...
       'LineWidth',2)
%    disp(linfit)
%    plot(linfit)
   
end
    %% References
    % 1. 'get fit coefficients from fitting result'
    %  https://www.mathworks.com/matlabcentral/newsreader/view_thread/53940
    