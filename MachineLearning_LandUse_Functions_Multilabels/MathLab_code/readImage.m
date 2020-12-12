function [ imageMatrix ] = readImage( category,image )
%READIMAGE Reads image from original dataset folder and returns matrix
%
%   category: name of the image category as a string
%   image: index of image within category
%
%   e.g. myImage = readImage('forest',45);

[slash,splitter] = OSCompatibility();

addpath('myTools');

load(['myTools',slash,'categories_labels.mat'],'categories');
mainAddress = ['myTools',slash,'\UCMerced_LandUse',slash,'Images']; %i.e. 'UCMerced_LandUse\Images'
imgType = '*.tif';

% Gets paths for all image categories (i.e. subfolders)
[classPaths,~] = getClassPaths(mainAddress);
% Determines category index
classIndex = find(strcmp(categories,category));
if isempty(classIndex)
    error('Category name not valid. Please check spelling.')
end

% Gets addresses of all images from dataset and chooses the relevant one
[imagesFromClass,~] = getImages(classPaths{classIndex},imgType);
imageMatrix = imread(imagesFromClass{image+1});
%imshow(imageMatrix);

end

