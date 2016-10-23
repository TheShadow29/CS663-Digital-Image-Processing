function [out_img] = pca_part1(inp_img1)
    patch_s = 7;
    half_p = (patch_s - 1)/2;
    sigma = 20;
    inp_img = inp_img1 + uint8(randn(size(inp_img1))*sigma);
    inp_img = padarray(inp_img, [half_p,half_p]);
    [m,n] = size(inp_img);
    P =[];
    for i = half_p:m - half_p
        for j = half_p:n-half_p
            p = getNeighbourhoodWindow(inp_img, i, j, patch_s);
            p = p(:);
            P = [P p];
        end
    end
    [V, ~] = eig(P*P');
    [m1,n1] = size(P);
    alpha = V' * P;
    alpha1 = alpha.^2;
    alpha_s = max(0,sum(alpha1,2)/n1 - sigma^2);
    coeff = alpha_s/(sigma^2 + alpha_s);
    alpha_new = coeff * alpha;
    P1 = V * alpha_new;
%     for k = 1:n1
%         p1 = P1(:,k);
%         out1 = V * p1;
%         out1 = reshape(out1, patch_s, patch_s);
%         
%     end
    
    
end
