function [Type,Pos,Flg,PE,tdata,bounds,Vel] = ...
    sortData(SrcDir,SrcName,varargin)
% Opens files in the provided source directory whos name matches the
%   source name and stores data in multidimensional matrices corresponding
%   to position, flags, and potential energy, respectively.

    % Require equally-spaced config snapshots
    enforce_equidistant_configs = 'no';                                     
    
    % Set initial values for source directory and source file names 
    %  according to the number of input variables. If less than two
    %  variables are provided, SrcName assumed to be missing. 
    if (nargin < 2)                                                         
        data_filenames = strcat(SrcDir,'*.data');                           
        text_filenames = strcat(SrcDir,'*.txt');                              
        [n_datafiles,~] = size(dir(data_filenames));                        
        [n_textfiles,~] = size(dir(text_filenames));
        
        % Check the provided directory for the total number of files
        % matching '*.data', '*.txt' extensions. 
        % Keep the extension with the most files.
        if n_datafiles > n_textfiles                                                      
            SrcName = '*.data';                                               
        elseif n_datafiles < n_textfiles                                                                
            SrcName = '*.txt';
            
        % If there are an equivalent number of files of
        % each file type, throw and error.
        else                                                                
            errortext = 'Unable to determine file extension.';              
            error(errortext)
        end
        
        % If no input parameters are specified, assume
        % config files are located in current directory.
        if (nargin < 1)                                                      
            SrcDir = './';                                                  
        end
    end
    
    % Using source directory and source file names, create a structure
    %   containing all source data.
    FileName = strcat(SrcDir,SrcName);
    DataFiles = dir(FileName);
    nFiles = length(DataFiles);
    
    % Set default values
    % Assume strain taken at 100% strain increments
    straininc = 1;
    at_strain_toggle = 0;
    
    % Parse optional input parameters
    opvarcount = 1;
    while opvarcount < numel(varargin)
       switch lower(varargin{opvarcount})
           
           % If file directory contains all strain snapshots, set the
           % desired strain increment for files to keep.
           case {'all_data','alldata'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               straininc = varargin{opvarcount};
               
           % Gather the imposed strain rate
           case {'strainrate','strain_rate'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               strainrate = varargin{opvarcount};
               
           % Gather the timestep
           case {'timestep','time_step','dt'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               dt = varargin{opvarcount};
              
           % Specify which strain increments to collect
           case {'atstrain','at_strains'}
               assert(opvarcount+1<=numel(varargin))
               opvarcount = opvarcount + 1;
               at_strain = varargin{opvarcount};
               at_strain_toggle = 1;
       end
       
       % Increment the optional variable counter to continue search
       opvarcount = opvarcount + 1;
    end
    
    disp('Total number of snapshots read:');
    disp(nFiles)
    
    % Parse through files in reverse, keeping only files whose strain
    % corresponds to the desired strain increment.
    for i = nFiles:-1:1
        
       % Convert filename to strain increment
       FileName = DataFiles(i).name;
       timestep = str2double(regexprep(FileName,'.txt',''));
       strain = round(strainrate*timestep*dt,3);
       
       % If specified, keep only data from specific strain increments.
       if at_strain_toggle == 1
           if ~ismember(strain,at_strain)
               DataFiles(i) = [];
           end
           
       % Otherwise, keep only data from desired strain increment.
       else
           if mod(strain,straininc) ~= 0
               DataFiles(i) = [];
           end  
       end      
    end
    
    % Update the number of elements to reflect changes, print to screen
    nFiles = length(DataFiles);
    disp('Number of snapshots analyzed:')
    disp(nFiles)
    
    bounds = zeros(3,3,nFiles);
    tdata = zeros(1,nFiles);   
    for i = 1:nFiles
        
        FileName = DataFiles(i).name;        
        FullPath = strcat(SrcDir,FileName);
        
        % Gather timestep, bounds and save to arrays         
        tdatatmp = importdata(FullPath,' ',1);
        boundstmp = importdata(FullPath,' ',5);
        bounds(:,:,i) = boundstmp.data;
        tdata(i) = tdatatmp.data;
        
        % Gather all other data - less columns 1,2 and final whitespace
        FileData = importdata(FullPath,' ', 9);
        colheaders = strsplit(FileData.textdata{9});                        
        colheaders(1:2) = [];                                               
        colheaders(end) = [];                                               
        
        % Gather column indices for position, flags, energy and type.
        % Assumes input file has position/flag x,y, and z components.
        pos_index_head = find(strcmp(colheaders,'x'));
        
        % Header may correspond to unscaled positions, xu
        if isempty(pos_index_head)                                         
            pos_index_head = find(strcmp(colheaders,'xu'));
        end
        pos_index_tail = find(strcmp(colheaders,'z'));
        if isempty(pos_index_tail)
            pos_index_tail = find(strcmp(colheaders,'z'));
        end
        flg_index_head = find(strcmp(colheaders,'ix'));
        flg_index_tail = find(strcmp(colheaders,'iz'));
        vel_index_head = find(strcmp(colheaders,'vx'));
        vel_index_tail = find(strcmp(colheaders,'vz'));        
        eng_index = find(strcmp(colheaders,'c_eng'));
        type_index = find(strcmp(colheaders,'type'));
        
        % Preallocate matrices on the first iteration      
        if i == 1
            Dims = size(FileData.data);
            nAtoms = Dims(1);
            Type = zeros(nAtoms,length(type_index:type_index),nFiles);
            Pos = zeros(nAtoms,length(pos_index_head:pos_index_tail),nFiles);
            Flg = zeros(nAtoms,length(flg_index_head:flg_index_tail),nFiles);
            PE = zeros(nAtoms,length(eng_index:eng_index),nFiles);
            Vel = zeros(nAtoms,length(vel_index_head:vel_index_tail),nFiles);
        end
        
        % Populate position, velocity, flag and potential energy matrices
        Pos(:,:,i) = FileData.data(:,pos_index_head:pos_index_tail);
        Flg(:,:,i) = FileData.data(:,flg_index_head:flg_index_tail);
        Type(:,:,i) = FileData.data(:,type_index:type_index);
        Vel(:,:,i) = FileData.data(:,vel_index_head:vel_index_tail);
        PE(:,:,i) = FileData.data(:,eng_index:eng_index);    
        
    end
    
    % Switch to require equidistant elapsed time between configurations.
    switch enforce_equidistant_configs                                      
        case {'Yes','yes','YES'}                                            
            if sum(diff(tdata,2)) ~= 0                                      
                errortext = 'Disparate timestep between outputs.';              
                error(errortext);
            end
    end

end
