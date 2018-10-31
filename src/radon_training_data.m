clear ; close all; clc

myPath= '/home/lord/image_processing/data_set/data/';

a=dir(fullfile(myPath,'*.tif'));
fileNames={a.name};


I_flat = []
radon_flat = []
for count = 1:length(fileNames) %

fileName = strcat(myPath,fileNames(count));  
img = imread(fileName{1});
img1 = imresize(img,[128,128]);

img_gray = rgb2gray(img1);
BW1 = edge(img_gray,'Sobel');
BW2 = BW1';
BW3 = BW2';
BW4 = BW3';
%imshow(BW4)
theta = 0:179;
% apply radon transform 
[R1,xp] = radon(BW1,theta);
[R2,xp] = radon(BW2,theta);
[R3,xp] = radon(BW3,theta);
[R4,xp] = radon(BW4,theta);
BW = [BW1(:)';BW2(:)';BW3(:)';BW4(:)'];
BW = double(BW);
R = [R1(:)';R2(:)';R3(:)';R4(:)'];
%save the data for training 
I_flat = [I_flat;BW];
radon_flat = [radon_flat;R];
end