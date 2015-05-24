function [ positionList ] = analyseImgs( imgs, param )
% analyse the input image and outputs the positions of the centroids
% of each particle in the image
%   input:	imgs - full file path + file name of the image
% 			param: the parameters needed i.e. sz, d, etc.
%   output: an array listing the scrambled coordinates and data 
%			of the different particles at different times, such that:
%			positionlist(0:d-1,*): contains the d coordinates and
%			data for all the particles, at the different times. must be positve
%			positionlist(d,*): contains the time t that the position 
%			was determined, must be integers (e.g. frame number.  These values must 
%           be monotonically increasing and uniformly gridded in time.

i = 1;
positionList = [];

for img = imgs'

	color = imread(fullfile(img.path, img.name));
	
	% make sure the code can handle already gray images
	[~, ~, numberOfColorChannels] = size(color);
	if numberOfColorChannels > 1
	  a = rgb2gray(color);
	else
	  a = color; % It's already gray.
	end
	
% 	% for some reason matlab cannot read images properly!!!!
% 	a = 255-a;
	
	b = bpass(a, param.ln, param.d);
	pk = pkfnd(b, param.th, param.sz);  
	cnt = cntrd(b, pk, param.szz);
	positionList = [positionList; create_positionList(cnt,i)];
	i = i + 1;

end

return;

end

