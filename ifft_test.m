
clear all;
clc;
im = imread('woman.bmp');
figure
imshow(im);

%c,d
im_fft = fft2(double(im));
im_fft_shift = fftshift(im_fft);
im_fft_abs = abs(im_fft_shift);
im_mag = log(im_fft_abs);
figure
imshow(uint8(im_mag),[]); %magnitude

phase = angle(im_fft_shift);
im_phs = log(phase*180/pi);
figure 
imshow(uint8(im_phs),[])

%e
im_slit = zeros(512,512,1);
im_slit(512/2-18/2:512/2+18/2,512/2-98/2:512/2+98/2) = 1;
for i = 1:512
    for j = 1:512
        if im_slit(i,j) == 1
            im_slit(i,j) = 255;
        end
    end
end
im_slit = uint8(im_slit);

%f,g
im_slit_fft = fft2(im_slit);
im_slit_fft = fftshift(im_slit_fft);
im_slit_mag = log(abs(im_slit_fft)+1);
figure
imshow(uint8(im_slit_mag),[]);
title('slit magnitude');

im_slit_angl = log(angle(im_slit_fft)*180/pi);
figure
imshow(uint8(im_slit_angl),[]);
title('slit phase');

%h,i
im_rec = ifft2(im_fft);
figure 
imshow(uint8(im_rec),[]);
title('reconstruction image');

%j,k
im = imread('woman.bmp');
im_fft = fft2(double(im));
im_fft_abs2 = abs(im_fft);
im_mag_rec = im_fft_abs2 .* cos(0) + im_fft_abs2 .* sin(0) .* i;
im_mag_rec = ifft2(im_mag_rec);
%im_mag_rec = ifftshift(im_mag_rec);
im_mag_rec = uint8(im_mag_rec);
figure
imshow(im_mag_rec,[]);
title('reconstruct with only magnitude')

%l,m
im = imread('woman.bmp');
im_fft = fft2(double(im));
%im_fft = fftshift(im_fft);
phs2 = angle(im_fft);
im_phs_rec = cos(phs2) + sin(phs2) .* i;
im_phs_rec_abs = abs( ifft2(im_phs_rec) );
figure
imshow(uint8(im_phs_rec_abs),[]);
title('reconstruct with only phase');



