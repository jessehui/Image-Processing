%rotation with bilinear interpolation
%-----------rotation function for one color dimension
function imgRot = rotation(Img)
[h1,w1] = size(Img);

rotAng = 30;%rotation angle
theta = rotAng*pi/180;
rotMat = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];%rotation matrix rotated with Z axis
pixUL = [1,1,1]*rotMat;%the coordinate of the up left pixel
pixUR = [1,w1,1]*rotMat;%up right
pixDL = [h1,1,1]*rotMat;%down left
pixDR = [h1,w1,1]*rotMat;%down right

h2 = ceil(max(abs(pixUL(1)-pixDR(1)),abs(pixUR(1)-pixDL(1))));%height after rotation
w2 = ceil(max(abs(pixUL(2)-pixDR(2)),abs(pixUR(2)-pixDL(2))));%width after rotation

ImgN = zeros(h2,w2);

delX = abs(min([pixDL(2),pixUR(2),pixDR(2),pixUL(2)]));
delY = abs(min([pixDL(1),pixUR(1),pixDR(1),pixUL(1)]));%delta x and y of the old range of image after rotation

ImgE = extend(Img,2);%extend the image 

for i = 1-delY:h2-delY
    for j = 1-delX:w2-delX
        pixO = [i,j,1]/rotMat;%find the coordinate of pixels of old image with the coordinate of new image

        floatX = pixO(2) - floor(pixO(2));
        floatY = pixO(1) - floor(pixO(1));

        if pixO(1) >= -1 && pixO(1) <= h1+1 && pixO(2) >= -1 && pixO(2) <= w1+1
            pixUL2 = [floor(pixO(1)), floor(pixO(2))];
            pixUR2 = [floor(pixO(1)), ceil(pixO(2))];
            pixDL2 = [ceil(pixO(1)), floor(pixO(2))];
            pixDR2 = [ceil(pixO(1)),ceil(pixO(2))];    %the four pixels next to the target pixel in four directions

            weiUL = (1-floatX) * (1-floatY);
            weiUR = (floatX) * (1-floatY);
            weiDL = (1-floatX) * floatY;
            weiDR = (floatX) * (floatY);  %calculate the weight of each four pixel next to the target pixel

            ImgN(i+delY,j+delX) = weiUL * ImgE(pixUL2(1) + 2, pixUL2(2)+2) + ...
            weiUR * ImgE(pixUR2(1) + 2, pixUR2(2) + 2)+...
            weiDL * ImgE(pixDL2(1)+2, pixDL2(2)+2)+...
            weiDR * ImgE(pixDR2(1)+2, pixDR2(2)+2); %calculate the value of the target pixel

        end
    end
end

imgRot = uint8(ImgN);

end
%---------------------
%image extend function
%image extend function
function imgExt = extend(Img,r)
    [h,w,c] = size(Img);
    imgExt = zeros(h+2*r+1,w+2*r+1,c);%initialize the new image
    imgExt(1+r:h+r,1+r:w+r,:) = Img;
    imgExt(1:r,1+r:w+r,:) = Img(1:r,1:w,:);
    imgExt(1:h+r,w+r+1:w+2*r+1,:) = imgExt(1:h+r,w:w+r,:);
    imgExt(h+r+1:h+2*r+1,r+1:w+2*r+1,:) = imgExt(h:h+r,r+1:w+2*r+1,:);
    imgExt(1:h+2*r+1,1:r,:) = imgExt(1:h+2*r+1,r+1:2*r,:);
end
%--------------------
%eliminate the black area
%the threshold value is obtained by a lot of tests 
%to get a comparativele complete image without black background

%eliminate the black area
%the threshold value is obtained by a lot of tests 
%to get a comparativele complete image without black background

function [UL,UR,DL] = elimBlack(img)
    [h,w] = size(img);%779*822
UL = [1,1];
for i = 1:h
    for j = 1:w
        if img(i,j) > 15
            UL = [i,j];
            break
        end    
    end
    if (UL ~= [1,1])
        break
    end
end

    a = UL(1)+1;
    for j = UL(2):w
        if img(a,j) ==0
            UR = [a,j-1];
            break;
        end
    end
    b = UL(2);
    for i = UL(1):h 
        if img(i,b) == 0
            DL = [i-1,b];
            break;
        end
    end    
    DR = [DL(1),UR(2)];
 %  imgW = img(UL(1):DL(1),UL(2):UR(2));
end
%------------------------------
%function of scaling the image
function imgZoom = zoom(img)
    zoomFac = 3;
    [h,w,c] = size(img);
    zoomH = round(zoomFac * h);%height after zooming
    zoomW = round(zoomFac * w);%width after zooming
    imgN = zeros(zoomH,zoomW,c);
    imgExt = extend(img,1);%extend the image

    for j = 1:zoomW  %scanning
        for i = 1:zoomH
            i2 = (i-1)/zoomFac; j2 = (j-1)/zoomFac;
            i3 = floor(i2); j3 = floor(j2);
            u = i2-i3; v = j2-j3;
            i3 = i3+1; j3 = j3+1;
            imgN(i,j,:) = (1-u)*(1-v)*imgExt(i3,j3,:) + (1-u)*v*imgExt(i3,j3+1,:)+...
            u*(1-v)*imgExt(i3+1,j3,:) + u*v*imgExt(i3+1,j3+1,:);
        end
    end
    imgZoom = uint8(imgN);
end

%----------------------------
%main function
clear all;
clc;

img = imread('PeanutRotated-B.jpg');%original image
r1 = img(:,:,1);
g1 = img(:,:,2);
b1 = img(:,:,3);
imgR = rotation(r1);
imgG = rotation(g1);
imgB = rotation(b1);
imgAR = cat(3,imgR,imgG,imgB);%image after rotation
[UL,UR,DL] = elimBlack(imgB);
imgAE = imgAR(UL(1):DL(1),UL(2):UR(2),:);%image after elimination
imgAZ = zoom(imgAE);%image after zooming 3 times scaling

figure
subplot(2,3,1)
imshow(img)
subplot(2,3,2)
imshow(imgAR)
subplot(2,3,3)
imshow(imgAE)

subplot(2,3,4:6)
imshow(imgAZ)

