function [ images ] = readDataset( )
%READDATASET Reads entire dataset and saves as a cell matrix

[slash,~] = OSCompatibility();

addpath('myTools');

mainAddress = ['myTools',slash,'UCMerced_LandUse',slash,'Images']; %i.e. 'UCMerced_LandUse\Images'
imgType = '*.tif';

% Gets paths for all image categories (i.e. subfolders)
[classPaths,~] = getClassPaths(mainAddress);

images = cell(21,100);

for classIndex = 1:21
    % Gets image addresses for all images within category
    [imagesFromClass,~] = getImages(classPaths{classIndex},imgType);
    for image = 0:99
        % Individually reads each image
        images{classIndex,image+1} = imread(imagesFromClass{image+1});
    end
end

save('LandUse_images.mat','images');

end

