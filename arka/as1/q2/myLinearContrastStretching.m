function [y] = myLinearContrastStretching(x, a, b, c, d)
    y = x;
    x1 = (x > 0) & (x < a);
    y(x1) = b/a * x(x1);
    x2 = (x >= a) & (x<=c);
    y(x2) = (d - b) * x(x2) / (c -a) + b - (d - b) * a / (c -a);
    x3 = (x > c) & (x <= 255);
    y(x3) = (255 - d) * x(x3)/(255 - c) + d - (255 - d) * c/(255 - c); 
    y = uint8(y);
    
end