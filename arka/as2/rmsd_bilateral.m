function [rms_val] = rmsd_bilateral(A,B)
    [m, n] = size(A);
    diff = A - B;
    diff = diff.^2;
    diff_sum = sum(diff(:));
    diff_avg = diff_sum/(m*n);
    
    rms_val = sqrt(diff_avg);    
end
