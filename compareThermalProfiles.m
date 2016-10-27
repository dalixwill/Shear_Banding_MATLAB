% Compute mean and standard deviation of velocity
close all

fileDir = '/Volumes/MCCOY/Research/Shear_Banding/Cu64Zr36/AR_4x20x1/';
subDir1 = 'run_02/qr_1e09/sr_00010/';
subDir2 = 'run_02/qr_1e10/sr_00010/';
subDir3 = 'run_02/qr_1e11/sr_00010/';
srcDirs = {...
    strcat(fileDir,subDir1),...
    strcat(fileDir,subDir2),...
    strcat(fileDir,subDir3)};
   
dataFiles = {...
    '000000000000.txt',...
    '000004000000.txt',...
    '000004500000.txt',...
    '000005000000.txt',...
    '000005500000.txt',...
    '000006000000.txt'};

nBins = 100;

% Select only Cu atoms
pType = 2; 

[~,nDirs] = size(srcDirs);
[~,nFiles] = size(dataFiles);

cumVel = cell(nDirs,1);
refMu = cell(nDirs,1);
refSigma = cell(nDirs,1);
cumMu = cell(nDirs,1);
cumSigma = cell(nDirs,1);

for i = 1:nDirs 
    srcDir_i = char(srcDirs(i)); 
    cumVel{i} = [];
    refMu{i} = [];
    refSigma{i} = [];
    
    for j = 1:nFiles
        srcFile_j = char(dataFiles(j));
        
        % Parse file and define variables
        [Type,Pos,Flgs,PE,~,Bounds,Vel] = sortData(srcDir_i,srcFile_j);
        
        % Bin atoms according to y-position
        Bins = binData(Pos,nBins,Flgs,Bounds);
        
        cType = (Type(:,:,:)==pType);
        
        % Calculate binned, atomic mean square velocity
        vel_sqr = Vel.*Vel;
        vel_sqr_norm = sum(vel_sqr,2);
        normVelBin = averageBins(Bins,vel_sqr_norm,cType);
        
        
        if j == 1
            normVelBin_0 = normVelBin;
            refMu{i} = mean(normVelBin_0);
            refSigma{i} = std(normVelBin_0);
        else
            cumVel{i} = cat(2,cumVel{i},normVelBin);
            figure
            hold on
            plot(normVelBin_0)
            plot(normVelBin)
            lgndtxt_1 = ['\mu = ', num2str(mean(normVelBin_0)),...
                '    \sigma = ', num2str(std(normVelBin_0))];
            lgndtxt_2 = ['\mu = ', num2str(mean(normVelBin)),...
                '    \sigma = ', num2str(std(normVelBin))];
            legend(lgndtxt_1,lgndtxt_2)
            hold off
            set(gcf,'WindowStyle','docked');
        end
        
        
    end
    
    cumMu{i} = mean(cumVel{i});
    cumSigma{i} = std(cumVel{i});
    disp('Reference Mean:')
    disp(refMu{i})
    disp('Reference Deviation:')
    disp(refSigma{i})
    disp('Displacement Mean:')
    disp(mean(cumVel{i}));
    disp('Displacement Sigma:')
    disp(std(cumVel{i}));
    

end

figure
hold on
e1 = errorbar(1:nDirs,cell2mat(refMu),cell2mat(refSigma));
e2 = errorbar(1:nDirs,cell2mat(cumMu),cell2mat(cumSigma));

e1.Marker = 'o';
e1.MarkerSize = 20;
e1.LineWidth = 4;
e2.Marker = 'x';
e2.MarkerSize = 20;
e2.LineWidth = 4;

hold off
set(gcf,'WindowStyle','docked');