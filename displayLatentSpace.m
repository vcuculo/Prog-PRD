load pointsTest.mat;% Load the datas for the tested emotion
getKDist = 0;%1 to use the K nearest distances and not the coordinates, 0 for the opposite

N=size(datas,2); 
if getKDist ==1
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

% Visualize the latent space with the test datas, represented by light blue
% triangles
lvmVisualise(model, lbls, Y, ['vector' 'Visualise'], ['vector' 'Modify']);