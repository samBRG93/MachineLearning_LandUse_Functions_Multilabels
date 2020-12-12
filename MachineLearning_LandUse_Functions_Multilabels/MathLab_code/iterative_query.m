function [ ] = iterative_query()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\myTools');
load('categories_labels.mat');
load('C:\Users\samuele\Desktop\Image_retrival\imageFeaturesSIFT.mat');
vector = zeros(1,length(imageFeatures));
imageFeatures = imageFeatures ;

parfor index= 1:length(imageFeatures)
    vector(index) = generic_multilabeled(index,'') ;
end

value = (sum(vector(:))) / (length(vector));
stem(value);