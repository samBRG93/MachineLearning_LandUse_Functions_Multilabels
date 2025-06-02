function [O_accuracy] = overal_accuracy()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\libsvm') ; 
addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\myTools');
load('categories_labels.mat');
%load('C:\Users\samuele\Desktop\Image_retrival\imageFeaturesSIFT.mat');

categories = categories ;
O_accuracy(1:length(categories)) = 0 ;

parfor (i=1:length(categories))
    i
    length(categories)
    O_accuracy(i) = svmScript(categories(i),'');   
     
    categories(i)
end

save('Overal2v.mat','O_accuracy') ; 