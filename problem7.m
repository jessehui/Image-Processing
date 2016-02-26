clear all;
clc 

img = imread('Image.bmp');
figure 
imshow(img)

[height,width,di] = size(img);

%************************Gray World method (White balance)*****************
imgR1 = img(:,:,1);
imgG1 = img(:,:,2);
imgB1 = img(:,:,3);

avg_R =  sum( sum(imgR1) ) / (height*width);
avg_G =  sum( sum(imgG1) ) / (height*width);
avg_B =  sum( sum(imgB1) ) / (height*width);

a_hat = avg_G / avg_R;
b_hat = avg_G / avg_B;

imgR2 = a_hat * imgR1;
imgB2 = b_hat * imgB1;
imgG2 = imgG1;

figure
img_bl = cat(3,imgR2,imgG2,imgB2);
imshow(img_bl)


%************************CCM algorithm (White balance)*****************

ccm = [1.672,  -0.178,  -0.494; -0.590, 2.027, -0.437; -0.655, -1.125, 2.780 ];
%color correction matrix (CCM)
newpix = double( zeros(height,width,3) );
pixel = double( zeros(height,width,3) );
for m = 1:height
    for n = 1:width
        pixel = double( [img(m,n,1);img(m,n,2);img(m,n,3)] );
        newpix(m,n,1:3) = ccm * pixel;
    end
end

img_ccm = uint8(newpix);
figure
imshow(img_ccm);

%*****************Gamma correction algorithm (white balance)********
img_nor = double(img) /255;
img_gam = img_nor .^0.45;
img_sca = uint8(img_gam * 255);
figure
imshow(img_sca);


%*************sharpening filter**************
filter = 1/64*[9 -6 -30 -6 9; -6 4 20 4 -6; ...
                      -30 20 100 20 -30;  -6 4 20 4 -6;...
                      9 -6 -30 -6 9];
img_shar = imfilter(img,filter);
figure
imshow(img_shar)
                  

