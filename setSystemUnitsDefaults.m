% Allow user to specify units based on material system

switch lower(system)
    
    case {'lancon','2dlj'}
        title_name = 'Lancon Glass';
        quench_type = 'Duration';
        qnch_durations = {'    1e4 \tau','    1e5 \tau','    1e6 \tau'};
        quenchrateunits = '\tau^{-1}';
        distanceunits = '\sigma';
        energyunits = '\epsilon';
        strainrateunits = '\tau^{-1}';
        timeunits = '\tau';
        type = 2; % Select Solute Atoms
        tstep = 0.005; % Default Timestep for LJ
        qrates = {'\boldmath$QR = 1e4 \hspace{.5mm} t_0$',...
                    '\boldmath$QR = 1e5 \hspace{.5mm} t_0$',...
                    '\boldmath$QR = 1e6 \hspace{.5mm} t_0$'};
        periodic_bounds = 'true';
        systemnames = {'    1e4 \tau','    1e5 \tau','    1e6 \tau'};
        
    case {'kobandersen','kob-andersen','3dlj'}
        title_name = 'Kob-Andersen Glass';
        quench_type = 'Duration';
        qnch_durations = {'    1e3 \tau','    1e4 \tau','    1e5 \tau'};
        quenchrateunits = '\tau^{-1}';  
        distanceunits = '\sigma';
        energyunits = '\epsilon';
        strainrateunits = '\tau^{-1}';
        timeunits = '\tau';
        type = 2; % Select Solute Atoms
        tstep = 0.005; % Default Timestep for LJ
        qrates = {'\boldmath$QR = 1e3 \hspace{.5mm} t_0$',...
                    '\boldmath$QR = 1e4 \hspace{.5mm} t_0$',...
                    '\boldmath$QR = 1e5 \hspace{.5mm} t_0$'};
        periodic_bounds = 'true';
        systemnames = {'    1e4 \tau','    1e5 \tau','    1e6 \tau'};

    case {'Alix_CuZr'}
        quench_type = 'Rate';
        distanceunits = char(197);
        energyunits = 'eV';
        strainrateunits = 'ps^{-1}';
        qrates = {'\boldmath$QR = 1e11 \hspace{.5mm} K/s$',...
                    '\boldmath$QR = 1e10 \hspace{.5mm} K/s$',...
                    '\boldmath$QR = 1e09 \hspace{.5mm} K/s$'};
        type = 2; % Si
        tstep = 0.002;
        periodic_bounds = 'true';
        systemnames = {'CZ-1','CZ-2','CZ-3'};
        
    case {'si','tanguy','asi'}
        title_name = 'a-Si Glass';
        quenchrateunits = 'K ps^{-1}';
        quench_type = 'Rate';
        qnch_durations = {'    1.00 K ps^{-1}','    0.10 K ps^{-1}','    0.01 K ps^{-1}'};

        distanceunits = char(197);
        energyunits = 'eV';
        strainrateunits = 'ps^{-1}';
        timeunits = 'ps';
        type = 1; % Select Solute Atoms
        tstep = 0.002; % Default Timestep for LJ
        qrates = {'\boldmath$QR = 1.00 \hspace{.5mm} K ps^{-1}$',...
                    '\boldmath$QR = 0.10 \hspace{.5mm} K ps^{-1}$',...
                    '\boldmath$QR = 0.01 \hspace{.5mm} K ps^{-1}$'};
        periodic_bounds = 'true';
        systemnames = {'    1.00 K ps^{-1}','    0.10 K ps^{-1}','    0.01 K ps^{-1}'};
        
     case {'cu64zr34','cz'}
        title_name = 'Cu_{64}Zr_{34} Glass';
        quenchrateunits = 'K ps^{-1}';
        quench_type = 'Rate';
        qnch_durations = {'    .100 K ps^{-1}','    .010 K ps^{-1}','    .001 K ps^{-1}'};

        distanceunits = char(197);
        energyunits = 'eV';
        strainrateunits = 'ps^{-1}';
        timeunits = 'ps';
        type = 2; % Select Solute Atoms
        tstep = 0.002; % Default Timestep for LJ
        qrates = {'\boldmath$QR = 1.00 \hspace{.5mm} K ps^{-1}$',...
                    '\boldmath$QR = 0.10 \hspace{.5mm} K ps^{-1}$',...
                    '\boldmath$QR = 0.01 \hspace{.5mm} K ps^{-1}$'};
        periodic_bounds = 'true';
        systemnames = {'    .100 K ps^{-1}','    .010 K ps^{-1}','    .001 K ps^{-1}'};

end