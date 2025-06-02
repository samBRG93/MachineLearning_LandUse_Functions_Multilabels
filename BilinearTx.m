function [OutI] = BilinearTx(myImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%I = readImage('tenniscourt',01);
%R = 1 ;

%myImage = I(1:14,1:14,1);
I = myImage ;

lato = [3,5,7,8,9,10,11,12];
lato = lato + 2 ;
R = find(lato == length(myImage)) ;
SE = 2 ; 

N_total = [8,16,24:4:44];
Radius = ones(1,length(N_total));

N = N_total(R);
ang = 2*pi/N;
pointsRelativeLocation=zeros(N,2);

% 2,35619 per partire da 135 gradi
%StartAng = double((N/4-1)*ang);
StartAng = double(pi/2+ang*(floor((N/4+1)/2)));
%StartAng = double(2.35619)
for i = 1:N
        pointsRelativeLocation(i,1) = R*sin(-(i-1)*ang + StartAng);
        pointsRelativeLocation(i,2) = R*cos(-(i-1)*ang + StartAng);  
        fy(i) = floor(pointsRelativeLocation(i,1)); cy(i) = ceil(pointsRelativeLocation(i,1)); ry(i) = round(pointsRelativeLocation(i,1));
        fx(i) = floor(pointsRelativeLocation(i,2)); cx(i) = ceil(pointsRelativeLocation(i,2)); rx(i) = round(pointsRelativeLocation(i,2));
end

% per tutti i punti valuto il loro valore interpolato
%a1 = myImage(SE,2:(length(myImage)-1))
%a2 = myImage(3:(length(myImage)-1),c
%a3 = fliplr(myImage(length(myImage)-1,SE:(length(myImage)-2)))
%a4 = fliplr(myImage(SE+1:(length(myImage)-2),SE)')
coordinate=zeros(2,N);

% due sulle coordinate x mentre uno su quelle y 
coordinate(2,:) = [2:(length(myImage)-1),repmat(length(myImage)-1,1,length(2:(length(myImage)-2))),fliplr(SE:(length(myImage)-2)),repmat(SE,1,length((SE+1:(length(myImage)-2))'))];
coordinate(1,:) = [repmat(SE,1,length(2:(length(myImage)-1))),(SE+1):(length(myImage)-1),repmat((length(myImage)-1),1,length(SE:(length(myImage)-2))),SE+1:(length(myImage)-2)];

for i=1:N
    if (~((abs(pointsRelativeLocation(i,2) - rx(i)) < 1e-5) && (abs(pointsRelativeLocation(i,1) - ry(i)) < 1e-5)))
       
     
        
        if (pointsRelativeLocation(i,1) > 0) 
            w2 = pointsRelativeLocation(i,1) - floor(pointsRelativeLocation(i,1));
        else
            w2 = 1-abs(pointsRelativeLocation(i,1) - floor(pointsRelativeLocation(i,1)));
        end
        
        if (pointsRelativeLocation(i,2) > 0) 
            w1 = pointsRelativeLocation(i,2) - floor(pointsRelativeLocation(i,2));
        else
            w1 = 1-abs( pointsRelativeLocation(i,2) - floor(pointsRelativeLocation(i,2)));
        end
        w4 = 1 - w2;
        w3 = 1 - w1;
        w1 = w1/2 ; 
        w2 = w2/2 ; 
        w3 = w3/2 ; 
        w4 = w4/2 ; 
      
        myImage(coordinate(1,i),coordinate(2,i)) = w1*I(coordinate(1,i)+1,coordinate(2,i)) + w2*I(coordinate(1,i),coordinate(2,i)+1) + w3*I(coordinate(1,i)-1,coordinate(2,i)) + w4*I(coordinate(1,i),coordinate(2,i)-1);    
    end
end


 OutI = myImage(2:(end-1),2:(end-1));

%  pointsRelativeLocation(i,1) = -R*sin((i-1)*ang);
%  pointsRelativeLocation(i,2) = R*cos((i-1)*ang);
%  pointsRelativeLocation=zeros(N,2);
%  ang = 2*pi/N


end

