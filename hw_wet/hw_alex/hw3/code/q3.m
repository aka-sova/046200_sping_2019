

%% (2) test the Entropy function

clc;
clear all;
mkdir('imgs_q3');

image = imread('../heisenberg.jpg');

im_entropy = calc_im_entropy(image);

fprintf('The entropy for the Heisenberg image is %1.3f\n', im_entropy);

%% (4) Huffman encoding

[im_code, dict, avglen] = huffcoding(image);

% calculate the compression ration
CR = log2(256) / avglen;

fprintf('\nImage was compressed:\n');
fprintf('Data rate is %1.3f\n', avglen);
fprintf('Compression rate is %1.3f\n', CR);

%% (5) Decode the image

decoded_im = huffmandeco(im_code, dict);

decoded_im = reshape(decoded_im, size(image));
decoded_im = uint8(decoded_im);

SE = (im2double(decoded_im)-im2double(image)).^2;
MSE = sum(SE(:));

fprintf('MSE after decompression is %1.3f\n', MSE);


%% (6) Differences encoding

sunset = imread('../sunset.jpg');

sunset_cs = reshape(sunset, [size(sunset,1) * size(sunset,2),1]);
sunset_hilbert = hilborder(sunset)';


% calculate the differences
sunset_cs_diff = calc_back_diff(sunset_cs);
sunset_hilbert_diff = calc_back_diff(sunset_hilbert);

text_cs = sprintf('Mean: %2.2f ; STD: %2.2f',...
    mean(sunset_cs_diff), std(sunset_cs_diff));

text_hilbert = sprintf('Mean: %2.2f ; STD: %2.2f',...
    mean(sunset_hilbert_diff), std(sunset_hilbert_diff));




% display the histograms
fig = figure('Position',[488 78 790 684]);
subplot(2,1,1);
histogram(sunset_cs_diff);
grid on;
title('Differences in regular order');
text(50,10000,text_cs);
subplot(2,1,2);
histogram(sunset_hilbert_diff);
grid on;
title('Differences in Hilbert order');
text(50,10000,text_hilbert);

file_name = sprintf('imgs_q3/q3_histograms_comp');
saveas(fig, file_name,'png');

% build the huffman code for each method


sunset_cs_diff = reshape(sunset_cs_diff, size(sunset));
sunset_hilbert_diff = reshape(sunset_hilbert_diff, size(sunset));


[~, ~, avglen] = huffcoding(sunset_cs_diff);

% calculate the compression ration
CR = log2(256) / avglen;
fprintf('\nFor regular pixels order:\n');
fprintf('Data rate is %1.3f\n', avglen);
fprintf('Compression rate is %1.3f\n', CR);


[~, ~, avglen] = huffcoding(sunset_hilbert_diff);

% calculate the compression ration
CR = log2(256) / avglen;
fprintf('\nFor Hilbert pixels order:\n');
fprintf('Data rate is %1.3f\n', avglen);
fprintf('Compression rate is %1.3f\n', CR);






