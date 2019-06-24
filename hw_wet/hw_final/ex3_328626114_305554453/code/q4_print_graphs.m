




fig1 = figure('Position',[488   133   460   628]);
subplot(2,1,1)
imshow(color_img);
title('Original image');
subplot(2,1,2)
imshow(dataout);
title_txt = sprintf('Quantized image (levels = %2.0f)', levels);
title(title_txt);
file_name = sprintf('imgs_q4/q4_quantized_levels_%1.0f_init_%1.0f',levels,initialization);
saveas(fig1, file_name,'png');

fig2 = figure();
plot(distortion);
title_txt = sprintf('Distortion of a quantization (levels = %2.0f)', levels);
title(title_txt);
xlabel('Iteration');
ylabel('D_m');
grid on
file_name = sprintf('imgs_q4/q4_distortion_levels_%1.0f_init_%1.0f', levels, initialization);
saveas(fig2, file_name,'png');

fig2 = figure();
plot(eps);
title_txt = sprintf('Minimal relative improvement (levels = %2.0f)', levels);
title(title_txt);
xlabel('Iteration');
ylabel('Epsilon');
grid on
file_name = sprintf('imgs_q4/q4_epsilon_levels_%1.0f_init_%1.0f', levels, initialization);
saveas(fig2, file_name,'png');