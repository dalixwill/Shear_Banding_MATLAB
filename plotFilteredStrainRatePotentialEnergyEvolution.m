% Plot Filtered Strain Rate, Potential Energy Evolution Plots

switch show_filtered_data_figs
    case {'yes','YES','Yes','on','ON','On'}            
        %   Potential Energy & Strain Rate vs. y-Position, Filtered Data
        legendtext = cell(size(Points));
        for i = 1:nDirs
            figure
            f(1) = subplot(1,2,1);
            hold on
            degree = 3;
            for j = 1:length(Points)          
                tmpdata = [d2udydt{i}(:,end-degree+1:end,Points(j)) ...
                            d2udydt{i}(:,:,Points(j)) ...
                            d2udydt{i}(:,1:degree,Points(j))];
                xdata = smooth(tmpdata,'moving');
                xdata = xdata(degree+1:end-degree);
                plot(xdata,linspace(0,Ly,nBins),...
                    'LineWidth',2)
                legendtext{j} = [num2str(Points(j)-1) '00-'...
                    num2str(Points(j)) '00%'];
            end
            hold off
            set(gca,'FontSize',14)
            xlabeltext = ['Strain Rate (' strainrateunits ')'];
            xlabel({'',xlabeltext},'FontSize',18)
            axis tight
            ylabeltext = ['y-Position (' distanceunits ')'];
            ylabel({ylabeltext,''},'FontSize',18)
            legend(legendtext)

            f(2) = subplot(1,2,2);
            hold on
            for j = 1:length(Points)
                tmpdata = [PEbin{i}(:,end-degree+1:end,Points(j)) ...
                            PEbin{i}(:,:,Points(j)) ...
                            PEbin{i}(:,1:degree,Points(j)) ];
                xdata = smooth(tmpdata,'moving');
                xdata = xdata(degree+1:end-degree);
                plot(xdata,linspace(0,Ly,nBins),...
                    'LineWidth',2)
            end
            PEshift = min(PEbin{i}(:,:,2)) - max(PEbin{i}(:,:,1));
            set(f(2),'yticklabel',[]);
            plot(PEbin{i}(:,:,1)+PEshift,linspace(0,Ly,nBins),...
                'k--','LineWidth',2)
            hold off
            set(gca,'FontSize',14)

            xlabeltext = ['Potential Energy (' energyunits ')'];
            xlabel({'',xlabeltext},'FontSize',18)
            axis tight
        end    
        
        % Maximize Plot Window
        set(gcf,'WindowStyle','docked');
end