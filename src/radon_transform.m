
%I = imread('/home/lord/dip_project/sample_images/overpass36.tif');
%I = imread('/home/lord/dip_project/sample_images/road.png');

function radon_transform(I,mode)
I_1 = imresize(I,[128,128]);
%BW = I_1;
%BW = edge(I_1(:,:,1),'Sobel');
if (mode == true)
    BW = edge(I_1(:,:,1),'Sobel');
      figure,
    subplot(2,2,1);
    imshow(BW);colormap gray
    title('input_image')
else
    BW  =rgb2gray(I_1);
    figure,
    subplot(2,2,1);
    imshow(I_1);colormap gray
    title('input_image')
end



BW = im2double(BW);
rad = discrete_radon(BW,180);
%imshow(im2uint8(rad));
theta = 0:179;
[R,xp] = radon(BW,theta);


subplot(2,2,2); imagesc(rad);colormap(hot);
title("Radon implementation")

subplot(2,2,3); surf(rad);

title("Radon 3D")
%figure;
%title("matlab inbuilt implementation")
%imagesc(R);colormap(hot);


%%%%%%%%%%%%approximation checking %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X_vect = X_back(:,1)';
% X_2d = reshape(X_vect,185,180);
% figure;
% imagesc(X_2d);colormap(hot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Y1,I1] = max(rad(:));
[Y2,I2] = max(R(:));



theta1 = round(I1/size(rad,1));
ro1 = mod(I1,size(rad,1)) 



an = sor(10,rad);


theta2 = round(I2/size(R,1));
ro12 = mod(I2,size(R,1)) ;





%plotline_radon(I_1,ro_d, 180-theta1)
if(theta1>90)
    theta1 = 180-theta1;
    ro_d = abs(ro1- size(rad,1)/2);
    
else 
    theta1  = 180-theta1;
    ro_d = 1.414*(ro1+(size(rad,1)));
end
plotline_radon(I_1,ro_d, theta1)

function R = discrete_radon(I_flat,steps)

%R= zeros(steps,size(I_flat,1));
R= zeros(floor(sqrt(2)*size(I_flat,1))+1,steps);
n = floor(sqrt(2)*size(I_flat,1))+1;
for s =1:steps
   %rotation =  img_rotate(I_flat,s*180/steps);
   rotation =  imrotate(I_flat,-s*180/steps);
   size(rotation);
  
   tmp = size(rotation,1);
   x=floor((n-tmp)/2)+1;
   R(x:x+tmp-1,s) = sum(rotation,2);
   %R(:,s) = sum(rotation,2);
   
end

end




function an = sor(n,R)
    [r,c] = size(R);
    sort = zeros(r*c,2);
    sort(:,1) = R(:);
    sort(:,2) = 1:r*c;
    %sort
    for i = 2:r*c
        if(i > n)
            k =n;
            pos = n+1;
        else
            k = i-1;
            pos = i;
        end
        tmp = sort(i,:);
        for j= k:-1:1
            if(sort(j) < tmp(1))
                sort(j+1,:) = sort(j,:);
                pos = pos-1;
            else
                break
            end
        end
        sort(pos,:) = tmp;
        %sort
    end
    an = zeros(n,3);
    an(:,1) = sort(1:n);
    an(:,2) = mod(sort(1:n,2),r);
    an(:,3) = floor((sort(1:n,2)-1)/r)+1;
    for i=1:n
        if(an(i,2) == 0)
            an(i,2) = r;
        end
    end
end


function transform_img = trasform_2d(T, input_img)

%function perform the 2 D projective transform 

% input_image : gray input image

% T is 3 x 3 trasnform matrix  

%transform_image : output gray transform image

[row,col] = size(input_img);

%transform_img = zeros(floor(sqrt(2)*row)+1,floor(sqrt(2)*col)+1);
transform_img = zeros(363,363);
for i=-row:floor(sqrt(2)*row)-row
for j=-col:floor(sqrt(2)*col)-col

U = inv(T)*[i j 1]';      % where ‘ is transpose

if(U(3)>1)                       % in case of 8 dof projective transform

U(1) = U(1)/U(3); %% taking care homogeneous co ordinate
U(2) = U(2)/U(3);
end

if((U(1)>0)&&(U(1)<row-1)&&(U(2)>0)&&(U(2)<col-1)) %% consider only points                                                                                                                 %which lie inside of input image

transform_img(round(i+row+1),round(j+col+1)) =  input_img(round(U(1)+1),round(U(2)+1));                                       input_img(round(U(1)+1),round(U(2)+1));

end

end
end

end

function rotate_img = img_rotate(input_img,angel)


sc = cosd(angel);
ss = sind(angel);

T = [sc ss 0;-ss sc 0;0 0 1];
rotate_img = trasform_2d(T, input_img);

end

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

