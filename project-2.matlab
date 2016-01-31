clear all
Im1 =imread('white_house256.jpg');
Im3 = Im1;

%size of the window
p = 15;
q = 15;

%the middle number of the window
middle = round(p*q/2);

%find the number of columns and rows that should pad with zeros
temp = 0;
for j = 1:p
	for k = 1:q
		temp = temp+1;
		if (temp == middle)
			PadNum1 = j-1;
			PadNum2 = k-1;
		end
	end
end	

%pad the image with zeros
Im2 = padarray(Im1,[PadNum1,PadNum2]);
[height,width] = size(Im2);

%local histogram equalization

for x = 1:height-p
	for y = 1:width-q
		temp1 = 1;
		grayLevel = zeros(1,256);%initialize the value of each gray level
        cumulaDis = zeros(1,256);%cumulative of gray levels

		
		for j = 1:p
			for k = 1:q
				if(temp1==middle)
					MidWin = Im2(j+x-1,k+y-1)+1;%the gray level of the middle of the windows
				end
				temp1 = temp1+1;
%gray levels are in the range of [0,255],but we should add the range by one to compute in Matlab
				pix = Im2(j+x-1,k+y-1)+1;
				grayLevel(pix) = grayLevel(pix)+1;%calculate the number of each gray levels
			end
		end	

		%histagram equalization
		for i = 1:256
			if (i == 1)
				cumulaDis(i) = grayLevel(1);
			else
				cumulaDis(i) = grayLevel(i)+cumulaDis(i-1);
			end
		end
		Im3(x,y) = round(cumulaDis(MidWin)/(p*q)*255);
	end
end

%show the image
figure
subplot(2,2,1)
imshow(Im1);
subplot(2,2,2)
imhist_self(Im1);
subplot(2,2,3)
imshow(Im3);
subplot(2,2,4)
imhist_self(Im3);