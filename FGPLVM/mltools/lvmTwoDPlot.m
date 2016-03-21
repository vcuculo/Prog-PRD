function [returnVal, txtReturnVal] = lvmTwoDPlot(X, lbl, symbol, doTest, Y, fhandle)

% LVMTWODPLOT Helper function for plotting the labels in 2-D.
% FORMAT
% DESC helper function for plotting an embedding in 2-D with symbols.
% ARG X : the data to plot.
% ARG lbl : the labels of the data point.
% ARG symbol : the symbols to use for the different labels.
%
% SEEALSO : lvmScatterPlot, lvmVisualise
%
% COPYRIGHT : Neil D. Lawrence, 2004, 2005, 2006, 2008

% MLTOOLS

if nargin < 2
    lbl = [];
end
if(strcmp(lbl, 'connect'))
    connect = true;
    lbl = [];
else
    connect = false;
end

if iscell(lbl)
    labelsString = true;
else
    labelsString = false;
end

if nargin < 3 || isempty(symbol)
    if isempty(lbl)
        symbol = getSymbols(1);
    else
        symbol = getSymbols(size(lbl,2));
    end
end
if nargin > 5 && ~isempty(fhandle)
    axisHand = fhandle;
else
    axisHand = gca;
end
returnVal = [];
textReturnVal = [];
nextPlot = get(axisHand, 'nextplot');
labelNo=1;
deb=1;
for i = 1:(size(X, 1)/15)
    returnVal = [returnVal; plot(X(deb:15*i, 1), X(deb:15*i, 2), symbol{labelNo}, 'linewidth',1)];
    if labelsString
        textReturnVal = [textReturnVal; text(X(15*i, 1), X(15*i, 2), ['   ' lbl{i}])];
    end
    labelNo = labelNo+1;
    deb=(15*i)+1;
end

if doTest==1
%     dataSetNameTest = 'testpoint';
%     [Y, lbls] = lvmLoadData(dataSetNameTest);
    load model.mat; % load the learned model corresponding to the latent space
    iters=100;
    display=1;
    Xtest = zeros(size(Y, 1),2);
    for i=1:size(Xtest, 1)
        initXPos = getNearestValue(model.y, Y(i,:));
        Xtest(i,:) = fgplvmOptimisePoint(model, model.X(initXPos,:), Y(i,:), display, iters);
    end
    returnVal = [returnVal; plot(Xtest(:, 1), Xtest(:, 2), '^-', 'linewidth',1)];
end

set(axisHand, 'nextplot', nextPlot);
set(returnVal, 'markersize', 10);
set(returnVal, 'linewidth', 2);
end

function initXPos = getNearestValue(Ymodel, Y)
    ytemp = 0;
    dist = Inf(1);
    for i=1:size(Ymodel,1)
        D = sqrt(sum((Ymodel(i,:) - Y) .^ 2));
        if(D < dist)
            dist = D;
            ytemp = i;
        end
    end
    initXPos = ytemp;
end
