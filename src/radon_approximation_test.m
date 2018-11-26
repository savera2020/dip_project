% X_vect = X_back(:,1)';
% X_2d = reshape(X_vect,95,180);
% figure;
% imagesc(X_2d);colormap(hot);
%img = imread('/home/lord/dip_project/sample_images/overpass36.tif');
function radon_approximation_test(img,weight)


img1 = imresize(img,[64,64]);

figure,
subplot(2,2,1);
imshow(img1)
title('input image')

img_gray = rgb2gray(img1);
BW1 = edge(img_gray,'Sobel');
I_flat = BW1(:)';
Y = I_flat'; 
X_vect = weight*Y(:,1);
X_2d = reshape(X_vect,95,180);


[Y1,I1] = max(X_2d(:));

theta1 = round(I1/size(X_2d,1));
ro1 = mod(I1,size(X_2d,1)) ;
theta1 = theta1+89;

theta1
ro1
rad = X_2d;



subplot(2,2,2);
imagesc(X_2d);colormap(hot);
title('radon apporximation')
subplot(2,2,3)
surf(X_2d)
title('radon 3 D')


%plotline_radon(I_1,ro_d, 180-theta1)
if(theta1>90)
    theta1 = 180-theta1;
    ro_d = abs(ro1- size(rad,1)/2);
    
else 
    theta1  = 180-theta1;
    ro_d = 1.414*(ro1+(size(rad,1)));
end
plotline_radon(img1,ro_d, theta1)



function plotline_radon(img,ro, theta)

%[height,width,channel] = size(img)

%Y = (-cos(theta)/sin(theta))X + ro/sin(theta) 
%imshow(img); %// Show the image
%hold on; %// Hold so we can draw lines
 %// or numel(theta);

%// These are constant and never change
for X = 1:128
    
    %X = size(img,1) -width
    
    Y = round((tand(theta))*X + ro/sqrt(2));
    
    if(Y>1)&&(Y<size(img,1)-1) && (X>1)&&(X<size(img,2)-1) 
    img(Y-1:Y+1,X-1:X+1,1) = 255;
    img(Y-1:Y+1,X-1:X+1,2) = 0;
    img(Y-1:Y+1,X-1:X+1,3) = 0;
    
    end
end
subplot(2,2,4);
imshow(img)
title('ploted line')
%imwrite(img,'/home/lord/dip_project/result/overpass36.tif')
end

end

