function [x_mean,y_mean,x_dev,y_dev] = computeAverageValues(x,y,npoints)
    nargin
    plot_resultant_data = 'no';
    
    switch nargin                                                           % This switch controls initial conditions.
        case 0                                                              % If no inputs are specified, assumes the
            text_l1 = 'Warning! No inputs were specified.\n';               % user wants to demo the function and 
            text_l2 = 'Running demo mode using random data.\n';             % randomly generates and outputs data.
            fprintf([text_l1,text_l2]);
            x = rand(1,100);
            y = sin(x) + rand(1,100)*.1;
            npoints = 20;
            plot_resultant_data = 'yes';
        case 1                                                              % If a single input is specified:
            if length(x) < 3                                                % Throws an error if the length of the input
                warntext = 'Insufficient number of data points.';           % array is less than 3... Mean and standard
                warn(warntext);                                             % deviation have little meaning in this case.
            else
                text_l1 = 'Warning! y and n are unspecified.\n';            % Assumes that the data is on a line of 
                text_l2 = 'Assuming y-array is equally-spaced along x.\n';  % equally-spaced data points. Averages data 
                text_l3 = 'Averaging over every three points.\n';           % over every three (3) data points.
                fprintf([text_l1,text_l2,text_l3]);
                y = ones(1,length(x));
                npoints = round(length(x)/5);
            end
        case 2   
            if length(x) < 3                                                % Throws an error if the length of the input
                warntext = 'Insufficient number of data points.';           % array is less than 3. Mean and standard
                warn(warntext);                                             % deviation have little meaning in this case.
            else
                % If x and y are input, but not the number
                text_l1 = 'Warning! n-points were not specified.\n';        % of points about which to take the average, 
                text_l2 = 'Averaging over every three points.\n';           % will average over every 3 data points. 
                fprintf([text_l1,text_l2]);
                npoints = round(length(x)/3);
            end
    end

    [x,indx] = sort(x);                                                     % sort x data
    y = y(indx);                                                            % sort y data consistent with x

    i_sort_head = 1:npoints:length(x);                                      % Stores the indices for the start and stop 
    i_sort_tail = npoints:npoints:length(x);                                % of averaging over the input data array(s).

    if numel(i_sort_head) > numel(i_sort_tail)                              % Guarantee that final sorting index
        i_sort_tail(end+1) = length(x);                                     % corresponds to highest index of the
    end                                                                     % input data array.

    x_mean = zeros(1,length(i_sort_tail));                                  % Preallocate x-mean array,
    y_mean = zeros(1,length(i_sort_tail));                                  % y-mean array,
    x_dev = zeros(1,length(i_sort_tail));                                   % x-standard deviation and
    y_dev = zeros(1,length(i_sort_tail));                                   % y-standard deviation arrays
    
    for i = 1:length(i_sort_tail)                                           % Iterate through all head/tail index pairs.
        if i_sort_tail(i) > length(x)                                       % This "if" statement should never be true;
            x_mean(i) = mean(x(i_sort_head(i):end));                        % But if so, guarantees that final index is 
            y_mean(i) = mean(y(i_sort_head(i):end))/sqrt();                        % the last data point in x.
            x_dev(i) = std(x(i_sort_head(i):end),1);
            x_dev(i) = x_dev(i)/sqrt(numel(x_dev(i)));
            y_dev(i) = std(y(i_sort_head(i):end),1);
            y_dev(i) = y_dev(i)/sqrt(numel(y_dev(i)));
        else                                                                % This condition should always hold;
            x_mean(i) = mean(x(i_sort_head(i):i_sort_tail(i)));             % Averages x and y data over interval given
            y_mean(i) = mean(y(i_sort_head(i):i_sort_tail(i)));             % by the head/tail index pairs. 
            x_dev(i) = std(x(i_sort_head(i):i_sort_tail(i)),1);               % Also computes the standard deviation of
            x_dev(i) = x_dev(i)/sqrt(numel(x_dev(i)));
            y_dev(i) = std(y(i_sort_head(i):i_sort_tail(i)),1);               % x and y over this range.
            y_dev(i) = y_dev(i)/sqrt(numel(y_dev(i)));
        end
    end
    
    switch plot_resultant_data                                              % This switch controls the output of plots.
        case {'Yes','YES','yes'}
            figure                                                          
            hold on
            plot(x,y,'.')                                                   % Plots the original data as dots ("."),
            plot(x_mean,y_mean,'ro')                                        % the average values as circles ("o"),
            errorbar(x_mean,y_mean,y_dev,'.')                               % vertical error bars and
            herrorbar(x_mean,y_mean,x_dev,'.')                              % horizontal error bars on the same axes.
            hold off
    end
    
end