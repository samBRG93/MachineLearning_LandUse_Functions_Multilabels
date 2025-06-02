function [accuracy] = svmScript (class,string)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\libsvm') ; 
addpath('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\myTools');
load('categories_labels.mat');
%load('C:\Users\samuele\Desktop\Image_retrival\imageFeaturesSIFT.mat');
% se voglio computare le alttr feature
load('C:\Users\samuele\Desktop\Image_retrival\LandUse_Functions_Multilabels\RotInvAmplitudeFeature.mat');
imageFeatures = AmplitudeMatrix ;

%Total = 100;
%N_class = 10;
%N_other = 200;
%N_test = 90 ; 
N_Images_xclass = 100 ; %numero totale di immagini per classe
N_class = 45 ; % training sample relativi alla classe 1
N_part = 45;%round(N_class/2);
%----------------------
% set 1 ----> 80 training samples i training dati al cross validator :
% funziona abbstanzana bene -----> configurazione 1
%----------------------
N_other = (length(categories)-1)*N_class; %altre immagini del test relative alla classe 0
N_test = N_Images_xclass - N_class ; % quelle rimanenti vengono usate per il test 
step = N_test ;
%r = randi([1 99],1,N_class); % ten random images taked from the 100 of one class
r = randperm(100,N_class); 
%r =1:N_class;
IndexTrain = r - 1 + getClassIndex(categories,class); %minus 1 because class index start to 1 

TrainData = zeros(N_class + N_other,length(imageFeatures(:,1)));
TestData = zeros(N_test*length(categories),length(imageFeatures(:,1)));
ValidationData= zeros(length(categories)*N_part,length(imageFeatures(:,1))) ;

TrainLabels(1:(N_class+N_other)) = 0;
TestLabels(1:(N_test*length(categories))) = 0;
ValidationLabels(1:length(categories)*N_part) = 0;

counter = 1:length(categories);
counter = (counter-1)*100 + 1;
posi =  ismember(categories,class) ; 
pos = ~(posi) ;
pos = (find(pos==1));
position_labels = pos;
pos = pos*100 - 99 ;
pos = pos' ;

references = 1:100; %because is the rigth version for cut the r components
references(r) = [] ; 

%parte dubbia sugli indici
%----------------------
%TestData((1:N_test),:) = (imageFeatures(:,references))' ;  % più uno perchè è coe se appartenessa alla pima classe 
%TrainData(1:N_class,:) = imageFeatures(:,IndexTrain)' ;
%----------------------

%TestLabeles = zeros(1890,1);
[true,position_TL] = ismember(class,categories); 
position_Test_L = (position_TL-1)*step+1;  % poizione della classe nel TestLabels
position_Train_L = (position_TL-1)*N_class+1;
position_labels = (position_labels-1)*step+1;
position_validation_L = (position_TL-1)*(N_part)+1;

TrainLabels(position_Train_L : position_Train_L+N_class-1) = 1 ;
TestLabels(position_Test_L : position_Test_L+step-1) = 1; 
ValidationLabels(position_validation_L:position_validation_L+N_part-1) = 1 ; 

for i=1:length(counter)
    IndexTrain = r + counter(i) -1; % minus 1 because you start ti count to zero in this case 
    IndexTest = references + counter(i) -1;
    IndexTest_Array((i-1)*length(IndexTest)+1:(i)*length(IndexTest)) = IndexTest ; 
    TrainData(((i-1)*N_class+1):(i)*N_class,:) = (imageFeatures(:,IndexTrain))' ;
    TestData(((i-1)*N_test+1):(i)*N_test,:) = (imageFeatures(:,IndexTest))' ; 
    ValidationData(((i-1)*N_part+1):(i)*N_part,:) = (imageFeatures(:,IndexTrain(1:N_part))') ; 
end

TestLabels = TestLabels';
TrainLabels = TrainLabels';
ValidationLabels = ValidationLabels';

'SVM MODEL'

'cross validation parameters'
[parameters]=Cross_ValidationRBF(ValidationData,ValidationLabels');

'svm model'
SVM_Model = svmtrain(TrainLabels,TrainData,parameters);
%SVM_Model = svmtrain(ValidationData,ValidationLabels,parameters);

'svmpredict'
[predict_label,accuracy,distancetohyperplane]=svmpredict(TestLabels,TestData,SVM_Model);


table(TestLabels(1:end),predict_label(1:end),distancetohyperplane,'VariableNames',...
{'TrueLabel','PredictedLabel','distancetohyperplane'})

if(strcmp(string,'show'))
    sorted_images = [distancetohyperplane,(1:length(distancetohyperplane))'];
    sorted_images = sortrows(sorted_images);
    
    if (strcmp(class,'agricultural'))
         sorted_images = flipud(sorted_images);
    end
    
    n_images_selected = 4 ; 
    plot_index = IndexTest_Array(sorted_images(1:n_images_selected*n_images_selected,2));
    class_pos = floor((plot_index -1)/100) +1 ; 
    
    for i=1:n_images_selected*n_images_selected
        dist = num2str(sorted_images(i,1));
        subplot(n_images_selected,n_images_selected,i); subimage(readImage(categories(class_pos(i)),plot_index(i)-((class_pos(i)-1)*100)-1 )); title(dist);
    end
end

    
pos_predict = find(predict_label == 1) ; 
accuracy = (sum(TestLabels(pos_predict))) / length(pos_predict) ;
%sorted_images(:,1)

'done'
%-------------
% data=double
%group=bool
%-------------


end

