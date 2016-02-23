clear; close all;
addpath(genpath('.'));
    
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
% % % Load Test Images

%image_path='1-joie/';
%image_path='test_images/';
%img_list=dir([image_path,'*.png']);
index=0;
for j=1:5
    for i=1:15
        data(index+i).name = strcat(num2str(j),'.',num2str(i),'.png');
        data(index+i).img = im2double(imread(strcat(num2str(j),'.',num2str(i),'.png')));

        % % % Required Only for bbox_method = 2; 
        data(index+i).bbox = []; % Face Detection Bounding Box [x;y;w;h]

        % % % Initialization to store the results
        data(index+i).points = []; % MAT containing 66 Landmark Locations
        data(index+i).pose = []; % POSE information [Pitch;Yaw;Roll]
    end
    index=index+15;
end
%------------------------------------------------%


%------------------------------------------------%
%Run Demo

clm_model='model/DRMF_Model.mat';
load(clm_model);    
data=DRMF(clm_model,data,bbox_method,visualize);    
    
%------------------------------------------------%
for i=1:size(data,2)
    dist = calcKDistance(10,data(i).points);
    datas(i)= struct('points',data(i).points,'dist',dist);
end

save pointsAllK10.mat datas;
disp('DONE');