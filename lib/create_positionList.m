function [ positionList ] = create_positionList( cnt, index )
% create positionlist vector by appending data to the end
% for track.m

positionList(:,1) = cnt(:,2);     % x-coordinate
positionList(:,2) = cnt(:,1);     % y-coordinate
positionList(1:size(cnt,1),3) = index;      % frame number

return;

end

