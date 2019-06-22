 

%% (b) test the pyrGen on apple and orange


mkdir 'imgs_q5'
levels = 5;


apple = imread('../apple.jpg');
apple = rgb2gray(apple);
apple = im2double(apple);


[pyrGaus_ap, pyrLap_ap] = pyrGen(apple,levels,1);




fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrGaus_ap{i},[]);
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrGaus_ap{i},1),size(pyrGaus_ap{i},2));
   title(title_txt);
end
saveas(fig, 'imgs_q5/q5_apple_gaus.png','png');


fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrLap_ap{i},[]);
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrLap_ap{i},1),size(pyrLap_ap{i},2));
   title(title_txt);
end
saveas(fig, 'imgs_q5/q5_apple_lap.png','png');


orange = imread('../orange.jpg');
orange = rgb2gray(orange);
orange = im2double(orange);
[pyrGaus_or, pyrLap_or] = pyrGen(orange,levels,1);


fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrGaus_or{i});
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrGaus_or{i},1),size(pyrGaus_or{i},2));
   title(title_txt);
end
saveas(fig, 'imgs_q5/q5_orange_gaus.png','png');

fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrLap_or{i},[]);
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrLap_or{i},1),size(pyrLap_or{i},2));
   title(title_txt);
end
saveas(fig, 'imgs_q5/q5_orange_lap.png','png');

%% (c) Reconstruct the images from the Laplasian Pyramid


apple_rec = imRecon(pyrLap_ap, size(pyrLap_ap,2), 1); 
diff = apple-apple_rec;

fig = figure('Position',[100 200 900 500]);
subplot(1,3,1);
imshow(apple);
title('Original apple image');
subplot(1,3,2);
imshow(apple_rec);
title('Reconstructed apple image');
subplot(1,3,3);
imshow(diff,[]);
title('Differences');
saveas(fig, 'imgs_q5/q5_apple_reconstructed.png','png');

orange_rec = imRecon(pyrLap_or, size(pyrLap_or,2), 1); 
diff = orange-orange_rec;

fig = figure('Position',[100 200 900 500]);
subplot(1,3,1);
imshow(orange);
title('Original orange image');
subplot(1,3,2);
imshow(orange_rec);
title('Reconstructed orange image');
subplot(1,3,3);
imshow(diff,[]);
title('Differences');
saveas(fig, 'imgs_q5/q5_orange_reconstructed.png','png');


%% (d) stitch 2 images together to obtain apple-orange

num_common_pixels = 2;

pyrLap_mix = imStitch(pyrLap_ap, pyrLap_or, levels, num_common_pixels);


fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrLap_mix{i},[]);
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrLap_mix{i},1),size(pyrLap_mix{i},2));
   title(title_txt);
end
saveas(fig, 'imgs_q5/q5_apple_orange_lapl.png','png');



apple_orange_rec = imRecon(pyrLap_mix, size(pyrLap_mix,2), 1); 

fig = figure();
imshow(apple_orange_rec);
title("Apple-Orange with 2 common pixels");
saveas(fig, 'imgs_q5/q5_apple_orange_lapl_1.png','png');


%% (e) compare to when the stitching has no common pixels

num_common_pixels = 0;

pyrLap_mix_2 = imStitch(pyrLap_ap, pyrLap_or, levels, num_common_pixels);


fig = figure();
for i=1:levels
   subplot(2,3,levels-i+1);
   imshow(pyrLap_mix_2{i},[]);
   title_txt = sprintf('n=%2.0f ; [%2.0fX%2.0f]', ...
       levels-i, size(pyrLap_mix_2{i},1),size(pyrLap_mix_2{i},2));
   title(title_txt);
end

apple_orange_rec2 = imRecon(pyrLap_mix_2, size(pyrLap_mix_2,2), 1); 

fig = figure();
imshow(apple_orange_rec2);
title("Apple-Orange with 0 common pixels");
saveas(fig, 'imgs_q5/q5_apple_orange_lapl_2.png','png');


% compare both versions


fig = figure('Position',[100 200 900 500]);
subplot(1,2,1);
imshow(apple_orange_rec);
title('Stitching with 2 common pixels');
subplot(1,2,2);
imshow(apple_orange_rec2);
title('Stitching with 0 common pixels');
saveas(fig, 'imgs_q5/q5_apple_orange_comp.png','png');













