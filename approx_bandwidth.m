function [band_extents,band_width] = approx_bandwidth(dudt,Ly,varargin)
% This function uses time-rate-of-change of displacement (dudt) and
%   the length of the simulation cell to estimate the extents of the
%   shear band (bandextents) and the total width (band_width). Function
%   assumes simulation is periodic in all x and y.

    shift_data = 'yes';                                                     % Switch that controls use of shifted array
    flip_data = 'yes';                                                      % Switch that controls use of inverted approximation (y,x)
    show_all_plots = 'off';                                                 % Switch that controls display of all figures
    verbose_fit = 'off';
    opvarcount = 1;
    while opvarcount < numel(varargin)
        switch varargin{opvarcount}
            case {'showDatafitting','showDataFitting'}
                assert(opvarcount+1<=numel(varargin))
                opvarcount = opvarcount + 1;
                switch lower(varargin{opvarcount})
                    case {'yes','on','true'}
                        show_all_plots = 'on';
                    otherwise
                        show_all_plots = 'off';
                end
                            
%                 show_all_plots = varargin{opvarcount};
            case {'flipData','flipdata','FlipData'}
                assert(opvarcount+1<=numel(varargin))
                opvarcount = opvarcount + 1;
                flip_data = varargin{opvarcount};
            case {'verboseFit','VerboseFit','verbosefit'}
                assert(opvarcount+1<=numel(varargin))
                opvarcount = opvarcount + 1;
                verbose_fit = varargin{opvarcount};
        end
        opvarcount = opvarcount + 1;
    end
    
%     [~,nbins,nconfigs] = size(dudt);                                        % Determine the number of bins and configurations
    
    nbins = size(dudt,2);
    nconfigs = size(dudt,3);

    if nconfigs == 1
        band_extents = zeros(2,1);
        band_width = zeros(1);
        fit_stats = zeros(nbins,6,nconfigs);
        best_stats = zeros(nconfigs,5);
    else
        band_extents = zeros(2,nconfigs-1);                                      % Preallocate extents/band width arrays, 1 index smaller                                      
        band_width = zeros(nconfigs-1,1);                                       % than input, assuming no shear band for dudt(1).
        fit_stats = zeros(nbins,6,nconfigs-1);
        best_stats = zeros(nconfigs-1,5);
    end
    nknots = 3;
    mean_diff_tol = 0.1;
    
    
    
    for i = 2:nconfigs
        
        fit_stats = zeros(nbins,4);
        shift = 1;
        
        while shift <= nbins
            
           u = dudt(:,:,i);
           x = 1:length(u);
           dx = max(x)-min(x);
           du = max(u)-min(u);
           x = [x(shift:end) x(2:shift)+dx];
           u = [u(shift:end) u(2:shift)+du];
           
           slm = slmengine(x,u,'knots',nknots,...
               'interiorknots','free','degree','linear');
           
           u_error = abs((slmeval(x,slm)-u)./u);
           u_error_avg = mean(u_error);
           u_error_std = std(u_error);
           n_replicas = nknots-length(unique(round(slm.knots)));
           fit_stats(shift,:) = ...
               [shift,u_error_std,u_error_avg,n_replicas];
           shift = shift + 1;
        end
        
        bad_ind = find(fit_stats(:,4)~=0);
        best_fit = fit_stats;
        best_fit(bad_ind,:) = [];
        [~,min_row] = min(best_fit(:,3));
        opt_shift = uint16(best_fit(min_row,1));
        
%         disp(best_fit(min_row,:));
        best_stats(i-1,:) = [i, best_fit(min_row,:)];                              % save best fit data to matrix.
        
        u = dudt(:,:,i);
        x = 1:length(u);
        x = [x(opt_shift:end) x(2:opt_shift)+dx];
        u = [u(opt_shift:end) u(2:opt_shift)+du];
        
        slm = slmengine(x,u,'knots',nknots,...
            'interiorknots','free','degree','linear','plot',show_all_plots);
        
        knot_A = round(slm.knots(1));
        knot_B = round(slm.knots(2));
        knot_C = round(slm.knots(3));
        
        f_A = slmeval(knot_A,slm);
        f_B = slmeval(knot_B,slm);
        f_C = slmeval(knot_C,slm);
        
        slope_AB = (f_B-f_A)/(knot_B-knot_A);
        slope_BC = (f_C-f_B)/(knot_C-knot_B);
        slopes = [slope_AB,slope_BC];
        [~,i_max] = max(slopes);
        
        switch i_max
            case 1
                band_extents(:,i-1) = [knot_A;knot_B];
                band_width(i-1) = Ly*(knot_B-knot_A)./length(u);
            case 2
                band_extents(:,i-1) = [knot_B;knot_C]; 
                band_width(i-1) = Ly*(knot_C-knot_B)./length(u);
        end
        
       band_extents(band_extents>length(u)) = ...
        band_extents(band_extents>length(u))-length(u);                     % guarantee extents are within original frame
        
    % Case band extents full simulation
%     disp(slope_AB)
%     disp(slope_BC)
%     disp(slope_BC-slope_AB)
        if abs(slope_AB-slope_BC) <= 5e-3
            band_extents(:,i-1) = [1;numel(u)];
            band_width(i-1) = Ly;
        end
    end  
    
    switch verbose_fit
        case {'true','yes','on'}
            disp 'config shift stddev meandev replicas'
            disp(best_stats)
    end
end

