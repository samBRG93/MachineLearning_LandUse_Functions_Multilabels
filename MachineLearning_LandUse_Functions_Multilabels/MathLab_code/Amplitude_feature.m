function [feature_vector] = Amplitude_feature(myImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

myImage = readImage('forest',45);
myImage = myImage(:,:,1);

myImage = double(myImage);
myImage = myImage-mean(myImage(:));
myImage = myImage/std(myImage(:), 0, 1);

[band_image_1,band_image_2] = Local_Functions(myImage);

% local disk filter creation
[rr cc] = meshgrid(1:length(band_image_1(1,:,1)));
C0 = sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= 10 ;
C1 = (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= 18) ;
C = zeros(length(rr),length(rr),11);
C_alias = zeros(length(rr),length(rr),11);
C_band_1 =  zeros(length(rr),length(rr),10,8); 
C_band_2 =  zeros(length(rr),length(rr),10,8);
C_features = zeros(1,10*2*8);
C(:,:,1) = C0;
C(:,:,2) = C1 - C0 ;
C_alias(:,:,1) = C0 ;
C_alias(:,:,2) = C1 ;

for k=1:8
    
    %lfd_circular_norm = lfd_circular_norm./repmat(sum(lfd_circular_norm,1),size(lfd_circular_norm,1),1);
    C_band_1(:,:,1,k) = double(C(:,:,2)).*band_image_1(:,:,k) ;
    C_band_2(:,:,1,k) = double(C(:,:,2)).*band_image_2(:,:,k) ;
    C_alias_B1 = C_band_1(:,:,1,k);
    C_alias_B2 = C_band_2(:,:,1,k);
    
    %C_features(2*(k-1)+1) = sum(C_alias_B1((C_alias_B1>0))) / length(find(C_band_1(:,:,1)>0)) ;
    %C_features(2*k) = sum(C_alias_B2((C_alias_B2>0))) / length(find(C_band_2(:,:,1)>0)) ;
    % different type of insert
    feature_vector_1(k) = sum(C_alias_B1((C_alias_B1>0))) / length(find(C_band_1(:,:,1)>0)) ;
    feature_vector_2(k) = sum(C_alias_B2((C_alias_B2>0))) / length(find(C_band_2(:,:,1)>0)) ;
end
 Start_index = 2*(k) ;
 ST_index = k ;
 %C_features
 
for k=1:8
    for i=3:11
        
        if k==1
            C(:,:,i) =  (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= (18+3*i) ) ;
            C_alias(:,:,i) =  (sqrt( (rr-floor(length(rr)/2)).^2+ (cc-floor(length(rr)/2)).^2 )<= (18+3*i) ) ;
            C(:,:,i) =  C(:,:,i) -  C_alias(:,:,i-1) ;
        end
        
        C_band_1(:,:,i-1) = double(C(:,:,i)).*band_image_1(:,:,k) ;
        C_band_2(:,:,i-1) = double(C(:,:,i)).*band_image_2(:,:,k) ;
  
        C_alias_B1 = C_band_1(:,:,i-1);
        C_alias_B2 = C_band_2(:,:,i-1);
    
        %C_features( Start_index +1 ) = sum(C_alias_B1(C_alias_B1>0)) / length(find(C_band_1(:,:,i-1)>0)); % +2*(i-3)
        %C_features(Start_index + 2 ) = sum(C_alias_B2(C_alias_B2>0)) / length(find(C_band_2(:,:,i-1)>0)); %2*(i-2)
        % different type of insert
        feature_vector_1(ST_index +1 ) = sum(C_alias_B1(C_alias_B1>0)) / length(find(C_band_1(:,:,i-1)>0)); 
        feature_vector_2(ST_index + 1 ) = sum(C_alias_B2(C_alias_B2>0)) / length(find(C_band_2(:,:,i-1)>0));
        
        ST_index = ST_index + 1 ;
        Start_index = Start_index + 2;  
    end
end

feature_vector=[feature_vector_1,feature_vector_2] ; 

'done'

end