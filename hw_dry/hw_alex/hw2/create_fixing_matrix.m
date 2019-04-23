function [fixing_matrix] = create_fixing_matrix(image_size,failed_pixels)

% image_size is a 2d vector - X length, Y length
% failed_pixels is a structure which contains 2d coordinated of failed
% pixels

% fixing matrix is a diagonal matrix
% which is multiplied on the column image
% pixels which are failed have 0.5 coefficient
% others have 1

column_vector_length = image_size(1) * image_size(2);

ones_vec  = ones(column_vector_length,1);
fixing_matrix = diag(ones_vec);

for i=1:numel(failed_pixels)
    
    x_coor = failed_pixels{i}(1);
    y_coor = failed_pixels{i}(2);
    
    col_vector_placement = (y_coor-1)*image_size(1)+x_coor;
    
    fprintf('\nfound failed pixel at placement %2.0f\n',col_vector_placement);
    fixing_matrix(col_vector_placement,col_vector_placement) = 0.5;
end



end

