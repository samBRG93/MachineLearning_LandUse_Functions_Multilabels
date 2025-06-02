function [AmplitudeVector] = rgb_magnitude(myImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%AmplitudeMatrix = zeros(3,160);

parfor i=1:3
    X = (myImage(:,:,i)) ;
    Amplitude_Matrix(i,:) = Amplitude_feature(myImage(:,:,i)) ;
end

AmplitudeVector = [ Amplitude_Matrix(1,:) , Amplitude_Matrix(2,:) , Amplitude_Matrix(3,:) ] ; 

'done rgb Magnitude'




end

