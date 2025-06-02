function [] = ExtractAmplitudeFeature()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\myTools');
load('categories_labels.mat');
load('C:\Users\samuele\Desktop\Image_retrival\imageFeaturesSIFT.mat');

%AmplitudeMatrix = zeros(480,2100);
dummy_V = ones(480,1);
N_images = 100;
bias = 0;

for i=1:length(categories)
    
    x = categories(i) 
    
    for k=1:100
        myImage = readImage(x,k-1);
        'stampa'
        AmplitudeMatrix(:,k+bias) = (rgb_magnitude(myImage)');
        AmplitudeMatrix(:,k+bias) =  AmplitudeMatrix(:,k+bias) / sum( AmplitudeMatrix(:,k+bias) ) ;
        %AmplitudeMatrix(:,k+bias) = dummy_V ;
        %AmplitudeMatrix(:,k+bias)
        %k+bias
        
        % O = (rgb_magnitude(bias_image)');
    end
    bias = bias + 100 ; 
    'done with:' 
    categories(i)
    
end

save('RotInvAmplitudeFeature.mat','AmplitudeMatrix');
'done'

end

