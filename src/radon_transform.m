I = imread('road2.png');
BW = edge(I(:,:,1),'Sobel');
figure;
imshow(BW);

%I_gray = I(:,:,1);
%I_gray1 = im2double(I_gray);
%I_flat = I_gray1(:);
rad = discrete_radon(BW,180);
%imshow(im2uint8(rad));
theta = 0:179;
[R,xp] = radon(BW,theta);
figure;
imagesc(rad);colormap(hot);
[Y,I] = max(rad(:));
theta = round(I/size(rad,1))
ro = mod(I,size(rad,1)) 


function R = discrete_radon(I_flat,steps)

%R= zeros(steps,size(I_flat,1));
R= zeros(2*size(I_flat,1),steps);
n = 2*size(I_flat,1);
%sie(R)
%{
[N M] = size(I_flat);
m = round(M/2);
n = round(N/2);

rhomax = ceil(sqrt(M^2+N^2));
rc = round(rhomax/2);
mt = max(theta);

res = cast(zeros(rhomax+1,steps),'double');
%}

for s =1:steps
   %rotation =  imrotate(R,-s*180/steps,'crop');
   rotation =  imrotate(I_flat,-s*180/steps);
   size(rotation);
   %R(s,:) = sum(rotation,2);
   tmp = size(rotation,1);
   x=floor((n-tmp)/2)+1;
   R(x:x+tmp-1,s) = sum(rotation,2);
end

end