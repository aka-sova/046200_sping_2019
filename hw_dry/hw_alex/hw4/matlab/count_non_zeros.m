function non_zeros = count_non_zeros (img)

sizes = size(img);

img_cs = reshape(img, [sizes(1)*sizes(2),1] );

non_zeros = 0;
for pixel=1:length(img_cs(:))
    if (img_cs(pixel) ~= 0 )
        non_zeros = non_zeros +1;
        
    end
    
end

end

