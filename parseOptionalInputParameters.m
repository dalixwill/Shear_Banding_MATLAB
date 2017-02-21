% Parse optional input parameters
opvarcount = 1;
while opvarcount < numel(varargin)
    
   switch varargin{opvarcount}
       case {'markermap','mmap'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           markermap = varargin{opvarcount};
           
       case {'colormap','cmap'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           cmap = varargin{opvarcount};
           
       case {'system_names','systemnames'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           systemnames = varargin{opvarcount};
           
       case {'plot_vrms'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           plot_vrms = varargin{opvarcount};
           
       case {'is_constant'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           is_constant = varargin{opvarcount};
           
       case {'logincrement','loginc'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           loginc = varargin{opvarcount};
           
       case {'nBins','Nbins','N','numBins','bins','BINS'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           nBins = varargin{opvarcount};
           
       case {'n_average_points','span','Span','averagingRange'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           n_average_points = varargin{opvarcount};
           
       case {'system','System','Units','units'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           system = varargin{opvarcount};
           
       case {'minstrainrate','minStrainRate','MinStrainRate'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           min_strain_rate_res = varargin{opvarcount};
           
       case {'showSmoothPlots','smoothPlots','filterData','smoothData'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           show_filtered_data_figs = varargin{opvarcount};
           
       case {'showDataFitting','ShowDataFit','ShowDataFitting'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           show_data_fit = varargin{opvarcount};
           
       case {'flipdata','FlipData','flipData'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           flip_data = varargin{opvarcount};
           
       case {'averagealong','AverageAlong','averageAlong'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           average_along = varargin{opvarcount};
           
       case {'strainrate','StrainRate','strainRate'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           strainrate = varargin{opvarcount};
           
       case {'runnumber','runNumber','RunNumber'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           runnum = varargin{opvarcount};
           
       case {'quenchduration','quenchDuration','QuenchDuration'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           quenchduration = varargin{opvarcount};
           
       case {'verbosefit','VerboseFit','verboseFit'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           switch lower(varargin{opvarcount});
               case {'yes','on','true'}
                   verbose_fit = 'true';
               otherwise
                   verbose_fit = 'false';
           end
           
       case {'periodicbounds','PeriodicBounds','periodicBounds'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           switch lower(varargin{opvarcount})
               case {'yes','on','true'}
                   periodic_bounds = 'true';
               otherwise
                   periodic_bounds = 'false';
           end
           
       case {'matchstrain','atstrains','match_strain','at_strain'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           at_strain = varargin{opvarcount};
           
       case {'strain_increment','straininc','strainincrement'}
           assert(opvarcount+1<=numel(varargin))
           opvarcount = opvarcount + 1;
           straininc = varargin{opvarcount};
              
       otherwise
           if ~ischar(varargin{opvarcount})
               errtxt1 = [' ',num2str(varargin{opvarcount})];
               error_l1 = strcat('Error!:',errtxt1);
           else
               error_l1 = strcat('Error!:',varargin{opvarcount});
           end
           errorstatement = ' is an unrecognized input parameter.';
           error(strcat(error_l1,errorstatement));
           
   end
   
   opvarcount = opvarcount + 1;
   
end