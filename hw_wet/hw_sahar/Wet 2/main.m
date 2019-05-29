I = imread('crazyBioComp.jpg');
fig = figure();
subplot(3,3,2)
imshow(I)
title('original')
%%
SE1 = strel('disk',5);
I_eroded = imerode(I,SE1);
subplot(3,3,4)
imshow(I_eroded)
title('eroded')
%%
SE1 = strel('cube',2);
I_dilated = imdilate(I,SE1);
subplot(3,3,5)
imshow(I_dilated)
title('dilated')
%%
I_open = imopen(I,SE1);
subplot(3,3,6)
imshow(I_open)
title('open')
%%
I_close = imclose(I,SE1);
subplot(3,3,7)
imshow(I_open)
title('close')
%%
I_tophat = imtophat(I,SE1);
subplot(3,3,8)
imshow(I_open)
title('top hat')
%%
I_bothat = imbothat(I,SE1);
subplot(3,3,9)
imshow(I_open)
title('bottom hat')
%%
I2 = imread('keyboard.jpg');
fig = figure;
subplot(2,3,2);
imshow(I2)
SE2 = strel('line',8,0);
SE3 = strel('line',8,90);
SE4 = strel('square',8);
I_erode1 = imerode(I2,SE2);
subplot(2,3,4);
imshow(I_erode1)
title('vertical erode')
I_erode2 = imerode(I2,SE3);
subplot(2,3,5);
imshow(I_erode2)
title('horizontal erode')
sum_I = I_erode1 + I_erode2;
sum_I = im2bw(sum_I,0.2);
subplot(2,3,6);
imshow(sum_I)
title('sum image')
saveas(fig,'Q1-3.jpg')
%%
I2 = imread('keyboard.jpg');
I2_not = ~sum_I;
fig = figure;
imshow(I2_not)
filtered = medfilt2(I2_not,[8 8]);
imshow(filtered)
%%
sum_I_dilate = imdilate(sum_I,SE4);
imshow(sum_I_dilate)
total_im = uint8(sum_I_dilate).*I2;
total_im = imsharpen(total_im);
imshow(total_im)
imshow(im2bw(total_im,0.2))
%%
selfie = imread('IMG_4717.jpg');
selfie = imrotate(selfie,-90);
selfie = imresize(selfie,[400 300]);
selfie = rgb2gray(selfie);
selfie = imgaussfilt(selfie,0.5);
fig = figure;
subplot(2,3,2)
imshow(selfie)
title('Original')
subplot(2,3,4)
imshow(edge(selfie,'Sobel',0.03))
title('Sobel edge')
subplot(2,3,5)
imshow(edge(selfie,'Roberts',0.03))
title('Roberts edge')
subplot(2,3,6)
imshow(edge(selfie,'Canny',0.2))
title('Canny edge')
saveas(fig,'Q2-2.jpg')
%%
a = realp('a',-1);
op = [0 -a 0; -a 1+4*a -a; 0 -a 0];
vals = [0 1 2 3 4];
fig = figure();
for i = 1:1:4
    subplot(2,2,i)
    op.Blocks.a.Value = vals(i);
    tmp_img = imfilter(selfie,double(op));
    imshow(clip(tmp_img),[]);
    title(['a = ' num2str(i)])
end
saveas(fig,'Q2-3.jpg')
%%
noised_selfie = imnoise(selfie,'salt & pepper',0.06)
vals = [0.3 0.5 0.7];
fig = figure();
subplot(2,3,2)
imshow(noised_selfie,[])
for i = 1:1:3
    subplot(2,3,i+3)
    op.Blocks.a.Value = vals(i);
    tmp_img = imfilter(noised_selfie,double(op));
    imshow(clip(tmp_img),[]);
    title(['a = ' num2str(vals(i))])
end
saveas(fig,'Q2-4.jpg')
%%
noised_filtered = medfilt2(noised_selfie)
vals = [0.3 0.5 0.7];
fig = figure();
subplot(2,3,2)
imshow(noised_filtered,[])
for i = 1:1:3
    subplot(2,3,i+3)
    op.Blocks.a.Value = vals(i);
    tmp_img = imfilter(noised_filtered,double(op));
    imshow(clip(tmp_img),[]);
    title(['a = ' num2str(vals(i))])
end
saveas(fig,'Q2-5.jpg')
%%
vid = VideoReader('GallopingHorse.mp4');
width = vid.Width
height = vid.height
image = zeros([120 256]);
vid.CurrentTime = 5;
for i = 1:1:120
    frame = readFrame(vid);
    frame = rgb2gray(frame);
    image(i,:) = frame(i,:);
end
fig = figure();
imshow(image,[])
title('Up to down')
saveas(fig,'Vertical.jpg')
%%
vid = VideoReader('GallopingHorse.mp4');
width = vid.Width
height = vid.height
image = zeros([120 256]);
vid.CurrentTime=2;
for i = 1:1:256
    frame = readFrame(vid);
    frame = rgb2gray(frame);
    image(:,i) = frame(:,i);
