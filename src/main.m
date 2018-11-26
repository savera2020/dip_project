clear ; close all; clc

myPath= '/home/lord/dip_project/sample_images/';
load('/home/lord/weight.mat')
a=dir(fullfile(myPath,'*.tif'));
fileNames={a.name};


I_flat = []
radon_flat = []
for count = 1:length(fileNames) %

fileName = strcat(myPath,fileNames(count));  
img = imread(fileName{1});
img1 = imresize(img,[64,64]);

radon_transform(img1,true)
radon_transform(img1,false)
radon_approximation_test(img1,weight)
end