function [BinAvg] = averageBins(Bins,Vals,Type)
% Computes and returns per-Bin averages for a given value array. 

    % Using input data, determine the dimensions of the return array and 
    %   preallocate it for speed.
    [~,nBins,~] = size(Bins);
    [~,nFiles] = size(Vals);
    BinAvg = zeros(1,nBins,nFiles);    

    for j = 1:nFiles        
        for i = 1:nBins
            tmp = Bins(:,i,j).*Vals(:,j).*Type(:,j);
            BinAvg(1,i,j) = mean(tmp(tmp~=0));          
        end
    end
    
    BinAvg(isnan(BinAvg))=0;    % Make sure NaN values are 0.
 
end
