


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



%% 4. Denoise the image with TV prior

X = im2double(circle_im);
Y = im_noised;

numIter = 200;
lambda = 20;

[Xout_TV, Err1_TV, Err2_TV] = DenoiseByTV(Y,X, numIter, lambda);








