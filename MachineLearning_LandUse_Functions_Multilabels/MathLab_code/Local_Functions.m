function [band_image_1,band_image_2] = Local_Functions(myImage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%myImage = readImage('forest',45);
%myImage = myImage(:,:,1);

myImage = double(myImage);
myImage = myImage-mean(myImage(:));
myImage = myImage/std(myImage(:), 0, 1);

C_point = 9;
Radius = 8;
 
filt=zeros(17,17);
band_image_1 = zeros((length(myImage)-Radius),(length(myImage)-Radius),8);
band_image_2 = zeros((length(myImage)-Radius),(length(myImage)-Radius),8);
filt=zeros(17,17);
arr = zeros(1,44);
filt(:,:) = 0 ;

for i=(Radius+1):((length(myImage(:,1))-Radius-1))
    
    for j=(Radius+1):((length(myImage(1,:))-Radius-1))
        arr(:) = 0;
       
        % Local functions for each radius
        for k=1:(Radius-5)
          
           filt(:,:) = 0 ;
           %filt(1:length((i-k):(i+k)),1:length((j-k):(j+k))) = myImage((i-k):(i+k),(j-k):(j+k));
           filt(1:length((i-k):(i+k)),1:length((j-k):(j+k))) = BilinearTx(myImage((i-k-1):(i+k+1),(j-k-1):(j+k+1)));
           arr = [filt(1,1:length((i-k):(i+k))),filt(2:length((i-k):(i+k)),length((j-k):(j+k)))',fliplr(filt(length((i-k):(i+k)),1:length((i-k):(i+k)-1))),fliplr(filt(2:(length((i-k):(i+k))-1),1)')];
           f_arr = abs(fft(arr)) ;  
           band_image_1(i,j,k) = f_arr(1);
           band_image_2(i,j,k) = f_arr(2);
           
        end
        
        %BilinearTx(myImage((i-k+1):(i+k+2),(j-k+1):(j+k)));
        start_windowX = ((i-3):(i+3)) ;
        start_windowY = ((j-3):(j+3)) ;
       
        for k=Radius-4 : (Radius)
            filt(:,:) = 0 ;    
            if (~mod(k,2))
                
                posX = [start_windowX,((start_windowX(end)+1):(start_windowX(end)+1))] ;
                posY = [start_windowY,((start_windowY(end)+1):(start_windowY(end)+1))] ;
            
                %size(myImage([posX(1)-1,posX,posX(end)+1],[posY(1)-1,posY,posY(end)+1]))
                filt(1:length(posX),1:length(posY)) = BilinearTx(myImage([posX(1)-1,posX,posX(end)+1],[posY(1)-1,posY,posY(end)+1])) ;
                
            else 
               posX =  [((start_windowX(1)-1):(start_windowX(1)-1)),start_windowX] ;
               posY =  [((start_windowY(1)-1):(start_windowY(1)-1)),start_windowY] ;
             
               filt(1:length(posX),1:length(posY)) = BilinearTx(myImage([posX(1)-1,posX,posX(end)+1],[posY(1)-1,posY,posY(end)+1])) ;
               %filt(1:length(posX),1:length(posY)) = myImage(posX,posY);
              
           end
           
           L = 1:length(posX) ;  % le  grandezze  X Y DEVONO ESSERE UGUALI
           arr=[filt(1,L),filt(2:length(L),length(L))',fliplr(filt(length(L),1:(length(L)-1))),fliplr(filt(2:(length(L)-1),1)')];
           f_arr = abs(fft(arr)) ;  
           band_image_1(i,j,k) = f_arr(1);
           band_image_2(i,j,k) = f_arr(2);
           
           start_windowX = posX ;
           start_windowY = posY ;
           %length(arr)
           %pause();
        end
          
    end

end
'done'
end