function newpos = adjust_for_PBCs(oldpos,flags,bounds)
% Adjust atomic coordinates for atoms that cross periodic boundaries.

    [~,~,nconfigs] = size(oldpos);                                          % Determine number of configurations              
    newpos = zeros(size(oldpos));                                           % Preallocated modified position array
    for i = 1:nconfigs
        Lx = bounds(1,2,i)-bounds(1,1,i);                                   % Determine length of each configuration,
        Ly = bounds(2,2,i)-bounds(2,1,i);                                   % could change due to deformation.
        xpos = oldpos(:,1,i);                                               % Store x,y position, for current config.
        ypos = oldpos(:,2,i);                                               
        xflags = flags(:,1,i);                                              % Store x,y flags for current configuration.
        yflags = flags(:,2,i);
        xpos(xflags~=0) = xpos(xflags~=0)+xflags(xflags~=0)*Lx;             % Adjust x,y position for non-zero flags
        ypos(yflags~=0) = ypos(yflags~=0)+yflags(yflags~=0)*Ly;
        newpos(:,1,i) = xpos;                                               % Return modified x,y positions.
        newpos(:,2,i) = ypos;
    end
        
        
end
