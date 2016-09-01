function [weights] = getPatch_weights(patch, i, j, window_around_pixel, window_around_P, sigma_r)
    [m,n] = size(patch);
    del_q = (window_around_pixel - 1)/2;
    del_P = (window_around_P - 1)/2;    
    I_p_mat = getNeighbourhoodWindow(patch, del_P + del_q, del_P + del_q, window_around_pixel);
    I_p_vec = I_p_mat(:);
    
    weights = zeros(window_around_P);
    
    
    
      
    for k = 1:window_around_P
        for l = 1:window_around_P
            I_q = getNeighbourhoodWindow(patch, k,l, window_around_pixel);
            I_q_vec = I_q(:);
            if (size(I_q) ~= size(I_p_vec))
                
                I_q_vec = padarray(I_q_vec, size(I_p_vec) - size(I_q_vec), 'pre');
            end
            
            diff = norm(I_q_vec - I_p_vec);
            weights(k,l) = normpdf(diff,0,sigma_r);
            
        end
    end
    
end