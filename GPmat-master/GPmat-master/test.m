% Fichier test Fgplvm

% FGPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'allpoint';
experimentNo = 1;
% [Y, lbls] = lvmLoadData(dataSetName);
% 
% % Set up model
% options = fgplvmOptions('ftc');
% latentDim = 2;
% d = size(Y, 2);
% 
% model = fgplvmCreate(latentDim, d, Y, options);
% 
% % Add dynamics model.
% options = gpOptions('ftc');
% options.kern = kernCreate(model.X, {'rbf', 'white'});
% options.kern.comp{1}.inverseWidth = 0.2;
% % This gives signal to noise of 0.1:1e-3 or 100:1.
% options.kern.comp{1}.variance = 0.1^2;
% options.kern.comp{2}.variance = 1e-3^2;
% model = fgplvmAddDynamics(model, 'gp', options);
% % Optimise the model.
% iters = 100;
% display = 1;
% 
% model = fgplvmOptimise(model, display, iters);
% 
% % Save the results.
% modelWriteResult(model, dataSetName, experimentNo);
% save model.mat model;
% 
% if exist('printDiagram') & printDiagram
%   lvmPrintPlot(model, lbls, dataSetName, experimentNo);
% end

%plot(modelTest.X(:, 1), modelTest.X(:, 2), '^-', 'linewidth',1)

% Load the results and display dynamically.
load model.mat;
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'vector');
