% Set the variables
load coordinates.mat; % Load datas saved in coordinates.mat
lbls={'joie','degout','tristesse','colere','surprise'};% labels of the emotions that will construct the latent space
iters = 100;% Number of iterations to optimise the datas
getKdist = 0;% 1 to generate the latent space with the K nearest distances and not the coordinates, 0 for the opposite

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);
% Get the emotions datas inside Y after reshapa
N=size(datas,2);
if getKdist
    L=size(datas(1).dist,1);
    C=size(datas(1).dist,2);
    data =zeros(N,L*C);
    for i=1:N
        data(i,:)=reshape(datas(i).dist,L*C,1);
    end
else
    L=size(datas(1).points,1);
    C=size(datas(1).points,2);
    data =zeros(N,L*C);
    for i=1:N
        data(i,:)=reshape(datas(i).points,L*C,1);
    end
end
Y=data;
 
% Set up model
options = fgplvmOptions('ftc');
latentDim = 2;
d = size(Y, 2);

model = fgplvmCreate(latentDim, d, Y, options);
 
% Add dynamics model.
options = gpOptions('ftc');
options.kern = kernCreate(model.X, {'rbf', 'white'});
options.kern.comp{1}.inverseWidth = 0.2;
% This gives signal to noise of 0.1:1e-3 or 100:1.
options.kern.comp{1}.variance = 0.1^2;
options.kern.comp{2}.variance = 1e-3^2;
model = fgplvmAddDynamics(model, 'gp', options);
% Optimise the model.
model = fgplvmOptimise(model, 1, iters);

% Save the generated model that will construct the latent space and the labels.
save model.mat model lbls;% DO NOT change the name "model.mat"