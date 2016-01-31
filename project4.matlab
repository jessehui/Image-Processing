Im = imread('LennaDeltaNoise.jpg'); 
flag = 1;
while flag 
	n = input('Please input the size of the filter(To end the program,input 0):');
	if n == 0
        flag = 0;
        fprintf('See you ~')
	else
		medianFilter(Im,n);
		averageFilter(Im,n);
	end
end


%--------------------
%average filter function
function Im2 = averageFilter(Im,n)
window = ones(n,n);%initialize the filter window
[height,width] = size(Im);

Im1 = double(Im);

Im2 = Im1;
center = round((n+1)/2);%the center of the window

for i = 1:height-n+1
	for j = 1:width-n+1
		temp = Im1(i:i+n-1,j:j+n-1).* window;%extract numbers of a window from (i,j) of Im1 and multiply with the window
		SUM = sum(sum(temp));%calculate the sum of the temp
		Im2(i+center,j+center) = SUM/(n*n);%calculate the average and assign the value to the center of the window
	end
end

Im2 = uint8(Im2);

%show the image before and after
figure
subplot(2,1,1)
imshow(Im)
subplot(2,1,2)
imshow(Im2)
xlabel('average filtering')
end
%------------------
%median filter function
function Im2 = medianFilter(Im,n)
[height,width] = size(Im);
Im1 = double(Im);
Im2 = Im1;
center = round((n+1)/2);
for i = 1:height-n+1
	for j = 1:width-n+1
		temp = Im1(i:i+n-1,j:j+n-1);
		ele = temp(1,:);
		for count = 2:n
			ele = [ele,temp(count,:)];
		end
		med = median(ele);
		Im2(i+center,j+center) = med;
	end
end

Im2 = uint8(Im2);
figure
subplot(2,1,1)
imshow(Im)
subplot(2,1,2)
imshow(Im2)
xlabel('median filtering')
end