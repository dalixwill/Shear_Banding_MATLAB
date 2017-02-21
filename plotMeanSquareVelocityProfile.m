% Figure -  Mean Squared Velocity Profile
switch lower(plot_vrms)
    case {'true','show'}
        % Calculate Per-Atom, Per-Bin Mean Square Velocity
        vel_sqr = Vel.*Vel;        
        vel_sqr_norm = sum(vel_sqr,2);        
        normVelbin{i} = averageBins(Bins,vel_sqr_norm,cType);
        
        nconfigs = size(normVelbin{i},3);
        figure
        hold on
        legendtext = cell(size(outconfigs));

        for conf = 1:numel(outconfigs)
            ydata = normVelbin{i}(:,:,outconfigs(conf));

            if conf == 1
                legendtext{1} = '    0%';
                plot(ydata,'k--',...
                    'LineWidth',linewidth)   
            else
                legendtext{conf} = ['    ' num2str(outconfigs(conf)-2) '00 - '...
                num2str(outconfigs(conf)-1) '00%'];
                plot(ydata,'LineWidth',linewidth)
            end

        end
        hold off        
        xlabel({'','Bin'})
        ylabel({'v_{norm}^2',''})
        figlegnd = legend(legendtext,...
            'Orientation','vertical',...
            'Location','eastoutside');
        lgndtitle = get(figlegnd,'Title');
        legend boxoff
        legendtitletext = ['Run ',runnum];
        set(lgndtitle,'String',legendtitletext);
        titletext_l1 = 'Velocity Profile Evolution';
        titletext_l2 = [title_name, longtitletext];
        title({titletext_l1,titletext_l2});
        set(gca,'FontSize',fontsize)

        % Maximize Plot Window
        set(gcf,'WindowStyle','docked');
        
        clearvars Vel vel_sqr vel_sqr_norm
end