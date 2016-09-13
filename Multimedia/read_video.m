% All you need is just what Prof. Schonfeld explained in class. 
% In brief The steps would be : taking a very short video, 
% load it to MATLAB, if there is a total of n frames in video 
% you need to extract Y I Q components for each frame, 
% modulate Y in low frequency and Q and I in high frequency 
% with QAM modulation technique. And at the receiver side 
% seperate Y, I and Q using low pass filter. And convert it to RGB. 
%Do this process for all the frames in video and then you
% will have the transmitted video at receiver side. Good luck.




% transmitter side

%1. load the video
filename = 'My_video.mp4';
obj_video = VideoReader(filename);
numFrames = obj_video.NumberOfFrames;
numFrames_test = numFrames - 190;

%2. convert the frame of the video from RGB space to YIQ space
frame = uint8(zeros(obj_video.Height, obj_video.Width, 3, numFrames));  %get  all indexes for each pixel of each frame
frame_YIQ =double(frame);      %duplicate another space for frame in YIQ space

for k = 1: numFrames_test    % -190 just for test efficiency
	frame(:,:,:,k) = read(obj_video,k);	%read the frame of each index
    imshow(frame(:,:,:,k));
end

for k = 1: numFrames_test
    frame_YIQ(:,:,:,k) = rgb2ntsc(frame(:,:,:,k));       %converts the m-by-3 RGB values in rgbmap to NTSC color space(YIQ)
end

%3. get Y, I , Q components
Y = zeros(obj_video.Height, obj_video.Width, numFrames_test);
I = Y;
Q = Y;

for k = 1: numFrames_test
    Y(:,:,k) = frame_YIQ(:,:,1,k);
    I(:,:,k) = frame_YIQ(:,:,2,k);
    Q(:,:,k) = frame_YIQ(:,:,3,k);
end


% receiver side

% 1. receive the composite signal and extract Y I Q components
rec_frame_YIQ = double(zeros(obj_video.Height, obj_video.Width, 3, numFrames));

% 2. convert YIQ space into RGB space
rec_frame_RGB = uint8(rec_frame_YIQ);

for k = 1: numFrames - eff
    rec_frame_RGB(:,:,:,k) = ntsc2rgb(rec_frame_YIQ(:,:,:,k));
end

for k = 1: numFrames - eff
    imshow(rec_frame_RGB(:,:,:,k));
end

    



