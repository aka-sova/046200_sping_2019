



%% (b) Max Lloyd quantizer

mkdir('imgs_q4');

color_img = imread('../colorful.jpg');

meps = 0.02;
initialization = 1; % random

% 6 levels:
levels = 6;
[dataout, distortion, QL, eps] = max_lloyd_quatizer(color_img, levels, meps, initialization);

q4_print_graphs 


% for 15 levels:
levels = 15;
[dataout, distortion, QL, eps] = max_lloyd_quatizer(color_img, levels, meps, initialization);

q4_print_graphs 

%% (d) Initialization is not random 


meps = 0.02;
initialization = 2; % fixed for 9 levels
levels = 9;

[dataout, distortion, QL, eps] = max_lloyd_quatizer(color_img, levels, meps, initialization);

q4_print_graphs 







