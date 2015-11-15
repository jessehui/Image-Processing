Im = imread('white_house256.jpg');
[height,width] = size(Im);


%calculate the number of pixels with the same grey level
PixelNumSame = zeros(1,256);%there are 256 grey levels 0-255
for j = 1:height
	for k = 1:width
		PixelNumSame(Im(j,k)+1) = PixelNumSame(Im(j,k)+1)+1;
	end
end

%calculate the probability density
ProDensity = zeros(1,256);
for i = 1:256
	ProDensity(i) = PixelNumSame(i) / (height * width);
end

%calculate the probability density after the equalization
ProDenAfter = zeros(1,256);
for i = 1:256
	if i == 1
		ProDenAfter(i) = ProDensity(i);
	else
		ProDenAfter(i) = ProDensity(i)+ProDenAfter(i-1);
	end
end

%calculate the equalized grey level
GreyLevelEq = uint8(ProDenAfter*255);

%map the image 
for j = 1:height
	for k = 1:width
		Im2(j,k) = GreyLevelEq(Im(j,k)+1);
	end
end

figure
subplot(2,2,1)
imshow(Im);
subplot(2,2,2)
imhist_self(Im);
%show the new image and histogram
subplot(2,2,3)
imshow(Im2);
subplot(2,2,4)
imhist_self(Im2);
