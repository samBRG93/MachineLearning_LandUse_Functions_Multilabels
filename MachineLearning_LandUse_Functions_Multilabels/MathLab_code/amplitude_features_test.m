function [C_features] = amplitude_features()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

myImage = readImage('forest',45);
myImage = myImage(:,:,1);

myImage = double(myImage);
myImage = myImage-mean(myImage(:));
myImage = myImage/std(myImage(:), 0, 1);

band_image_1 = zeros(size(myImage));
band_image_2 = zeros(size(myImage));

filter = zeros(size(myImage));
filter(2:4,2:4) = 1 ;


for i=2:(length(myImage(:,1))-1)
    
    for j=2:(length(myImage(1,:))-1)
        
        filt=myImage( (i-1):(i+1),(j-1):(j+1) );
        arr = [ filt(1,1:3) , filt(2:3,3)' , fliplr(filt(3,1:2)) , filt(2,1) ] ;
        f_arr = abs(fft(arr)) ; 
        band_image_1(i,j) = f_arr(1);
        band_image_2(i,j) = f_arr(2);
        
    end
end

band_image_1(:,1) = [];
band_image_2(:,1) = [];
band_image_1(1,:) = [];
band_image_2(1,:) = [];

band_image_1 = (band_image_1);
band_image_2 = (band_image_2);

F_band_1 = (abs(fftshift(fft2(band_image_1))));
F_band_2 = (abs(fftshift(fft2(band_image_2))));

% parte dei dischi circolari da finire 
%--------------------------
%[rr cc] = meshgrid(1:80);
%C = sqrt((rr-40).^2+(cc-40).^2)<=18;
%C(40,40+18);
%-------------------------

[rr cc] = meshgrid(1:length(band_image_1(1,:)));
C0 = sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= 10 ;
C1 = (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= 18) ;
C = zeros(length(rr),length(rr),11);
C_alias = zeros(length(rr),length(rr),11);
C_band_1 =  zeros(length(rr),length(rr),10); 
C_band_2 =  zeros(length(rr),length(rr),10);

C_features = zeros(1,10*2);
C(:,:,1) = C0;
C(:,:,2) = C1 - C0 ;
C_alias(:,:,1) = C0 ;
C_alias(:,:,2) = C1 ;
C_band_1(:,:,1) = double(C(:,:,2)).*F_band_1 ;
C_band_2(:,:,1) = double(C(:,:,2)).*F_band_2 ;
%pos_1 = ( C_band_1(:,:,1) > 0 ) ;
%pos_2= ( C_band_2(:,:,1) > 0 ) ;
C_alias_B1 = C_band_1(:,:,1);
C_alias_B2 = C_band_2(:,:,1);
C_features(1) = sum(C_alias_B1((C_alias_B1>0))) / length(find(C_band_1(:,:,1)>0)) ;
C_features(2) = sum(C_alias_B2((C_alias_B2>0))) / length(find(C_band_2(:,:,1)>0)) ;




for i=3:11
    i
   
    C(:,:,i) =  (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= (18+3*i) ) ;
    C_alias(:,:,i) =  (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= (18+3*i) ) ;
    C(:,:,i) =  C(:,:,i) -  C_alias(:,:,i-1) ;
    C_band_1(:,:,i-1) = double(C(:,:,i)).*F_band_1 ;
    C_band_2(:,:,i-1) = double(C(:,:,i)).*F_band_2 ;
   
    
    C_alias_B1 = C_band_1(:,:,i-1);
    C_alias_B2 = C_band_2(:,:,i-1);
    
    C_features(2*(i-1)-1) = sum(C_alias_B1(C_alias_B1>0)) / length(find(C_band_1(:,:,i-1)>0));
    C_features(2*(i-1)) = sum(C_alias_B2(C_alias_B2>0)) / length(find(C_band_2(:,:,i-1)>0));
    %C_features(2*i-1) = sum(C_band_1(:,:,i-1)(C_band_1(:,:,i-1)>0)) / (find(C_band_1(:,:,i-1)>0)) ;
    %C_features(2*i) = sum(C_band_2(:,:,i-1)(C_band_2(:,:,i-1)>0)) / (find(C_band_2(:,:,i-1)>0)) ;
 
end



%C = C1 - C0 ;


'done'

end
