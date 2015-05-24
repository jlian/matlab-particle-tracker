% parameter structure for particle tracking
% 	color = imread(fullfile(img.path, img.name));
% 	a = rgb2gray(color);
% 	b = bpass(a, param.ln, param.d);
% 	pk = pkfnd(b, param.th, param.sz);  
% 	cnt = cntrd(b, pk, param.szz);

% param = struct;

param.fps = 600; % frames per second with which the footage was captured

% image analysis parameters
param.ln = 1;	% characteristic lengthscale of noise in pixels.
param.d = 10;   % diameter of blobs 
param.th = 40;  % threshhold
param.sz = 11;  % set to be slighly larger than diameter of particle
param.szz = param.sz + 2; % for cnt

% particle tracking parameters
param.mem = 10;    % number of times steps that a particle can be lost for
param.dim = 2;     % default is 2
param.good = 10;   % eliminates trajectories with less than this many positions
param.quiet = 1;   % default is 1
param.maxdisp = 20;     % max number of pixels a particle would move in one time interval

param.pxperm = 0.8636/432;