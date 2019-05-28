function circle_img = draw_custom_circle(circle)

    % 1. create black img
    
    circle_img = zeros(circle.im_size);
    
    % build the radius levels
    
    circle_center = [circle.im_size/2, circle.im_size/2];
    
    for i=1:circle.im_size
        for j = 1:circle.im_size
            
            % find the radius from center
            p_distance = sqrt((i-circle_center(1))^2+(j-circle_center(2))^2);
            
            dist_difference = p_distance - circle.border_distances;
            dist_difference(dist_difference < 0 ) = NaN;
            [dist_val, dist_idx] = min(dist_difference);
            
            % find which value should be given
            
            gray_lvl = circle.gray_levels(dist_idx);
            
            circle_img(i,j) = gray_lvl;
            

        end
        
    end
      
    
    


end

