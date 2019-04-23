function [corrected_image] = apply_gamma_correction(img,c,gamma,is_uint8)

    % img should be in uint8
    
    img_reshaped = reshape(img,length(img(:)),1);
    
    if ( is_uint8 ) 
        img_reshaped = im2double(img_reshaped);
    end
    
    rows = length(img(:,1));
    cols = length(img(1,:));
    corrected_image = reshape((c*img_reshaped.^gamma),rows,cols);
    
    if ( is_uint8 ) 
    	corrected_image = uint8(255*corrected_image);
    end

end

