function [atom_bin] = binData(Pos,nbins,Flgs,bounds)
%   Bins atoms according to y-position and returns a logical array of 
%   size [natoms x nbins x nfiles] whos true values correspond to 
%   atoms with y-coordinates within a prescribed range. User can control
%   the treatment of atoms that cross periodic boundaries. 

    [natoms,~,nconfigs] = size(Pos);                                        % determine number of atoms and system configurations 
    atom_bin = zeros(natoms,nbins,nconfigs);                                % preallocate atomic bin matrix    
    include_atoms_across_PBCs = 'yes';                                      % toggle for inclusion/exclusion of atoms crossing PBCs

    for i = 1:nconfigs
        ypos = Pos(:,2,i);                                                  % store y-position data for current configuration                
        Ly_min = bounds(2,1,i);                                             % store minimum y-position of sim box
        Ly_max = bounds(2,2,i);                                             % store maximum y-position of sim box
        hbin = (Ly_max-Ly_min)/nbins;                                       % calculate height of each bin
        binmax = linspace(Ly_min+hbin,Ly_max,nbins);                        % calculate upper limit y-position of each bin
        binmin = linspace(0,Ly_max-hbin,nbins);                             % calculate lower limit y-position of each bin 
        binmax_rep = repmat(binmax,natoms,1);                               % replicate max heights to natoms x nbins matrix
        binmin_rep = repmat(binmin,natoms,1);                               % replicate min heights to natoms x nbins matrix
        ypos_rep = repmat(ypos,1,nbins);                                    % replicate atom positions to natoms x nbins matrix
        
        
        switch include_atoms_across_PBCs
            % toggle for treatment of atoms crossing periodic boundaries
            case 'yes'  
                % include atoms that cross periodic bounds    
                atom_bin(:,:,i) = ypos_rep >= binmin_rep & ...
                    ypos_rep < binmax_rep ;
            case 'no'  
                % exclude atoms that cross periodic bounds
                yflags = Flgs(:,2,i);
                yflg_rep = repmat(yflags,1,nbins);
                atom_bin(:,:,i) = ypos_rep >= binmin_rep & ...
                    ypos_rep < binmax_rep & yflg_rep == 0;
            case 'constant'        
                % include atoms that cross periodic bounds if crossing
                % occurred on previous timestep.
                if i == 1
                    yflags = zeros(size(Flgs(:,2,i)));
                else
                    yflags = Flgs(:,2,i)~=Flgs(:,2,i-1);
                end                
                yflg_rep = repmat(yflags,1,nbins);
                atom_bin(:,:,i) = ypos_rep >= binmin_rep & ...
                    ypos_rep < binmax_rep & yflg_rep == 0;
        end
        
    end
end