function main()
tic
% Initialize empty structure array
glass = struct(...
    'system',[],...
    'strain_rate',[],...
    'quench_rate',[],...
    'run_num',[],...
    'file_path',[],...
    'num_configs',[],...
    'num_atoms',[],...
    'pos',[],...
    'timestep',[],...
    'bounds',[],...
    'xpos',[],...
    'ypos',[],...
    'zpos',[]);

% Populate structure array
glass(1).system = 'Si';
glass(1).strain_rate = '1e-4';
glass(1).quench_rate = '1e12';
glass(1).run_num = '2';
glass(1).file_path = ...
    '/Volumes/MARCC/scratch/Si/run2/shear/qr_1e12/sr_00010/data/MATLAB/';

for i = numel(glass)
    % List all files in directory
    file_info = dir(glass(i).file_path);
    
    % Remove directories from file structure
    for j = numel(file_info):-1:1
        if file_info(j).isdir
            file_info(j) = [];
        end
    end
    
    % Store number of LAMMPS snapshots
    glass(i).num_configs = numel(file_info);
      
    % Initialize data arrays
    glass(i).timestep = zeros(1,numel(file_info));
    glass(i).num_atoms = zeros(1,numel(file_info));
    glass(i).bounds = zeros(3,3,numel(file_info));

    % Open each file, store contents
    for j = 1:numel(file_info)
        filepath = strcat(glass(1).file_path,file_info(j).name);
        fid = fopen(filepath);
        glass(i).timestep(j) = ...
            cell2mat(textscan(fid,'%u',1,'delimiter','\n','headerlines',1));
        glass(i).num_atoms(j) = ...
            cell2mat(textscan(fid,'%u',1,'delimiter','\n','headerlines',1));
        glass(i).bounds(:,:,j) = ...
            cell2mat(textscan(fid,'%f %f %f',3,'delimiter',' ','headerlines',1));
        
        formatspec = '%u %u %f %f %f %d %d %d %f %f %f %f';
        filedata = textscan(fid,formatspec,glass(1).num_atoms,'headerlines',2);
        
        % Save x,y position, y flags and potential energy to structure
        glass(i).xpos(:,:,j) = cell2mat(filedata(3));
        glass(i).ypos(:,:,j) = cell2mat(filedata(4));
        glass(i).xflg(:,:,j) = cell2mat(filedata(6));
        glass(i).yflg(:,:,j) = cell2mat(filedata(7));
        glass(i).poteng(:,:,j) = cell2mat(filedata(12));
        
        % Free memory
        clear filedata
        fclose(fid);
    end
    
    % Compute wrapped x-positions
%     glass_struct(1).xpos_wrapped = ...
%         glass_struct(1).xpos - glass_struct(1).xflag * glass_struct(1).bounds(
    % Compute x-displacement from frame 0
    glass(i).xdis =  glass(1).xpos - ...
        repmat(glass(i).xpos(:,:,1),1,1,glass(i).num_configs);

end



toc
end