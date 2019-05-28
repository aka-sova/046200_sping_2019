


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









