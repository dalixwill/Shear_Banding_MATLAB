function [xavgs,yavgs,xerr,yerr] = binLogData(x,y,inc)
% Sorts x,y data in ascending order of x-values. Partitions data into
% npoints number of bins. Returns mean value, error of each bin.

    % Determine range from y-values
    ymin = floor(min(y));
    ymax = ceil(max(y));
    
    % Determine partition bounds, nBins, N data points
    ylo = ymin:inc:ymax;
    yhi = ylo+inc;
    nBins = numel(ylo);
    N = numel(y);
    
    % Replicate to form n_yvals x nBins matrix
    ylo_rep = repmat(ylo,N,1);
    yhi_rep = repmat(yhi,N,1);
    y_rep = repmat(y',1,nBins);
    
    % Create N x nBins logical array where non-zero values represent values
    % of y  that fall within y-lo and y-hi boundaries
    is_member = y_rep > ylo_rep & y_rep <= yhi_rep;
    
    % Initialize average value, standard error and counter arrays
    cumsum = 0;
    xavgs = zeros(1,nBins);
    yavgs = zeros(1,nBins);
    xerr = zeros(1,nBins);
    yerr = zeros(1,nBins);
    ncount = zeros(1,nBins);
    
    for indx = 1:nBins
       % Determine number of elements in bin
       nvals = sum(is_member(:,indx));
       
       % Store all components of bin, including zeros
       xtmp = x.*(is_member(:,indx))';
       ytmp = y.*(is_member(:,indx))';
       
       % Retrieve non-zero array components
       xtmp = xtmp(xtmp~=0);
       ytmp = ytmp(ytmp~=0);

       % Calculate, store average values
       xavgs(indx) = sum(xtmp)/nvals;
       yavgs(indx) = sum(ytmp)/nvals;
       
       % Store counter values
       ncount(indx) = numel(xtmp);
       
       % Calculate, store standard error
       xerr(indx) = std(xtmp)/sqrt(numel(xtmp));
       yerr(indx) = std(ytmp)/sqrt(numel(ytmp));
       
       % Update sum counter
       cumsum = cumsum + nvals;
       
    end
    
end