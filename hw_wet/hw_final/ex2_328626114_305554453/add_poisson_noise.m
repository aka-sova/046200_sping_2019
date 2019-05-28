function [out_img] = add_poisson_noise(input_img)

    % add the poisson noise as stated in question.
    
    a = 5;
    img = uint16(input_img);
    img = img*a;
    
    img = imnoise(img,'poisson');
    
    img = img/a;
    
    % clipping
    img(img>250) = 250;
    
    out_img = uint8(img);

end

