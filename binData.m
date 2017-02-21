function [atom_bin] = binData(Pos,nbins,Flgs,bounds)
%   Bins atoms according to y-position and returns a logical array of 
%   size [natoms x nbins x nfiles] whos true values correspond to 
%   atoms with y-coordinates within a prescribed range. User can control
%   the treatment of atoms that cross periodic boundaries. 

    % Using input dimensions, preallocate atomic bin logical array.
    [natoms,~,nconfigs] = size(Pos);                                         
    atom_bin = zeros(natoms,nbins,nconfigs);
    
    % toggle for inclusion/exclusion of atoms crossing PBCs
    include_atoms_across_PBCs = 'yes';                                      

    % Parse through configurations, using snapshot simulation y-bounds and 
    % current atomic positions to sort atoms into respective bins.
    for i = 1:nconfigs
        
        % Current y-position of every atom
        ypos = Pos(:,2,i);
        
        % min, max y-positions of simulation box
        Ly_min = bounds(2,1,i);                                             
        Ly_max = bounds(2,2,i); 
        
        % height and upper/lower limits of each bin
        hbin = (Ly_max-Ly_min)/nbins;                                       
        binmax = linspace(Ly_min+hbin,Ly_max,nbins);                        
        binmin = linspace(0,Ly_max-hbin,nbins);
        
        % replicate bin extents, atomic positions into natoms x nbins 
        % array, used for logical comparison without loops
        binmax_rep = repmat(binmax,natoms,1);                               
        binmin_rep = repmat(binmin,natoms,1);                               
        ypos_rep = repmat(ypos,1,nbins);                                   
        
        % Toggle for treatement of periodic boundary conditions (PBCs)
        switch include_atoms_across_PBCs
            
            % Include atoms that lie outside of simulation boundaries
            case 'yes'  
                atom_bin(:,:,i) = ypos_rep >= binmin_rep & ...
                    ypos_rep < binmax_rep ;
            
            % Exclude atoms that lie outside of simulation boundaries 
            % and/or crossed boundaries from previous snapshot    
            case 'no'  
                yflags = Flgs(:,2,i);
                yflg_rep = repmat(yflags,1,nbins);
                atom_bin(:,:,i) = ypos_rep >= binmin_rep & ...
                    ypos_rep < binmax_rep & yflg_rep == 0;
                
            % Include atoms that crossed PBCs on previous snapshot    
            case 'constant'        
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