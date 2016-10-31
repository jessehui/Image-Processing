clear all;
clc;

% 
% %choose specific frames of the video
% obj_video = VideoReader('My_video.mp4');
% numFrames = obj_video.NumberOfFrames;
% numFrames_test = numFrames;
% height = obj_video.Height;
% width = obj_video.Width;
% frameRate = ceil(obj_video.FrameRate);
% 
% test_video = VideoWriter('test_video');
% test_video.FrameRate = frameRate;
% 
% frame = uint8(zeros(obj_video.Height, obj_video.Width, 3, numFrames)); 
% 
% 
% for k = 100: 105    % 
% 	frame(:,:,:,k) = read(obj_video,k);	%read the frame of each index
%     imshow(frame(:,:,:,k));
% end
% 
% 
% open(test_video);
% for k = 100: 105
%     writeVideo(test_video, frame(:,:,:,k));
% end
% close(test_video);


%get optical flow 
test_video_obj = VideoReader('test_video.avi');
opticFlow = opticalFlowHS;
while hasFrame(test_video_obj)
    frameRGB = readFrame(test_video_obj);
    frameGray = rgb2gray(frameRGB);
    
    flow = estimateFlow(opticFlow,frameGray);
    
    imshow(frameRGB);
    hold on
    plot(flow, 'DecimationFactor', [5,5], 'ScaleFactor',25);
    hold off

end

    

% vidReader = VideoReader('viptraffic.avi');
% Create optical flow object.
% 
% opticFlow = opticalFlowHS;
% Estimate the optical flow of objects in the video.
% 
% while hasFrame(vidReader)
%     frameRGB = readFrame(vidReader);
%     frameGray = rgb2gray(frameRGB);
% 
%     flow = estimateFlow(opticFlow,frameGray);
% 
%     imshow(frameRGB)
%     hold on
%     plot(flow,'DecimationFactor',[5 5],'ScaleFactor',25)
%     hold off
% end
% 

