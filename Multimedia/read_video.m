% All you need is just what Prof. Schonfeld explained in class. 
% In brief The steps would be : taking a very short video, 
% load it to MATLAB, if there is a total of n frames in video 
% you need to extract Y I Q components for each frame, 
% modulate Y in low frequency and Q and I in high frequency 
% with QAM modulation technique. And at the receiver side 
% seperate Y, I and Q using low pass filter. And convert it to RGB. 
%Do this process for all the frames in video and then you
% will have the transmitted video at receiver side. Good luck.


clear all;
clc;
% transmitter side

%1. load the video
filename = 'My_video.mp4';
obj_video = VideoReader(filename);
numFrames = obj_video.NumberOfFrames;
numFrames_test = numFrames - 130;
height = obj_video.Height;
width = obj_video.Width;
frameRate = ceil(obj_video.FrameRate);         % number of frames per second
Fs = double(height*width*frameRate);        %sampling frequency

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

%frame2 = ntsc2rgb(frame_YIQ(:,:,:,1));

%3. get Y, I , Q components
Y = zeros(obj_video.Height, obj_video.Width, numFrames_test);
I = Y;
Q = Y;

for k = 1: numFrames_test
    Y(:,:,k) = frame_YIQ(:,:,1,k);
    I(:,:,k) = frame_YIQ(:,:,2,k);
    Q(:,:,k) = frame_YIQ(:,:,3,k);
end

N = height*width*numFrames_test;
y_line = zeros(1, N);
i_line = y_line;
q_line = y_line;

m=1;
for k = 1: numFrames_test
    for i = 1: height
        for j = 1: width
            y_line(m) = Y(i,j,k);   %(height, width, frame)
            i_line(m) = I(i,j,k);
            q_line(m) = Q(i,j,k);
            m = m+1;
        end
    end
end


Fc = 3.58*10^6;  %choose carrier frequency 
fcd = Fc/Fs;    %digital frequency
w = 2*pi*fcd;
n = 0:1: N-1;
wn = w*n;
QAM = zeros(1, N);

QAM = i_line.*cos(wn)+q_line.*sin(wn);

composite_video = y_line + QAM;





f_LPF = 3*10^6;
fir_length = 20;
LPF = fir1(fir_length, f_LPF/(Fs/2));
% figure;
% plot(LPF);
% figure;
% freqz(LPF,1,256,Fs);

%get the Y components
video_LPF_Y = conv(composite_video, LPF);
video_LPF_Y = video_LPF_Y(11:N+10);     %choose the right index
Y_line_rec = video_LPF_Y;

%get the I and Q components
QAM_rec = composite_video - Y_line_rec;

QAM_I_nflt = QAM_rec .* cos(wn) * 2;    %I and Q components not filtered yet
QAM_Q_nflt = QAM_rec .* sin(wn) * 2;

%filter
f_LPF_I = 1.5*10^6; 
fir_length = 20;
LPF_I = fir1(fir_length, f_LPF_I/(Fs/2));

f_LPF_Q = 0.5*10^6;
fir_length = 20;
LPF_Q = fir1(fir_length, f_LPF_Q/(Fs/2));

%filtering
video_LPF_I = conv(QAM_I_nflt, LPF_I);
video_LPF_I = video_LPF_I(11:N+10);
video_LPF_Q = conv(QAM_Q_nflt,LPF_Q);
video_LPF_Q = video_LPF_Q(11:N+10);

I_line_rec = video_LPF_I;
Q_line_rec = video_LPF_Q;



Y_rec = zeros(height, width, numFrames_test);
Q_rec = Y_rec;
I_rec = Y_rec;
m = 1;
for k = 1: numFrames_test
    for i = 1: height
        for j = 1: width
            Y_rec(i,j,k) = Y_line_rec(m);   %(height, width, frame)
            I_rec(i,j,k) = I_line_rec(m);
            Q_rec(i,j,k) = Q_line_rec(m);
            m = m+1;
        end
    end
end




% put all the frames together
frame_YIQ_rec = zeros(obj_video.Height, obj_video.Width,3, numFrames_test);
frame_RGB_rec = frame_YIQ_rec;

for k = 1: numFrames_test
    frame_YIQ_rec(:,:,1,k) = Y_rec(:,:,k);
    frame_YIQ_rec(:,:,2,k) = I_rec(:,:,k);
    frame_YIQ_rec(:,:,3,k) = Q_rec(:,:,k);
end

% convert from YIQ to RGB
for k = 1: numFrames_test
    frame_RGB_rec(:,:,:,k) = ntsc2rgb(frame_YIQ_rec(:,:,:,k));       
end

% display the video
figure;
for k = 1: numFrames_test
    imshow(frame_RGB_rec(:,:,:,k));
    pause(0.5);
end

video_rec_obj = VideoWriter('Video_Rec');
video_rec_obj.FrameRate = frameRate;

open(video_rec_obj);
for k = 1: numFrames_test
    writeVideo(video_rec_obj, frame_RGB_rec(:,:,:,k));
end
close(video_rec_obj);



% Rframe2=Y_rec+0.956*I_rec+0.620*Q_rec;
% Gframe2=Y_rec-0.272*I_rec-0.647*Q_rec;
% Bframe2=Y_rec-1.108*I_rec+1.7*Q_rec;
% 
% rgbimage=zeros(240,352,3);
% rgbimage(:,:,1)=Rframe;
% rgbimage(:,:,2)=Gframe;
% rgbimage(:,:,3)=Bframe;
% figure;
% imshow(uint8(rgbimage));




% Y_FFT = fftshift(fft(y));
% %n = 1:N-1;
% %f = n*Fs/N;
% %plot(f, Y_FFT);
% 
% Fc = 4.2*10^6;              %cut off frequency
% [b,a] = butter(10,Fc/(Fs/2), 'low');       % 10th order butterworth low pass filter. cut off frequency 4.2MHz
% Y_filtered = filter(b,a,Y_FFT);
% 
% 
% 
% 
% 
% 
% 
% 
% % receiver side
% ComSig_received = Y_filtered;   %???composite signal, ?????Y  !!!!
% 
% Fc_rec = 4.2*10^6;    %cut off frequency at receiver side to seperate luminance and chominance
% [b2,a2] = butter(4, Fc_rec/(Fs/2));
% Y_seperated = filter(b2,a2,ComSig_received);
% 
% y_rec =abs(ifft(Y_seperated)) ;
% 
% 
% Y_rec = zeros(height, width, numFrames_test);
% m = 1;
% for k = 1: numFrames_test
%     for i = 1: height
%         for j = 1: width
%             Y_rec(i,j,k) = y_rec(m);   %(height, width, frame)
%             m = m+1;
%         end
%     end
% end
% 
% for k = 1: numFrames_test
%     figure;
%     imshow(Y_rec(:,:,k));
% end
% 
% 

% % 1. receive the composite signal and extract Y I Q components
% rec_frame_YIQ = double(zeros(obj_video.Height, obj_video.Width, 3, numFrames));
% 
% % 2. convert YIQ space into RGB space
% rec_frame_RGB = uint8(rec_frame_YIQ);
% 
% for k = 1: numFrames - eff
%     rec_frame_RGB(:,:,:,k) = ntsc2rgb(rec_frame_YIQ(:,:,:,k));
% end
% 
% for k = 1: numFrames - eff
%     imshow(rec_frame_RGB(:,:,:,k));
% end
% 
%     



