function [out_img] = myBilateralFilteral(inp_img)
    [m, n] = size(inp_img);
    std_dev = 0.05 *( max(inp_img(:)) - min(inp_img(:)));
    noisy_img = inp_img + std_dev.*randn(m,n);
    
    
    sig_s = 0.5;
    sig_r = 0.5;
%     g_xy = zeros(1,m,n);
%     x1 = 1:n;
%     x2 = repmat(x1,m,1);
%     dis = x2.^2;
%     dis2 = dis + dis';
%     dis3 = sqrt(dis2);
%     I1 = 1:255;
%     g_xy(1,:,:) = normpdf(dis3,0,sig_s);

    x1 = 1:m;
    y1 = 1:n;
    I1 = 1:255;
    g_x = normpdf(x1, 0, sig_s);
    g_y = normpdf(y1, 0, sig_s);
    g_xy = g_x' * g_y;
    g_xy2 = g_xy(:);

    g_I = normpdf(I1,0,sig_r);
    
    g_xyI = g_xy2 * g_I;
    
%     noisy_img = uint8(noisy_img * 255);
    WpIp = conv2(double(g_xyI), double(noisy_img),'same');
    Wp = conv2(double(g_xyI), 1 , 'same');
    Ip = WpIp./Wp;
    
    Ip1 = reshape(Ip, m,n,255);
    
    out_img = Ip1;
    
end
