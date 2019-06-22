function rec_image = imRecon ( pyrLap, lvl_num, cur_lvl )


% using Laplasian pyramid, reconstruct the image


if (cur_lvl == lvl_num )
    % reached the top of pyramid
    rec_image = pyrLap{lvl_num - cur_lvl +1};
else 
    % find the Gaussian pyramid image
    
    rec_image = imRecon(pyrLap, lvl_num, cur_lvl+1); % returns G
    
    % expand the G image
    rec_image = impyramid(rec_image, 'expand');
    
    % add to the current laplasian
    rec_image = rec_image + pyrLap{lvl_num - cur_lvl +1} ; % sizes should match
end
    


end