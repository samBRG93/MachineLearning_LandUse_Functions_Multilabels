function [ index ] = imageIndex( category, image )
%IMAGEINDEX Returns the the index of the image within the whole archive
%
%   category: name of the image category as a string
%   image: index of image within category (ranges from 0 to 100)
%
%   output index ranges from 1 to 2100

[slash,~] = OSCompatibility();

addpath('myTools');
load(['myTools',slash,'categories_labels.mat'],'categories');

% Gets index of first image from category (i.e. 1 for agricultural, 101 for airplane etc.)
index0 = getClassIndex(categories,category);
index = image+index0;

end

