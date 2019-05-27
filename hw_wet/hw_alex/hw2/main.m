


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


%% 3. Denoise the image






