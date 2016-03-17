%% Hybrid CuZr Structures, SR = 0.0001 1/ps, nBins = 22
close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e12/sr0001/Run0/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e11/sr0001/Run0/Data/';
Dir3 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e10/sr0001/Run0/Data/';

% showBanding({Dir1,Dir2,Dir3},22,[18,0,0],25,'Hybrid')
% showBanding({Dir1},22,[18],25,'Hybrid')
% showBanding({Dir3},22,[0],25,'Hybrid')

showBanding({Dir3},50,[0],25,'Hybrid')


%% Alix CuZr Structures, SR = 0.0001 1/ps, nBins = 22

close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr5e11/sr0001/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr1e11/sr0001/Data/';
Dir3 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr5e10/sr0001/Data/';

showBanding({Dir1,Dir2,Dir3},22,[18,0,10],18,'CuZr')

%% Si Structures, SR = 0.0001 1/ps, nBins = 22

close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/Si/Data/qr5e11/sr0001/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/Si/Data/qr1e11/sr0001/Data/';
Dir3 = '~/Google_Drive/Research/LOOKHEREMICHAEL/Si/Data/qr5e10/sr0001/Data/';

% showBanding({Dir1,Dir2,Dir3},22,[0,4,4],22,'Si')
showBanding({Dir1},50,[0],22,'Si')

%% Hybrid CuZr Structures, SR = 0.0001 1/ps, nBins = 22
% These structures were initially equilibrated at 300 K, 0 bar

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e11/sr0001/Run1/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e10/sr0001/Run1/Data/';

showBanding({Dir2},22,[11],25,'Hybrid')

%% Compare Unrelaxed and Relaxed Pressure Structures
% QR = 1e11 K/s, SR = 0.001 1/ps

close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e11/sr0001/Run0/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e11/sr0001/Run1/Data/';

showBanding({Dir1,Dir2},22,[0,11],25,'Hybrid')

%% Compare Unrelaxed and Relaxed Pressure Structures
% QR = 1e10 K/s, SR = 0.0001 1/ps

close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e10/sr0001/Run0/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Hybrid/Data/qr1e10/sr0001/Run1/Data/';

showBanding({Dir1,Dir2},22,[0,11],25,'Hybrid')

%% Alix CuZr Structures, SR = 0.0001 1/ps, nBins = 20

close all

Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr5e11/sr0001/Data/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr1e11/sr0001/Data/';
Dir3 = '~/Google_Drive/Research/LOOKHEREMICHAEL/CuZr/Alix/Data/qr5e10/sr0001/Data/';

showBanding({Dir1,Dir2,Dir3},20,[18,0,10],18,'CuZr')

%% 3DLJ Structures

close all

% showBanding({,'~/Desktop/3DLJ/Data/qr5e4/sr0001/DATA/','~/Desktop/3DLJ/Data/qr1e5/sr0001/DATA/'},0.005,25,[18,18,0],25,'3DLJ')
Dir1 = '~/Google_Drive/Research/LOOKHEREMICHAEL/3DLJ/Data/qr1e4/sr0001/DATA/';
Dir2 = '~/Google_Drive/Research/LOOKHEREMICHAEL/3DLJ/Data/qr5e4/sr0001/DATA/';
Dir3 = '~/Google_Drive/Research/LOOKHEREMICHAEL/3DLJ/Data/qr1e5/sr0001/DATA/';

% Dir2 = ''
% Dir3 = ''

showBanding({Dir1,Dir2,Dir3},22,[18,18,20],22,'3DLJ')

%% 2DLJ QR = 1e4, SR = 0.0005 1/ps, nBins = 50

close all

Dir1 = '/Volumes/HHPC/Research/runs/LJ/2D/qr1e4/run4/sr0005/DATA/MATLAB/';
showBanding({Dir1},50,[25],22,'2DLJ')

%% 2DLJ QR = 1e4, SR = 0.0005 1/ps, nBins = 22

close all

Dir1 = '/Volumes/HHPC/Research/runs/LJ/2D/qr1e4/run4/sr0005/DATA/MATLAB/';
showBanding({Dir1},22,[10],22,'2DLJ')

%% 2DLJ QR = 1e4, SR = 0.0001 1/ps, nBins = 50
close all

Dir1 = '~/Desktop/2DLJ/run4/qr1e4/sr0001/';
Dir2 = '~/Desktop/2DLJ/run4/qr5e4/sr0001/';

% Dir1 = '/Volumes/HHPC/Research/runs/LJ/2D/qr1e4/run4/sr0001/DATA/MATLAB/';
% showBanding({Dir1,Dir2},50,[27,12],22,'2DLJ')
showBanding({Dir1},50,[27],22,'2DLJ')
