function [x_mean,y_mean,x_err,y_err] = computeAverageValues(x,y,npoints)
% Sorts x,y data in ascending order of x-values. Partitions data into
% npoints number of bins. Returns mean value, error of each bin.

    % Sort x and y data.
    [x,indx] = sort(x);                                                    
    y = y(indx);                                                               
    
    % Calculate m, the modulus of the data array length and desired 
    % averaging window. If m = 0, reshape. If m ~=0, pad and reshape.
    m = mod(numel(x),npoints);    
    if m == 0
        xnew = reshape(x,npoints,[]);
        ynew = reshape(y,npoints,[]);
    else
        % Determine the average of the points that lack enough elements to
        % complete an entire bin.
        xbar = mean(x(end-m+1:end));
        ybar = mean(y(end-m+1:end));
        % Create a temporary array whose modulus is zero by adding n-m
        % elements with the mean value of the last bin.
        xtmp = [x ones(1,npoints-m)*xbar];
        ytmp = [y ones(1,npoints-m)*ybar];
        % Reshape the matrix into arrays of length 'npoints'
        xnew = reshape(xtmp,npoints,[]);
        ynew = reshape(ytmp,npoints,[]);
    end
    
    % Calculate the averages of each cluster
    x_mean = mean(xnew);
    y_mean = mean(ynew);
    
    % Calculate the errors of each cluster
    x_err = std(xnew)/sqrt(npoints);
    y_err = std(ynew)/sqrt(npoints);
    
end