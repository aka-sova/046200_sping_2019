

function sampled_im = sample_image (image, sampling_rate)

    fprintf('Initialize sampling at : %2.0f\n', sampling_rate);

    % count the size of sampled image
    
    size_rows = round(size(image,1)/sampling_rate,0);
    size_cols = round(size(image,2)/sampling_rate,0);
    
    for row=1:size_rows
        for col=1:size_cols
            sampled_im(col,row) = image(1+((col-1)*sampling_rate), ...
                                1+((row-1)*sampling_rate));
        end

        if mod(row,10) == 0
           fprintf('%2.0f / %2.0f\n', row, size_rows);
        end
    end





end