function [d2udydt,ubins,dudtBin] = computeShearStrainRate(Pos,dy,dt,bins,type)

    % Number of output args must be >= minargs and <= maxargs.
    minargs = 2;
    maxargs = 5;
    nargoutchk(minargs,maxargs)
    
    [~,nbins,nconfigs] = size(bins);
    xpos = Pos(:,1,:);                                                      % store x-position data for entire suite of configurations
    xpos_t0_rep = repmat(xpos(:,:,1),1,1,nconfigs);                         % replicate x-position at t=0 to (natoms x 1 x nconfigs) matrix
    u = xpos - xpos_t0_rep;                                                 % calculate displacement relative to initial configuration, t=0
    ubins = averageBins(bins,u,type);
    
    show_dudtbin_plots = 'no';                                              % toggle dudtbin plots on/off
    show_u_plots = 'no';                                                    % toggle displacement plots on/off
    show_d2udydt_plots = 'no';                                              % toggle d2udydt plots on/off

    dudt = diff(u,1,3);                                                     % calculate displacement relative to subsequent configuration
    dudtBin = averageBins(bins,dudt,type);                                  % calculate bin-averaged du/dt for chosen atom type
    dt_rep = repmat(reshape(dt,1,1,nconfigs-1),1,nbins,1);                  % reshape and replicate dt array to size (1 x nbins x nconfigs-1)                    
%     dudtBin = abs(dudtBin)./dt_rep;                                         % calculate time-rate-of-change of displacement
    dudtBin = dudtBin./dt_rep;
    deldudtBin = max(dudtBin) - min(dudtBin);                               % calculate maximum relative displacement of each configuration
    d2udydt = diff([dudtBin dudtBin(:,2,:)+deldudtBin],1,2);                % calculate change in displacement in y-direction per config.
    d2udydt = abs(d2udydt)/dy/2;                                              % normalize by height of bin, ensure positive definite
    
%     % Compare approximate strain rate to imposed strain rate
%     sr_approx = trapz(d2udydt)/nbins;
%     
    % Number of variable arguments
    nvarargout = nargout - 2;
    varargout = cell(nvarargout,1);
    
    % Store optional output variables in temporary cell
    tempout = cell(1,3);
    tempout{1} = ubins;
    tempout{2} = dudtBin;
    tempout{3} = d2udydt;
    
    % Return desired number of output variables
    varargcount = 1;   
    while varargcount <= nvarargout
       varargout{varargcount} = tempout{varargcount};
       varargcount = varargcount + 1;
    end

    switch show_u_plots
        case 'yes'                                                          % Switch controls the output of displacement plots.
            figure(122)                                                     % Will overlay curves for every configuration, for
            hold on                                                         % all structures in single figure window.
            for i = 1:nconfigs
                plot(ubins(:,:,i))
            end
            hold off
            xlabel({'','Bin'})
            ylabel({'Displacement, u',''})
    end

    switch show_dudtbin_plots       
        case 'yes'                                                          % Switch controls output of time-rate-of-change of
            figure(123)                                                     % displacement plots. Will overlay curves for every    
            hold on                                                         % configuration, for all structures on same axes.
            for i = 1:nconfigs-1
                plot(dudtBin(:,:,i))
            end
            xlabel({'','Bin (--)'})
            ylabel({'dudt',''})
            hold off
    end
    
    switch show_d2udydt_plots
        case 'yes'                                                          % Switch controls output of strain rate curves.
            figure(124)                                                     % Will overlay curves for every configuration,
            hold on                                                         % for all structures on same axes.
            for i = 1:nconfigs-1
                plot(d2udydt(:,:,i))
            end
            xlabel({'','Bin (--)'})
            ylabel({'d2udydt',''})
            hold off
    end
    
end

