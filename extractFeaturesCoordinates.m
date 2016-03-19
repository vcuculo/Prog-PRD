% ------------------------------------------------%
% % % 
% % % Choose Face Detector
% % % 0: Tree-Based Face Detector (p204);
% % % 1: Matlab Face Detector (or External Face Detector);
% % % 2: Use Pre-computed Bounding Boxes
% % % 
% % % NOTES:
% % % [a]   Option '0' is very accurate and suited for faces in the 'wild';
% % %       But it is EXTREMELY slow!!!
% % % [b]   Option '1' supports the functionality for incorporating
% % %       YOUR OWN FACE DETECTOR WITH DRMF FITTING;
% % %       Simply modify the function External_Face_Detector.m
% % % 

bbox_method = 1;
%------------------------------------------------%


%------------------------------------------------%
% % % Choose Visualize
% % % 0: Do Not Display Fitting Results;
% % % 1: Display Fitting Results and Pause of Inspection)
% % % 

visualize=0;
%------------------------------------------------%


%------------------------------------------------%
% Load Test Images
% You will have to add the directory with your datas on the Matlab path
% (on Matlab right click/add to path/selected folder)
% By default, the images are named idEmotion.idImage.png

index=0;% Used not to overwrite datas inside the variable data, not to be touched
numberEmotion = 5;% The number of different emotion you will extract the features
numberImages = 15;% The number of images for each emotions
computeNearestDistances = 0; % Specify the number of k nearest distances you want to compute along with the coordonates, 0 not to compute k nearest distances

for j=1:numberEmotion
    for i=1:numberImages
        data(index+i).name = strcat(num2str(j),'.',num2str(i),'.png');
        data(index+i).img = im2double(imread(strcat(num2str(j),'.',num2str(i),'.png')));

        % Required Only for bbox_method = 2; 
        data(index+i).bbox = []; % Face Detection Bounding Box [x;y;w;h]

        % Initialization to store the results
        data(index+i).points = []; % MAT containing 66 Landmark Locations
        data(index+i).pose = []; % POSE information [Pitch;Yaw;Roll]
    end
    index=index+numberImages;
end
%------------------------------------------------%

clm_model='model/DRMF_Model.mat';
load(clm_model);    
data=DRMF(clm_model,data,bbox_method,visualize);    
    
%------------------------------------------------%


%------------------------------------------------%
% Get the K nearest distances for each points
for i=1:size(data,2)
    dist = [];
    if computeNearestDistances ~= 0
        dist = calcKDistance(computeNearestDistances,data(i).points);
    end
    datas(i)= struct('points',data(i).points,'dist',dist);
end

save coordinates.mat datas;
disp('DONE');