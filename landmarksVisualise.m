function handle = landmarksVisualise(vals)

% LANDMARKSVISUALISE  Helper code for plotting a matrix of facial landmarks during 2-D visualisation.

% MLTOOLS
handle = plot(vals,'.', 'markersize', 8);
view([180 90]);
axis equal;