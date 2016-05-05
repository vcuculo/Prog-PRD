function handle = landmarksModify(handle, values)

% LANDMARKSMODIFY Helper code for visualisation of facial landmarks data.

% MLTOOLS
values = reshape(values,[66,2]);
set(handle, 'XData', values(:,1));
set(handle, 'YData', values(:,2)');
