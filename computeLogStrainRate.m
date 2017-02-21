function [PotEng,Shear] = computeLogStrainRate(SR,PE,BndExt,mintol)
% Function plots the natural log of the band-normalized strain rate
%  versus potential energy, excluding the shear band.
    
    [~,nbins,nconfigs] = size(SR);
    Shear = zeros(1,nbins*nconfigs)+Inf;                                    % Preallocate shear as Inf array
    PotEng = zeros(1,nbins*nconfigs)+Inf;                                   % Preallocate potential energy as Inf array
    Shear = [];
    PotEng = [];
    set_minimum_strain_rate = 'no';                                         % strain rate threshold switch
    
        for j = 2:nconfigs

            A = BndExt(1,j-1);                                              % index for head of shear band
            B = BndExt(2,j-1);                                              % index for tail of shear band
            
            % Case 1: Band does not cross periodic boundary. Consider all
            % points, less the band itself (A to B).
            if A < B
                % potential energy data outside shear band
                xdata = [PE(:,1:A,j) PE(:,B:end,j)];
                % strain rate data outside shear band
                S0 = abs([SR(:,1:A,j) SR(:,B:end,j)]);
                % average strain rate inside shear band
                Sb = mean(SR(:,A:B,j));
                % log of band-normalized strain rate
                ydata = reallog(S0/Sb);                                     
%                 ydata = real(log10(S0/Sb));
%                 Shear = [ydata Shear];
%                 PotEng = [xdata PotEng];
% 
%                 i_firstzero = find(Shear==Inf,1);                           % index of first value to be appended
%                 i_finalzero = i_firstzero + length(S0) - 1;                 % index of final value to be appended
%                 Shear(i_firstzero:i_finalzero) = ydata;                     % append new, normalized strain rate data to array
%                 PotEng(i_firstzero:i_finalzero) = xdata;                    % append new, normalized potential energy data to array

            % Case 2: Band crosses periodic boundary. Consider points from
            % end of band (B) to the beginning of the band (A).
            else
                xdata = PE(:,B:A,j);
                S0 = abs(SR(:,B:A,j));
                Sb = mean([SR(:,1:B,j) SR(:,A:end,j)]);           
                ydata = reallog(S0/Sb);
%                 ydata = real(log10(S0/Sb));
                
%                 i_firstzero = find(Shear==Inf,1);                           % index of first value to be appended
%                 i_finalzero = i_firstzero + length(S0) - 1;                 % index of final value to be appended
%                 Shear(i_firstzero:i_finalzero) = ydata;                     % append new, normalized strain rate data to array
%                 PotEng(i_firstzero:i_finalzero) = xdata;                    % append new, normalized potential energy data to array
            end
            Shear = [ydata Shear];
            PotEng = [xdata PotEng];
        end
    
        
    [Shear, Ix] = sort(Shear);                                              % sort shear data in ascending order                      
    PotEng = PotEng(Ix);                                                    % sort potential energy data in same order
    
    % Remove all log(strainrate) values >= 0, along with the associated
    % potential energy values
    PotEng(Shear>=0) = [];
    Shear(Shear>=0) = [];
    
%     Shear(Shear==Inf) = [];                                                 % purge unused memory in shear array
%     PotEng(PotEng==Inf) = [];                                               % purge unused memory in potential energy array
    
    switch set_minimum_strain_rate
        case {'yes','YES','Yes'}                                            % if switch on, removes data below shear    
            if nargin < 4                                                   % rate threshhold for potential energy and
                mintol = -Inf;                                              % strain rate data arrays. Has redundancy for case
            end                                                             % where tolerance not specified.
            PotEng(Shear<=mintol) = [];                                     
            Shear(Shear<=mintol) = [];                                      
    end
end