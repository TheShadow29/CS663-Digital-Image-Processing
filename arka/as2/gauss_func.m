function [val] = gauss_func(x,y,k,l,sig_s, sig_r, Ip,Iq)
    pow = (x-k/sig_s).^2 + (y-l/sig_s).^2 + (Ip-Iq/sig_r).^2;
    val = exp(-pow/2);
end
