clear all;
clc
img = imread('rawimage.bmp');
imshow(img);
[height,width] = size(img);
Bimg = uint8(zeros(height/2,width/2));
Rimg = uint8(zeros(height/2,width/2)); 
GBimg =  uint8(zeros(height/2,width/2));%green filter on blue row
GRimg =  uint8(zeros(height/2,width/2));%green filter on red row
for m = 0:(height/4 - 1) 
    for n = 0:(width/4 - 1)
        Bimg(1+2*m,1+2*n) = img(1+4*m,1+4*n);
        Bimg(1+2*m,2+2*n) = img(1+4*m,3+4*n);
        Bimg(2+2*m,1+2*n) = img(3+4*m,1+4*n);
        Bimg(2+2*m,2+2*n) = img(3+4*m,3+4*n);
    
    end
end
figure
imshow(Bimg)

for m = 0:(height/4 - 1) 
    for n = 0:(width/4 - 1)
        Rimg(1+2*m,1+2*n) = img(2+4*m,2+4*n);
        Rimg(1+2*m,2+2*n) = img(2+4*m,4+4*n);
        Rimg(2+2*m,1+2*n) = img(4+4*m,2+4*n);
        Rimg(2+2*m,2+2*n) = img(4+4*m,4+4*n);
    
    end
end
figure 
imshow(Rimg)

for m = 0:(height/4 - 1) 
    for n = 0:(width/4 - 1)
        GBimg(1+2*m,1+2*n) = img(1+4*m,2+4*n);
        GBimg(1+2*m,2+2*n) = img(1+4*m,4+4*n);
        GBimg(2+2*m,1+2*n) = img(3+4*m,2+4*n);
        GBimg(2+2*m,2+2*n) = img(3+4*m,4+4*n);
    
    end
end
figure 
imshow(GBimg)

for m = 0:(height/4 - 1) 
    for n = 0:(width/4 - 1)
        GRimg(1+2*m,1+2*n) = img(2+4*m,1+4*n);
        GRimg(1+2*m,2+2*n) = img(2+4*m,3+4*n);
        GRimg(2+2*m,1+2*n) = img(4+4*m,1+4*n);
        GRimg(2+2*m,2+2*n) = img(4+4*m,3+4*n);
    
    end
end
figure 
imshow(GRimg)

% I = getimage(gcf);
% imwrite(I,'GRimg.jpg')%write the file

ful_im = uint8(zeros(height,width,3));
for m = 0:(height/2 - 1) 
    for n = 0:(width/2 - 1)
        %blue channel
        ful_im(1+2*m,1+2*n,3) = Bimg(m+1,n+1);
        ful_im(1+2*m,2+2*n,3) = Bimg(m+1,n+1);
        ful_im(2+2*m,1+2*n,3) = Bimg(m+1,n+1);
        ful_im(2+2*m,2+2*n,3) = Bimg(m+1,n+1);
        
    end
end

for m = 0:(height/2 - 1) 
    for n = 0:(width/2 - 1)
        %red channel
        ful_im(1+2*m,1+2*n,1) = Rimg(m+1,n+1);
        ful_im(1+2*m,2+2*n,1) = Rimg(m+1,n+1);
        ful_im(2+2*m,1+2*n,1) = Rimg(m+1,n+1);
        ful_im(2+2*m,2+2*n,1) = Rimg(m+1,n+1);
        
    end
end

for m = 1:height/2
    for n = 1:width/2 
    %green channel on blue row
    ful_im(2*m-1,2*n,2) = GBimg(m,n);
    ful_im(2*m-1,2*n+1,2) = GBimg(m,n);
    %green channel on red row
    ful_im(2*m,2*n-1,2) = GRimg(m,n);
    ful_im(2*m,2*n,2) = GRimg(m,n);
    end
end

imgR1 = ful_im(:,:,1);
imgG1 = ful_im(:,:,2);
imgB1 = ful_im(:,:,3);

