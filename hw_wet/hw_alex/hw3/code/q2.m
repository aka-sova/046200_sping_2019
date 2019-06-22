
addpath files

load('..\SpongeBob.mat');


%% 1. play the movie

% implay(SpongeBob);

%% 2. Finding the Period of the movie

period_frames = 20;

frames_subplot = figure();


for i=1:period_frames
    subplot(4,5,i);
    imshow(SpongeBob(:,:,i));
    title_txt = sprintf('Fr: %2.0f', i);
    title(title_txt);
end
suptitle('Full period of the SpongeBob circling');

% let's take 20 FPS
% then the full circle frequency is:

%% 3. 

cycle_length = period_frames-1;
cycle_period = 1/cycle_length ; % [cycle/frames]

nyquist_freq_frames = cycle_period*2;

fps = 20; 
frequency_circle = fps * 1/cycle_length; % [cycle/sec]

nyquist_freq = 2*frequency_circle; % [cycle/sec]

%% 4. running backwards

backwards_sampling_size = 18;
max_frame_idx = round(size(SpongeBob,3)/backwards_sampling_size);

for i=1:max_frame_idx
    SpongeBob_backwards(:,:,i) = SpongeBob(:,:,1+((i-1)*backwards_sampling_size)); 
    fprintf('Taking index %2.0f\n' ,1+((i-1)*backwards_sampling_size));
end

implay(SpongeBob_backwards);










