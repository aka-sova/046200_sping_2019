%% INFO
% 
% Author: Alexander Shender
% ID: 328626114
%
%%  Question 3 - a 

c = 1;
gamma_arr = [0.005 0.02 0.05 0.2 0.5 0.8 1 2 4 10 15 20];
gray_levels = im2double(uint8(linspace(0,255,256)));

figure_3_a = figure('Name','Question 3-a');
for i=1:length(gamma_arr)
    gamma = gamma_arr(i);
    s(i,:) = c*gray_levels.^gamma;
    legend_text = ['\gamma = ',num2str(gamma)];
    plot(255*gray_levels,255*s(i,:),'DisplayName',legend_text);
    hold on;
end

axis on;
grid on;
xlabel('Input gray level (r)');
ylabel('s = cr^\gamma');
title('Gamma correction for different \gamma values');
legend show

%%  Question 3 - b 


image_2     = imread('..\scotland.jpg');
img2_gray   = rgb2gray(image_2);

figure_3_b_1	= figure('Name','Question 3-b');
histogram(img2_gray(:));
title('Original image histogram (gamma = 1)');


gamma   = 0.7;
c       = 1;
img1_corrected = apply_gamma_correction(img2_gray,c,gamma,1);


figure_3_b_2	= figure('Name','Question 3-b');
histogram(img1_corrected(:));
title_text =  sprintf('Corrected image histogram (gamma = %2.1f)', gamma);
title(title_text);


figure_3_b_3	= figure('Name','Question 3-b');
subplot(2,1,1)
imshow(img2_gray);
title('Original image');
subplot(2,1,2)
imshow(img1_corrected);
title_text =  sprintf('Corrected image (gamma = %2.1f)', gamma);
title(title_text);


%%  Question 3 - c, d

image_3 = imread('grass_sky.jpg');

image_3_r = image_3(:,:,1);
image_3_g = image_3(:,:,2);
image_3_b = image_3(:,:,3);


figure_3_c_1	= figure('Name','Question 3-c');
subplot(3,1,1)
histogram(image_3_r(:));
title('Histogram of the Red channel');
subplot(3,1,2)
histogram(image_3_g(:));
title('Histogram of the Green channel');
subplot(3,1,3)
histogram(image_3_b(:));
title('Histogram of the Blue channel');

image_3_g_corrected = apply_gamma_correction(image_3_g,c,gamma,1);

image_3_corrected(:,:,1) =  image_3_r;
image_3_corrected(:,:,2) =  image_3_g_corrected;
image_3_corrected(:,:,3) =  image_3_b;


figure_3_c_2	= figure('Name','Question 3-c');
subplot(2,1,1)
imshow(image_3)
title('Original image');
subplot(2,1,2)
imshow(image_3_corrected)
title_text =  sprintf('Corrected image (gamma = %2.1f)', gamma);
title(title_text);


%%  Question 3 - e

image_2_hsv = rgb2hsv(image_2);

image_2_h = image_2_hsv(:,:,1);
image_2_s = image_2_hsv(:,:,2);
image_2_v = image_2_hsv(:,:,3);


figure_3_e	= figure('Name','Question 3-e');
subplot(3,1,1)
histogram(image_2_h(:));
title('Histogram of the H channel');
subplot(3,1,2)
histogram(image_2_s(:));
title('Histogram of the S channel');
subplot(3,1,3)
histogram(image_2_v(:));
title('Histogram of the V channel');


%%  Question 3 - f,g   :   

gamma_arr = [0.2 2];

% create 6 images : for each gamma, change each of the 3 channels (h,s,v)



for i=1:length(gamma_arr)
    
    gamma = gamma_arr(i);
    
    image_2_h_corrected = apply_gamma_correction(image_2_h,c,gamma,0);
    image_2_s_corrected = apply_gamma_correction(image_2_s,c,gamma,0);
    image_2_v_corrected = apply_gamma_correction(image_2_v,c,gamma,0);
    
    image_2_hsv_h_corr = image_2_hsv;
    image_2_hsv_h_corr(:,:,1) = image_2_h_corrected;
    image_2_rgb_h_corr = hsv2rgb(double(image_2_hsv_h_corr));
    
    
    image_2_hsv_s_corr = image_2_hsv;
    image_2_hsv_s_corr(:,:,2) = image_2_s_corrected;     
    image_2_rgb_s_corr = hsv2rgb(image_2_hsv_s_corr);
    
    
    image_2_hsv_v_corr = image_2_hsv;
    image_2_hsv_v_corr(:,:,3) = image_2_v_corrected;    
    image_2_rgb_v_corr = hsv2rgb(image_2_hsv_v_corr);
    
    
    figure('Name','Question 3-f');
    subplot(2,1,1)
    imshow(image_2)
    title('Original image');
    subplot(2,1,2)
    imshow(image_2_rgb_h_corr);
    title_text =  sprintf('Corrected H channel (gamma = %2.1f)', gamma);
    title(title_text);
    
    
    figure('Name','Question 3-f');
    subplot(2,1,1)
    imshow(image_2)
    title('Original image');
    subplot(2,1,2)
    imshow(image_2_rgb_s_corr);
    title_text =  sprintf('Corrected S channel (gamma = %2.1f)', gamma);
    title(title_text);
    
    figure('Name','Question 3-f');
    subplot(2,1,1)
    imshow(image_2)
    title('Original image');
    subplot(2,1,2)
    imshow(image_2_rgb_v_corr);
    title_text =  sprintf('Corrected V channel (gamma = %2.1f)', gamma);
    title(title_text);
    
end





