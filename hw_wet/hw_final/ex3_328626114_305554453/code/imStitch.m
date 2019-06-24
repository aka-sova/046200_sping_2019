function pyr_Lap_stitch = imStitch (pyrLap_1, pyrLap_2, lvl_num, num_common_pixels)

    % the function stitches 2 images together
    % images are of same size
    
    for lvl=1:lvl_num
        
        % merge images together
        size_x = size(pyrLap_1{lvl},2);
        pyr_Lap_stitch{lvl} = [pyrLap_1{lvl}(:,1:(end-(size_x/2))), ...
            pyrLap_2{lvl}(:,(size_x/2)+1:end)];
        
        % only on center common pixels - average their values between 2
        % images 
        
        direction = -1; % if expanding the common pixels, they grow sideways
        move_amount = 0;
        initial_common_col = size_x/2;
        current_common_col = initial_common_col;
        movement = direction*move_amount;

        
        for common_col=1:num_common_pixels

            % get the current common column
            current_common_col = initial_common_col + movement;
            % fprintf("current_common_col : %2.0f\n", current_common_col);
            
            
            % get average of all pixels in this column
            
            pyr_Lap_stitch{lvl}(:,current_common_col) = ...
                mean([pyrLap_1{lvl}(:,current_common_col), ...
                pyrLap_2{lvl}(:,current_common_col)],2);
            
            
            % advance the current common column
            move_amount = floor((common_col-1)/2)+1;
            movement = move_amount*direction;
            direction = direction * -1;

        end
        
        
        
    end




end