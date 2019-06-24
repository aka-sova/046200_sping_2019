function [fft_map] = create_fft_from_amp_phase(amp_matrix,phase_matrix)

    % input: amplitude matrix , phase matrix
    % output: fft matrix
    fft_map = amp_matrix.*exp(1i*phase_matrix);
end