end
fig = figure()
imshow(image,[])
title('Left to right')
saveas(fig,'Left to Right.jpg')
%%
vid = VideoReader('GallopingHorse.mp4');
width = vid.Width
height = vid.height
image = zeros([120 256]);
vid.CurrentTime=2;
for i = 1:1:256
    frame = readFrame(vid);
    frame = rgb2gray(frame);
    image(:,257-i) = frame(:,257-i);
end
fig = figure()
imshow(image,[])
title('Right to left')
saveas(fig,'Right to left.jpg')
%%



% useful functions:  implay, normxcorr2, ind2sub

load('Matlab2_files/VideoTracking.mat');

%% part a - show the template, play the video

fig = figure();
imshow(Template);


fig2 = figure();
implay(Frames);


%% part b

close all;

% find the original correlation value, ensure it's 1
corr_original = normxcorr2(Template,Template);
corr_original_val = max(corr_original(:));

Frames_reconstructed = [];
Corr_val = [];

for frame_num=1:size(Frames,3)
    
    frame = Frames(:,:,frame_num);
    corr_res = normxcorr2(Template,frame);
    [corr_res_max, cor_idx] = max(corr_res(:));
    
    Corr_val(frame_num) = corr_res_max;
    [x,y] = ind2sub(size(corr_res),cor_idx);
    
    % add the black box around the bird of the size of template;
    Frames_reconstructed(:,:,frame_num) = Frames(:,:,frame_num);
    Frames_reconstructed = uint8(Frames_reconstructed);
    
    t_x = size(Template,1);
    t_y = size(Template,2);
    
    Frames_reconstructed(x-t_x-1:x+1,y+1,frame_num) = 0;
    Frames_reconstructed(x+1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed(x-t_x-1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed(x-t_x-1:x+1,y-t_y-1,frame_num) = 0;
    
    fprintf('Done frame %2.0f \n', frame_num);
    
    %     temp = x;
    %     x = y;
    %     y = temp;
    %     fig=figure();
    %     imshow(frame);
    %     rectangle('Position',[x+1-t_x y+1-t_y t_x t_y],'EdgeColor','r')
    
end








%% part c - improve the algorithm

% set the threshold to show images which gave bad correlation

fig = figure();
plot(Corr_val);
grid;
title('Correlation value');
xlabel('Frame number');
ylabel('Correlation value');
hold all;
failed_idxs = [13, 18, 19, 20];
plot(failed_idxs,Corr_val(failed_idxs),'ro');
legend('Correlation','Failed detections');



% option 1 - use the rotation to detect when the object is rotated
%   just add another loop, for the angles

angles_vec = linspace(0, 2*pi, 100);


Corr_val_rotated = [];
max_corr_angle = [];

for frame_num=1:size(Frames,3)
    
    frame = Frames(:,:,frame_num);
    
    
    max_corr_value = 0;
    max_corr_idx = [];

    local_max_corr_angle = 0;
    
    for rot_angle_idx=1:length(angles_vec)
        
        rot_angle = angles_vec(rot_angle_idx);
        rot_template = imrotate(Template, rot_angle*180/pi,'bilinear','crop');
        
        % change the black pixels to the closest non-zero value in the
        % template. This is the artifact of the rotation
        
        [D,IDX] = bwdist(rot_template~=0);
        zero_vals  = (rot_template == 0);
        
        % just give random gray value to the black background
        rot_template(zero_vals) = 200;        
        
        corr_res = normxcorr2(rot_template,frame);
        [local_corr_max, local_cor_idx] = max(corr_res(:));
        
        if (local_corr_max > max_corr_value)
            max_corr_value = max(max_corr_value, local_corr_max);
            max_corr_idx = local_cor_idx;
            local_max_corr_angle = rot_angle;
        end
    end
    
    max_corr_angle(frame_num) = local_max_corr_angle;
    Corr_val_rotated(frame_num) = max_corr_value;
    [x,y] = ind2sub(size(corr_res),max_corr_idx);
    
    % add the black box around the bird of the size of template;
    Frames_reconstructed_2(:,:,frame_num) = Frames(:,:,frame_num);
    Frames_reconstructed_2 = uint8(Frames_reconstructed_2);
    
    t_x = size(Template,1);
    t_y = size(Template,2);
    
    Frames_reconstructed_2(x-t_x-1:x+1,y+1,frame_num) = 0;
    Frames_reconstructed_2(x+1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed_2(x-t_x-1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed_2(x-t_x-1:x+1,y-t_y-1,frame_num) = 0;
    
    
    fprintf('Done frame %2.0f \n', frame_num);
    %     temp = x;
    %     x = y;
    %     y = temp;
    %     fig=figure();
    %     imshow(frame);
    %     rectangle('Position',[x+1-t_x y+1-t_y t_x t_y],'EdgeColor','r')
    
end



fig = figure();
plot(Corr_val);
hold on;
plot(Corr_val_rotated);
grid;
title('Correlation value');
xlabel('Frame number');
ylabel('Correlation value');
legend('No rotation','With rotation');

implay(Frames_reconstructed_2);



%% Try another technique - split the template into 2 templates. This will
% help with occlusion
%   If both detect, and the coordinates are same - good
%   If both detect, and coordinates are different - take highest
%   Both will be rotated as well

temp_part{1} = Template(:,1:6);
temp_part{2} = Template(:,6:17);

Corr_val_rotated_multi = [];
Frames_reconstructed_3 = [];

angles_vec = linspace(-pi/4, pi/4, 50);


for frame_num=1:size(Frames,3)
    
    frame = Frames(:,:,frame_num);
    
    % first do for template 1
    
    max_corr_value = 0;
    max_corr_idx = [];
    max_corr_angle = [];
    local_max_corr_angle = 0;
    
    for rot_angle_idx=1:length(angles_vec)
        
        rot_angle = angles_vec(rot_angle_idx);
        rot_template = imrotate(temp_part{1}, rot_angle*180/pi,'bilinear','crop');
        
        % change the black pixels to the closest non-zero value in the
        % template. This is the artifact of the rotation
        
        [D,IDX] = bwdist(rot_template~=0);
        zero_vals  = (rot_template == 0);
        
        % just give random gray value to the black background
        rot_template(zero_vals) = 200;
        
        corr_res = normxcorr2(rot_template,frame);
        [local_corr_max, local_cor_idx] = max(corr_res(:));
        
        if (local_corr_max > max_corr_value)
            max_corr_value = max(max_corr_value, local_corr_max);
            max_corr_idx = local_cor_idx;
            local_max_corr_angle = rot_angle;
        end
    end
    
    max_corr_angle(frame_num,1) = local_max_corr_angle;
    Corr_val_rotated_multi(frame_num,1) = max_corr_value;
    [x(1),y(1)] = ind2sub(size(corr_res),max_corr_idx);
    
    
    
    % template 2
    
    max_corr_value = 0;
    max_corr_idx = [];
    local_max_corr_angle = 0;
    
    for rot_angle_idx=1:length(angles_vec)
        
        rot_angle = angles_vec(rot_angle_idx);
        rot_template = imrotate(temp_part{2}, rot_angle*180/pi,'bilinear','crop');
        
        % change the black pixels to the closest non-zero value in the
        % template. This is the artifact of the rotation
        
        [D,IDX] = bwdist(rot_template~=0);
        zero_vals  = (rot_template == 0);
        
        % just give random gray value to the black background
        rot_template(zero_vals) = 200;
        
        corr_res = normxcorr2(rot_template,frame);
        [local_corr_max, local_cor_idx] = max(corr_res(:));
        
        if (local_corr_max > max_corr_value)
            max_corr_value = max(max_corr_value, local_corr_max);
            max_corr_idx = local_cor_idx;
            local_max_corr_angle = rot_angle;
        end
    end
    
    max_corr_angle(frame_num,2) = local_max_corr_angle;
    Corr_val_rotated_multi(frame_num,2) = max_corr_value;
    [x(2),y(2)] = ind2sub(size(corr_res),max_corr_idx);
    
    
    x = x(2);
    y = y(2);

    % Taking the best correlation did not succeed. But taking only the
    % non-occluded template did succeed
    
    %     % check if coordinates are close enough
    %     distance = norm([x(2),y(2)] - [x(1),y(1)]);
    %
    %     if (distance <= 10)
    %         % 8 is the minimal distance that can be
    %         x = x(2);
    %         y = y(2);
    %     else
    %         fprintf('Different template match locations at frame %2.0f\n',...
    %             frame_num);
    %         % find the one with the highest correlation
    %         [~,idx] = max(Corr_val_rotated_multi(frame_num,:));
    %         if ( idx == 1 )
    %             % find the value that need to be added according to the angle
    %             x = x(1) + 8*cos(rot_angle);
    %             y = y(1) + 8*sin(rot_angle);
    %         else
    %             x = x(2);
    %             y = y(2);
    %         end
    %
    %     end
    %
    %     x = floor(x);
    %     y = floor(y);
    
    
    % add the black box around the bird of the size of template;
    Frames_reconstructed_3(:,:,frame_num) = Frames(:,:,frame_num);
    Frames_reconstructed_3 = uint8(Frames_reconstructed_3);
    
    t_x = size(Template,1);
    t_y = size(Template,2);
    
    Frames_reconstructed_3(x-t_x-1:x+1,y+1,frame_num) = 0;
    Frames_reconstructed_3(x+1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed_3(x-t_x-1,y-t_y-1:y+1,frame_num) = 0;
    Frames_reconstructed_3(x-t_x-1:x+1,y-t_y-1,frame_num) = 0;
    
    
    fprintf('Done frame %2.0f \n', frame_num);
%     temp = x;
%     x = y;
%     y = temp;
%     fig=figure();
%     imshow(frame);
%     hold on;
%     rectangle('Position',[x+1-t_x y+1-t_y t_x t_y],'EdgeColor','r')
    
end



fig = figure();
plot(Corr_val);
hold on;
plot(Corr_val_rotated);
plot(Corr_val_rotated_multi(:,2));
grid;
title('Correlation value (normalized)');
xlabel('Frame number');
ylabel('Correlation value');
legend('No rotation','With rotation','Rotated, template cut');



implay(Frames_reconstructed_3);

%%



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











