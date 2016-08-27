function [out_img] = myBilateralFilter2(inp_img)
    [m, n] = size(inp_img);
    std_dev = 0.05 *( max(inp_img(:)) - min(inp_img(:)));
    noisy_img = inp_img + std_dev.*randn(m,n);
    
    sig_s = 0.5;
    sig_r = 0.5;
    
    x1 = 1:m;
    y1 = 1:n;
    I1 = 1:255;
    
    for i=1:m
        for j=1:n
            g_x = normpdf(x1,i,sig_s);
            g_y = normpdf(y1,j,sig_s);
            g_I = normpdf(I1, Ip, sig_r);
            g_xy = g_x' * g_y;
            
            WpIp = conv2(g, 
        end
    end
    
end
