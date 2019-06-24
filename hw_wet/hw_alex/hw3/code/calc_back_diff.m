function diff = calc_back_diff(arr)

    first_val = arr(1); % stays with no change
    
    arr_sh = circshift(arr, 1);
    
    diff = double(arr) - double(arr_sh);
    diff(1) = first_val;
end

