function entropy = calc_im_entropy(image)

    % 1. build the histogram with 256 bins
    
    num_bins = 256;
    im_hist = imhist(image,num_bins);

    total_pixels = sum(im_hist); % should be equal to MXN of image

    total_entropy = 0;
    
    for value=1:num_bins
        if im_hist(value)>0
            local_probability = im_hist(value)/total_pixels;
            local_entropy = local_probability * log2(local_probability);
            total_entropy(end+1) = total_entropy(end) - local_entropy;
        end
    end
    entropy = total_entropy(end);

end

