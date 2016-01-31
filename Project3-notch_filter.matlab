%notch filter

close all
clear all
clc

im = imread('nasaNoise _1_.jpg');
im = mat2gray(im,[0,255]); %normalize the gray level in the range of [0,255] to[0,1]

[height,width] = size(im);
newH = 2*height;
newW = 2*width;
newIm = zeros(newH,newW);%initiate the new image

for i = 1:height
    for j = 1:width
        newIm(i,j) = im(i,j) * (-1)^(i+j);
    end
end

Four_im = fft2(newIm,newH,newW);

figure,imshow(log(1+abs(Four_im)),[]);%lowest gray level will be black and the highest gray level will be white
ylabel('Fourier Spectrum of Original Image');
impixelinfo
%use the function 'impixelinfo' to find the ordinate of the noise freqency
%in frequency domain.
%We can see from Figure (b) that there are 22 high frequency noise point in
%the frequency domain 
%because all of the points are on the symmetry of the origin, we can just
%locate 11 points to eliminate all the high frequency noise point.
%make the origin locate at the center of the fourier spectrum.
%the ordinates of the noise frequency in frequency domain are (about)
%(124,77),(124,239),(-114,84),(-108,251);the first column
%(236,154),(236,10),(236,-154);the second column
%(354,239),(354,77),(354,-77),(354,-239);the third column

H_NF = ones(newH,newW);%transfer function of notch filter

for i = (-newH/2):1:(newH/2)-1
    for j = (-newW/2):1:(newW/2)-1
        D = 30;%radius of the notch

        %notch filter contain 11 notch pairs
        x1 = 124; y1 = 77;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 124; y1 = 239;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = -114; y1 = 84;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = -108; y1 = 251;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 236; y1 = 154;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 236; y1 = 10;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 236; y1 = -154;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 354; y1 = 239;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 354; y1 = 77;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 354; y1 = -77;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

        x1 = 354; y1 = -239;
        D_k = ((i+y1)^2+(j+x1)^2) ^0.5;%distance between a point (x1,y1) and the center
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));%compute a part of the transfer function
        D_k = ((i-y1)^2+(j-x1)^2) ^0.5;
        H_NF(i+(newH/2)+1,j+(newW/2)+1) = H_NF(i+(newH/2)+1,j+(newW/2)+1) * (1/(1+(D/D_k)^4));

    end
end

G_im = H_NF.* Four_im;
g_im = real(ifft2(G_im));%inverse fourier transform
g_im = g_im(1:1:height,1:1:width);

for i = 1:1:height
    for j = 1:1:width
        g_im(i,j) = g_im(i,j) * ((-1)^(i+j));
    end
end

figure,subplot(1,2,1);
imshow(H_NF,[0,1]);
xlabel('Butterworth Notch filter');

subplot(1,2,2);
imshow(log(1+abs(G_im)),[]);
xlabel('Fourier spectrum of new Image')

figure
hist = mesh(1:10:newW,1:10:newH,H_NF(1:10:newH,1:10:newW));
axis([0,newW,0,newH,0,1]);
xlabel('u');ylabel('v');
zlabel('|H(u,v)|');
colormap hsv;

figure
imshow(im,[]);
xlabel('original image');

figure
imshow(g_im,[]);
xlabel('result image');
