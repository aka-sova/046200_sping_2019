
addpath files

load('..\SpongeBob.mat');
mkdir('imgs_q2');



%% 1. play the movie

% implay(SpongeBob);

%% 2. Finding the Period of the movie

period_frames = 20;

frames_subplot = figure('Position',[350 100 900 700]);


for i=1:period_frames
    subplot(4,5,i);
    imshow(SpongeBob(:,:,i));
    title_txt = sprintf('Fr: %2.0f', i);
    title(title_txt);
end
suptitle('Full period of the SpongeBob circling');

file_name = sprintf('imgs_q2/sponge_period.png');
saveas(frames_subplot, file_name,'png');

% let's take 20 FPS
% then the full circle frequency is:

%% 3. 

fps = 20; 
cycle_length = period_frames;

frequency_circle = fps * 1/cycle_length; % [cycle/sec]

nyquist_freq = 2*frequency_circle; % [cycle/sec]
nyquist_freq_fps = nyquist_freq*fps;

%% 4. running backwards

backwards_sampling_size = 15;
max_frame_idx = round(size(SpongeBob,3)/backwards_sampling_size);

for i=1:max_frame_idx
    SpongeBob_backwards(:,:,i) = SpongeBob(:,:,1+((i-1)*backwards_sampling_size)); 
    % fprintf('Taking index %2.0f\n' ,1+((i-1)*backwards_sampling_size));
end

% implay(SpongeBob_backwards);

frames_subplot = figure('Position',[350 100 900 700]);

for i=1:period_frames
    subplot(4,5,i);
    imshow(SpongeBob_backwards(:,:,i));
    title_txt = sprintf('Fr: %2.0f', 1+((i-1)*backwards_sampling_size));
    title(title_txt);
end
suptitle('Period / periods of the SpongeBob running backwards');

file_name = sprintf('imgs_q2/sponge_period_backwards.png');
saveas(frames_subplot, file_name,'png');








