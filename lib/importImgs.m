function [ imgs, imgPath ] = importImgs( imgType )
%import some images into a looping variable
% input: file type
% output: struct array with name and path as fields

% ask user for data directory and store into variable
imgPath = uigetdir(pwd,'Select folder containing image sequence');

% put the images into a struct array for processing
imgs = dir(fullfile(imgPath, imgType));

% remove unneccessary fields
fields = {'date','bytes', 'isdir', 'datenum'};
imgs = rmfield(imgs, fields);

% add a new field containing the data directory
[imgs.path] = deal(imgPath);

return;

end

