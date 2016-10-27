function [Type,Pos,Flg,PE,tdata,bounds,Vel] = sortData(SrcDir,SrcName)
% Opens files in the provided source directory whos name matches the
%   source name and stores data in multidimensional matrices corresponding
%   to position, flags, and potential energy, respectively.

    enforce_equidistant_configs = 'no';                                     % Require equally-spaced config snapshots
    
    % Set initial values for source directory and source file names 
    %   according to the number of input variables.
    if (nargin < 2)                                                         % If less than two variables are provided,
        data_filenames = strcat(SrcDir,'*.data');                           % SrcName assumed to be missing. Check the
        text_filenames = strcat(SrcDir,'*.txt');                            % provided directory for the total number of 
        [n_datafiles,~] = size(dir(data_filenames));                        % files matching '*.data' and '*.txt' extensions.
        [n_textfiles,~] = size(dir(text_filenames));                        % Keep the extension with the most files.                      
        if n_datafiles > n_textfiles                                                      
            SrcName = '*.data';                                               
        elseif n_datafiles < n_textfiles                                                                
            SrcName = '*.text';
        else                                                                % If there are an equivalent number of files of
            errortext = 'Unable to determine file extension.';              % each file type, throw and error.
            error(errortext)
        end
        if (nargin < 1)                                                     % If no input parameters are specified, assume 
            SrcDir = './';                                                  % config files are located in current directory.
        end
    end
    
    
    

    % Using source directory and source file names, create a structure
    %   containing all source data.
    FileName = strcat(SrcDir,SrcName);
    DataFiles = dir(FileName);
    nFiles = length(DataFiles);

    disp('Before Change');
    disp(nFiles)
    % If entire directory is referenced instead of subset...
    if nFiles > 31 
        % delete all odd-step elements from structure
        for i = nFiles:-1:1
            if mod(i,2) == 0
                DataFiles(i) = [];
            end
        end
    end
    
    % Update the number of elements to reflect changes
    nFiles = length(DataFiles);
    disp('After Changes')
    disp(nFiles)
    bounds = zeros(3,3,nFiles);
    tdata = zeros(1,nFiles);   
    for i = 1:nFiles
        
        % Verify that the file is an even snapshot,
        FileName = DataFiles(i).name;

        
        FullPath = strcat(SrcDir,FileName);
        
        % Gather timestep data, save to tdata array         
        tdatatmp = importdata(FullPath,' ',1);
        boundstmp = importdata(FullPath,' ',5);
        bounds(:,:,i) = boundstmp.data;
        tdata(i) = tdatatmp.data;
        
        % Gather all other data
        FileData = importdata(FullPath,' ', 9);
        colheaders = strsplit(FileData.textdata{9});                        % Gather column header string text
        colheaders(1:2) = [];                                               % Remove indices 1,2 ('ITEM:'),('ATOMS:')
        colheaders(end) = [];                                               % Remove final index, whitespace
        
        % Gather column indices for position, flags, energy and type.
        % Assumes input file has position/flag x,y, and z components.
        pos_index_head = find(strcmp(colheaders,'x'));
        if isempty(pos_index_head)                                          % Some headers are unscaled positions
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
    
    switch enforce_equidistant_configs                                      % Control strict requirement of equidistant
        case {'Yes','yes','YES'}                                            % elapsed time between configurations. Thrown
            if sum(diff(tdata,2)) ~= 0                                      % error if difference in elapsed time is not
                errortext = 'Disparate timestep between outputs.';          % exactly 0.    
                error(errortext);
            end
    end

end
