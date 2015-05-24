% main file for calling all functions
% puts output in a folder next to the input files

clear all
clc

% add all subfolders of the current folder into the search path
% so we can better organize
addpath(genpath(fullfile(pwd,'lib')));

% select input folder that contain the image sequence
% put these imgs into the looping variable
% also get path of the data directory for outputs
display('Select data for input. Note: images should be horizontal')
[imgs, dataPath] = importImgs('*.png');

display('Working...');

% check for cumston config file
customConfig = fullfile(dataPath, 'config.m');
if exist(customConfig,'file')
	% parameter file already exists
	% import it here
	run(customConfig);
else
	% parameter file doesn't exist
	% manually input parameters in default_config and run it here
	default_config;
end 

param.path = dataPath;

% use funciton to create trackable vector
positionList = analyseImgs(imgs, param);

% create result of tracked trajectories
result = track(positionList, param.maxdisp, param);

% export the default config file to the data directory
% once the operation is successful
if ~exist(customConfig, 'file')
	copyfile('default_config.m', customConfig)
end

% track.m automatically parses how many particles there are, find it
nParticles = max(result(:,4));

% rearrange the data for each particle
for i=1:nParticles
    tr = trajectory(result,i,param);
	tr = convert.pixelsToMeters(tr, param.pxperm);
    for j=1:size(tr,2)
        data.y(j,i) = tr(j);
    end
end

% automatically find how many frames there are
param.nFrames = length(data.y);

data.t = linspace(0, param.nFrames/param.fps, param.nFrames);

disp('Done!');

%% animate

% call animate function with confirmation dialog
if chooseDiag ('Success! Would you like to see the results?')
	animate(data.y, data.t, param)
end