color_img = cat(3,imgR1,imgG1,imgB1);
figure 
imshow(color_img)
I = getimage(gcf);
imwrite(I,'Ful_img.jpg')%write the file


%************************GREEN************************
%get all the green value
rawG = zeros(height,width);
for m = 1:height
    for n = 1:width/2
        if(mod(m,2) == 0)
            rawG(m,2*n-1) = img(m,2*n-1);
        else
            rawG(m,2*n) = img(m,2*n);
        end
    end
end


imgG2 = rawG;
%edge processing
%(1,1)
imgG2(1,1) = ( rawG(1,2) + rawG(2,1) )/2;
%(960,1280)
imgG2(960,1280) = ( rawG(959,1280) + rawG(960,1279) )/2;
for n = 2:width/2%first row
    imgG2(1,2*n-1) = ( rawG(1,2*n) + rawG(1,2*n-2) + rawG(2,2*n-1))/3;
end
for m = 2:height/2%first colum
    imgG2(2*m-1,1) = ( rawG(2*m,1) + rawG(2*m-2,1) + rawG(2*m-1,2) )/3;
end

for n = 1:width/2-1%last row
    imgG2(height,2*n) = ( rawG(height,2*n-1) + rawG(height,2*n+1) +  rawG(height-1,2*n) )/3;
end

for m = 1:height/2-1%last colum
    imgG2(2*m,width) = ( rawG(2*m-1, width) + rawG(2*m+1,width) + rawG(2*m,width-1) )/3;
end

for m = 2: height/2
    for n = 2:width/2
        imgG2(2*m-1, 2*n-1) = ( rawG(2*m-2,2*n-1) + rawG(2*m,2*n-1) + rawG(2*m-1,2*n-2) + rawG(2*m-1,2*n) ) / 4;
        imgG2(2*m-2,2*n-2) = ( rawG(2*m-3,2*n-2) + rawG(2*m-1,2*n-2) + rawG(2*m-2,2*n-3) + rawG(2*m-2,2*n-1) ) / 4;
    end
end

% for m = 2: height/2
%     for n = 2:width/2
%         imgG2(2*m-1, 2*n-1) = ( rawG(2*m-2,2*n-1) + rawG(2*m,2*n-1) + rawG(2*m-1,2*n-2) + rawG(2*m-1,2*n) ) / 4;
%     end
% end
imgG2 = uint8(imgG2);%green channel

%****************************BLUE****************
%get all the blue value
rawB = zeros(height,width);
for m = 1:height/2
    for n = 1:width/2
       rawB(2*m-1,2*n-1) = img(2*m-1,2*n-1);
    end
end

imgB2 = rawB;
for m = 1:height/2-1
    for n = 1:width/2-1
        imgB2(2*m-1,2*n) = ( rawB(2*m-1,2*n-1) +  rawB(2*m-1,2*n+1) ) / 2;
        imgB2(2*m,2*n-1) = ( rawB(2*m-1,2*n-1) +  rawB(2*m+1,2*n-1) ) / 2;
        imgB2(2*m,2*n) = (imgB2(2*m-1,2*n) + imgB2(2*m,2*n-1) ) / 2;
    end
end
imgB2 = uint8(imgB2);%blue channel

%*********************RED**************************
rawR = zeros(height,width);
for m = 1:height/2
    for n = 1:width/2
       rawR(2*m,2*n) = img(2*m,2*n);
    end
end

imgR2 = rawR;
for m = 1:height/2-1
    for n = 1:width/2-1
        imgR2(2*m,2*n+1) = ( rawR(2*m,2*n) +  rawR(2*m,2*n+2) ) / 2;
        imgR2(2*m+1,2*n) = ( rawR(2*m,2*n) +  rawR(2*m+2,2*n) ) / 2;
        imgR2(2*m+1,2*n+1) = (imgR2(2*m,2*n+1) + imgR2(2*m+1,2*n) ) / 2;
    end
end
imgR2 = uint8(imgR2);%red channel

figure
col_img_bi = cat(3,imgR2,imgG2,imgB2);

imshow(col_img_bi)

