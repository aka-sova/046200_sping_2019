%% INFO
% 
% Author: Alexander Shender
% ID: 328626114
%
%%  Question 2 - a 

% for each image, find fft2, amplitude, and phase

image_1     = imread('..\Uma.jpg');
im1_fft2    = fft2(image_1);
im1_fft2_sh = fftshift(im1_fft2);
amp_1       = abs(im1_fft2_sh);
angle_1     = angle(im1_fft2_sh);


image_2     = imread('..\cat.jpg');
im2_fft2    = fft2(image_2);
im2_fft2_sh = fftshift(im2_fft2);
amp_2       = abs(im2_fft2_sh);
angle_2     = angle(im2_fft2_sh);


figure_2_a = figure('Name','Question 2-a');
subplot(2,2,1);
imshow(image_1);
title('Original image (Uma)');
subplot(2,2,2);
imshow(rescale(amp_1,0,255))
title('Fourier 2D amplitude (Uma)');
subplot(2,2,3);
imshow(image_2);
title('Original image (cat)');
subplot(2,2,4);
imshow(rescale(amp_2,0,255))
title('Fourier 2D amplitude (cat)');


%%  Question 2 - b 

% using the phase map of Uma for cat and vice versa

uma_cat_fft = create_fft_from_amp_phase(amp_1,angle_2);
uma_cat_restored = uint8(abs(ifft2(ifftshift(uma_cat_fft))));

cat_uma_fft = create_fft_from_amp_phase(amp_2,angle_1);
cat_uma_restored = uint8(abs(ifft2(ifftshift(cat_uma_fft))));

figure_2_b = figure('Name','Question 2-b');
subplot(1,2,1);
imshow(uma_cat_restored);
title('Uma amplitude, cat phase');
subplot(1,2,2);
imshow(cat_uma_restored);
title('Cat amplitude, Uma phase');


%%  Question 2 - c



% generate noise image, from it we take the random phase and amplitude

random_image = uint8(round(255*rand(size(image_1))));
random_image_fft            = fft2(random_image);
random_image_fft2_sh        = fftshift(random_image_fft);
random_image_amp            = abs(random_image_fft2_sh);
random_image_phase          = angle(random_image_fft2_sh);


% first image - random amplitude, Uma phase

uma_fft = create_fft_from_amp_phase(random_image_amp,angle_1);
uma_restored_1 = uint8(abs(ifft2(ifftshift(uma_fft))));


% second image - Uma amplitude, random phase

uma_fft = create_fft_from_amp_phase(amp_1,random_image_phase);
uma_restored_2 = uint8(abs(ifft2(ifftshift(uma_fft))));


figure_2_c = figure('Name','Question 2-c');
subplot(1,2,1);
imshow(uma_restored_1);
title('Random amplitude, Uma phase');
subplot(1,2,2);
imshow(uma_restored_2);
title('Uma amplitude, random phase');












