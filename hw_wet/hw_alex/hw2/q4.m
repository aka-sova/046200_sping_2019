


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

figure1 = fig();

for frame_num=1:size(Frames,3)
    
    frame = Frames(:,:,frame_num);
    corr_res = normxcorr2(Template,frame);
    [corr_res_max, cor_idx] = max(corr_res(:));

    [y,x] = ind2sub(size(corr_res),cor_idx);
    
    % add the black box around the bird of the size of template;
%     Frames_reconstructed(:,:,frame_num) = Frames(:,:,frame_num);
%         

    t_x = size(Template,1);
    t_y = size(Template,2);

    
    fig=figure();
    imshow(frame);
    rectangle('Position',[x+1-t_x y+1-t_y t_x t_y],'EdgeColor','r')
end


%% part c - improve the algorithm
















