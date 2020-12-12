function out = checkLabels( category, image )
%CHECKLABELS Displays labels of image
%   category: name of the original image category as a string
%   image: index of image within category
%
%   E.g. checkLabels('buildings',48) would return the label

[slash,~] = OSCompatibility();

addpath('myTools');
load(['multilabeledData',slash,'LandUse_multilabels.mat'],'labels');
load(['myTools',slash,'categories_labels.mat'],'newLabels');

% Gets image index within archive (ranging from 1 to 2100)
index = imageIndex(category,image);
imageLabels = newLabels(labels(:,index));



%for i = 1:length(imageLabels);
%    disp(imageLabels{i});
%end


%for i=1:length(imageLabels)
 % if you want to show the labeles   
%end


out = imageLabels ; 

end

