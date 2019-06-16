


%% 1. create the F1 function

R = 2000;
S = 8;

syms F1(x,y) x y


im1 = zeros(R/10, R/10);
f_i = [20/R, 50/R, 400/R];
i_i = [x,y,x+y];


F1(x,y) = sin(2*pi*f_i(3)*i_i(2)) + ...
    sin(2*pi*f_i(2)*i_i(1))+...
    sin(2*pi*f_i(1)*i_i(3));

fprintf('Creating an image\n');

for row=1:size(im1,1)
    for col=1:size(im1,2)
        im1(col,row) = double(F1(row,col));
    end
    
    if mod(row,10) == 0
       fprintf('%2.0f / %2.0f\n', row, size(im1,1));
    end
end


fig_1_b = figure();
imshow(im1,[]);
title('F_1 (\Delta = 1)');

%% Create the FFT of the image

im2_fft1    = fft2(im1);
im2_fft1_sh = fftshift(im2_fft1);
amp_1       = abs(im2_fft1_sh);
angle_1     = angle(im2_fft1_sh);



figure_1_c = figure();
imshow(rescale(amp_1,0,255))
grid on;
title('Fourier 2D amplitude');

% find the exact location of the amplitudes
threshold = 10000;
max_values = find_max_exact_values(amp_1, threshold);

% middle is [101, 101]






%% (d) Sampling with different sampling rate

sampling_rate = S+1;

im2 = sample_image(im1, sampling_rate);


% display the image, use the fft transform, find exact points

im2_fft2    = fft2(im2);
im2_fft2_sh = fftshift(im2_fft2);
amp_2       = abs(im2_fft2_sh);
angle_2     = angle(im2_fft2_sh);


figure_1_d = figure();
subplot(1,2,1);
imshow(im2,[]);
title('F_1 (\Delta = 9)');
subplot(1,2,2);
imshow(rescale(amp_2,0,255))
grid on;
title('Fourier 2D amplitude');



%% (e) load a new image of Street from a smartphone


% for each image, find fft2, amplitude, and phase


image_3     = imread('street_manhattan.jpg');
image_3     = rgb2gray(image_3);

image_3     = imresize(image_3, [R/5, R/5]); % 400 x 400

im1_fft3    = fft2(image_3);
im1_fft3_sh = fftshift(im1_fft3);
amp_3       = abs(im1_fft3_sh);
angle_3     = angle(im1_fft3_sh);

amp_3_disp = log10(amp_3+1);

figure_1_e = figure();
subplot(1,2,1);
imshow(image_3,[]);
title('Image (\Delta = 1)');
subplot(1,2,2);
imshow(amp_3_disp,[])
grid on;
title('Fourier 2D log amplitude');



%% (f) sample with bigger sample size

% sample_size is 4;

sample_size = (R/5)/(R/20);

image_4 = sample_image(image_3, sample_size);


im1_fft4    = fft2(image_4);
im1_fft4_sh = fftshift(im1_fft4);
amp_4       = abs(im1_fft4_sh);
angle_4     = angle(im1_fft4_sh);

amp_4_disp = log10(amp_4+1);

figure_1_f1 = figure();
subplot(1,2,1);
imshow(image_4,[]);
title('Image (\Delta = 4)');
subplot(1,2,2);
imshow(amp_4_disp,[])
grid on;
title('Fourier 2D log amplitude');


% compare both images

figure_1_f2 = figure();
subplot(2,2,1);
imshow(image_3,[]);
title('Image (\Delta = 1)');
subplot(2,2,2);
imshow(amp_3_disp,[])
grid on;
title('Fourier 2D log amplitude (\Delta = 1)');
subplot(2,2,3);
imshow(image_4,[]);
title('Image (\Delta = 4)');
subplot(2,2,4);
imshow(amp_4_disp,[])
grid on;
title('Fourier 2D log amplitude (\Delta = 4)');



%% (g) perform a gaussian filter on the original image before sampling










filt_kernel  =   fspecial('gaussian',5,3);
image_3_filt =   imfilter(image_3,filt_kernel,'same');


image_4_filt = sample_image(image_3_filt, sample_size);


im1_fft4_filt    = fft2(image_4_filt);
im1_fft4_sh_filt = fftshift(im1_fft4_filt);
amp_4_filt       = abs(im1_fft4_sh_filt);
angle_4_filt     = angle(im1_fft4_sh_filt);

amp_4_disp_filt = log10(amp_4_filt+1);

figure_1_f1 = figure();
subplot(1,2,1);
imshow(image_4_filt,[]);
title('F_1 (\Delta = 4)');
subplot(1,2,2);
imshow(amp_4_disp_filt,[])
grid on;
title('Fourier 2D log amplitude');


% compare to the previous results without the filter

% compare both images

figure_1_f2 = figure();
subplot(3,2,1);
imshow(image_3,[]);
title('F_1 (\Delta = 1)');
subplot(3,2,2);
imshow(amp_3_disp,[])
grid on;
title('Fourier 2D log amplitude (\Delta = 1)');

subplot(3,2,3);
imshow(image_4,[]);
title('F_1 (\Delta = 4)');
subplot(3,2,4);
imshow(amp_4_disp,[])
grid on;
title('Fourier 2D log amplitude (\Delta = 4)');

subplot(3,2,5);
imshow(image_4_filt,[]);
title('F_1 (gauss filtered) (\Delta = 4)');
subplot(3,2,6);
imshow(amp_4_disp_filt,[])
grid on;
title('Fourier 2D log amplitude (\Delta = 4)');













%%