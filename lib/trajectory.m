function [ tr_new ] = trajectory( result, partID, param )

nframes = max(result(:,3));

% size of nParticles*nFrames
sz = length(result);

% this should be the same as param.mem in TestTrack.m
thr = param.mem;

tr = zeros(1,nframes);

for i=1:sz   
    if result(i,4) == partID && result(i,3) ~= 0
        tr(result(i,3)) = result(i,2);
    end
end

% change all zero values to nonvalues
% because zero values are wrong
tr(tr==0) = nan;

% the follow inserts values using interp1 for NaN values:

% first of all, find the positions and lengths of all 
% sequences of NaN values
nan_idx = isnan(tr(:))';
nan_start = strfind([0, nan_idx], [0 1]);
nan_len = strfind([nan_idx, 0], [1 0]) - nan_start + 1;

% next, find the indices of the NaN elements not to interpolate using thr
nan_start = nan_start(nan_len > thr);
nan_end = nan_start + nan_len(nan_len > thr) - 1;
idx = cell2mat(arrayfun(@colon, nan_start, nan_end, 'UniformOutput', false));

% now, interpolate everything and replace the elements that 
% shouldn't have been interpolated back with NaN values:
tr_new = interp1(find(~nan_idx), tr(~nan_idx), 1:numel(tr));
tr_new(idx) = NaN;

return 

end

