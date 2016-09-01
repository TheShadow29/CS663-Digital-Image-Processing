function [points, R, Ix, Iy, E1, E2] = myHarrisCornerDetector(inp_img1)
    inp_img = double(inp_img1)/255;
    [m,n] = size(inp_img);
    sigma_x = 1;
    sigma_y = 1;
    k = 0.1;
    threshold = 0.2;
    Gx = [1 2 1; 0 0 0; -1 -2 -1];
    Gy = Gx';
    Ix = conv2(inp_img, Gx, 'same');
    Iy = conv2(inp_img, Gy, 'same');
    
    Ix2 = Ix * Ix;
    Iy2 = Iy * Iy;
    Ixy = Ix * Iy;
    
    x1 = 1:3;
    y1 = 1:3;
    g_x = normpdf(x1, 0, sigma_x);
    g_y = normpdf(y1, 0, sigma_y);
    
    Gxy = g_x' * g_y;
    
    Sx2 = conv2(Ix2, Gxy, 'same');
    Sy2 = conv2(Iy2, Gxy, 'same');
    Sxy = conv2(Ixy, Gxy, 'same');
    
    R = zeros(m,n);
    E1 = zeros(m,n);
    E2 = zeros(m,n);
    points = [];
    for i=1:m
        for j=1:n
            A = [Sx2(i,j), Sxy(i,j); Sxy(i,j) , Sy2(i,j)];
            eig_vals = eig(A);
            E1(i,j) = eig_vals(1);
            E2(i,j) = eig_vals(2);
            R(i,j) = det(A) - k*(trace(A))^2;
            
            if (R(i,j) > threshold)
                p = [i,j];
                points = [points;p];
            end
            
        end
    end      
       
    points = points';
    figure; imshow(inp_img);
    hold on;
    plot(points(2,:), points(1,:), 'go');
    hold off;
    
    
    
end
