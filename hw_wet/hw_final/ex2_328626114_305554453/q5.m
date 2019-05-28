


%% Question 5

%% 1. build the circle

% size = 200x200, inner circle radius=20, 

circle.im_size = 200;
circle.gray_levels = linspace(250,0,6);
circle.border_distances = linspace(0,100,length(circle.gray_levels));
circle.radius = 20;

circle_im = uint8(draw_custom_circle(circle));

fig=figure();
imshow(circle_im);

%% 2. Adding the Poisson noise

im_noised = add_poisson_noise(circle_im);

im_noised = im2double(im_noised);


%% 3. Denoise the image by L2 norm

X = im2double(circle_im);
Y = im_noised;

numIter = 50;
lambda = 0.5;

[Xout_L2, Err1_L2, Err2_L2] = DenoiseByL2(Y,X, numIter, lambda);

%% get the best image
[~,min_iter] = min(Err2_L2);
[X_out_best_L2, ~, ~] = DenoiseByL2(Y,X, min_iter, lambda);

fig = figure('Position',[200 200 1200 500]);
subplot(1,3,1)
imshow(X);
title('Original image');
subplot(1,3,2)
imshow(Y);
title('Noisy image');
subplot(1,3,3)
imshow(X_out_best_L2);
title('De-noised image (L2)');



%% 4. Denoise the image with TV prior

X = im2double(circle_im);
Y = im_noised;

numIter = 200;
lambda = 20;

[Xout_TV, Err1_TV, Err2_TV] = DenoiseByTV(Y,X, numIter, lambda);

% get the best image
[~,min_iter] = min(Err2_TV);
[X_out_best_TV, ~, ~] = DenoiseByTV(Y,X, min_iter, lambda);

fig = figure('Position',[200 200 1200 500]);
subplot(1,3,1)
imshow(X);
title('Original image');
subplot(1,3,2)
imshow(Y);
title('Noisy image');
subplot(1,3,3)
imshow(X_out_best_TV);
title('De-noised image (TV)');


% compare L2 and TV restoration
fig = figure('Position',[200 200 800 500]);
subplot(1,2,1)
imshow(X_out_best_L2);
title('De-noised image (L2)');
subplot(1,2,2)
imshow(X_out_best_TV);
title('De-noised image (TV)');



%% 5. Denoise random image


image = imread('image.jpg');
image_gray = rgb2gray(image);

im_noised = add_poisson_noise(image_gray);

im_noised = im2double(im_noised);


X = im2double(image_gray);
Y = im_noised;



%% 6. Denoise by L2,TV find best iteration

% L2
numIter = 50;
lambda = 0.5;

[Xout_L2, Err1_L2, Err2_L2] = DenoiseByL2(Y,X, numIter, lambda);

[~,min_iter] = min(Err2_L2);
[X_out_best_L2, ~, ~] = DenoiseByL2(Y,X, min_iter, lambda);


% TV

numIter = 200;
lambda = 20;

[Xout_TV, Err1_TV, Err2_TV] = DenoiseByTV(Y,X, numIter, lambda);


% get the best image
[~,min_iter] = min(Err2_TV);
[X_out_best_TV, ~, ~] = DenoiseByTV(Y,X, min_iter, lambda);










