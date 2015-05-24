function animate(y, T, param)
%% math
% makes animation of all the particles
L = 0.8636;

%% graphics

% set up first frame
figure('Color', 'white');
set(gcf,'Position',[100 678 640 360]);

%% animation sub plot
subplot(1,5,1);

% vertical line
plot([0;0],[0 L],'k'); 

hold on
par = plot(0,y(1,:),'sr','MarkerSize',3,'MarkerFaceColor','r');
hold off

ht = title(sprintf('Time: %0.2f sec', T(1)));
ylim([0 L]); axis 'auto x'; ylabel('Position (m)');

%% the position  sub plot 
subplot(1,5,[2 3 4 5]);

% plot only the displacements i.e. odd columns
pFig = plot(T, y, 'LineWidth', 1);


% n moving markers
mar = line(T(1), y(1,:), 'Marker', '.', 'MarkerSize', 10);
axis([0 T(length(T)) 0 L]);
xlabel('Time (s)'); 
ah = gca;

% get figure size
ahh = gcf;
pos = get(gcf, 'Position');
width = pos(3); height = pos(4);

% preallocate data (for storing frame data)
mov = zeros(height, width, 1, length(T), 'uint8');

%% animation loop

display('Animating...');

% loop through by changing XData and YData
for id = 1:length(T)
    % update graphics data. This is more efficient than recreating plots.
    % convert to cell otherwise the vector-set function doesn't work    
    set(mar, 'XData', T(id), {'YData'}, num2cell(y(id, :))');
    set(par,{'YData'}, num2cell(y(id, :))');
    
    set(ht, 'String', sprintf('%0.2f s, frame(%d)', T(id),id));
    
    % get frame as an image
    f = getframe(ahh);
    
    % create a colormap for the first frame. For the rest of the frames,
    % use the same colormap
    if id == 1
        [mov(:,:,1,id), map] = rgb2ind(f.cdata, 256, 'nodither');
    else
        mov(:,:,1,id) = rgb2ind(f.cdata, map, 'nodither');
    end
end

%% gif

gif_button = uicontrol('Style', 'pushbutton', 'String', 'GIF',...
        'Position', [20 20 50 20],...
        'Callback', {@GIF,param,mov, map});        
% the pushbutton string callback
% calls the gif function to make gif

%% export 

export_button = uicontrol('Style', 'pushbutton', 'String', 'Save',...
        'Position', [20 50 50 20],...
        'Callback', {@newPlot,param,ah});        
% the pushbutton string callback
% calls the ploter and export

if ~exist(fullfile(param.path, 'Analysis'), 'dir')
	mkdir(param.path, 'Analysis')
end


end

function GIF(~,~,param, mov, map) 

gif_fps = param.fps/10; 

outGIF = fullfile(param.path, 'Analysis','Animation.gif');

display('Saving as GIF...');

imwrite(mov, map, outGIF, 'LoopCount', inf, 'DelayTime', 1/gif_fps);

fprintf('GIF saved as:\n "%s"\n', outGIF);

end

function newPlot(~,~,param, gca)

display('Saving...');

outPlot = fullfile(param.path, 'Analysis','TrajectoriesPlot');
set(get(gca,'YLabel'),'String','Position (m)')
set(get(gca,'XLabel'),'String','Time (s)')

export_fig(gca, outPlot, '-pdf','-png','-m2');

fprintf('Plot saved as:\n "%s"\n', outPlot);


end

