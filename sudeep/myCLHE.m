function [ out_img ] = myCLHE( inputImage, h )

    inp_hist = imhist(inputImage);
    inp_hist = double(inp_hist);
    [m n] = size(inputImage(:));
    inp_hist = inp_hist / m;    %get the pdf(r)
    mask = inp_hist>h;
    new_inp_hist = inp_hist.*(~mask) + mask.*h;
    reducedMass = 1 - sum(new_inp_hist);
    inp_hist_clahe = new_inp_hist + reducedMass/m;
    T = cumsum(inp_hist_clahe);
    
    out_img = T(inputImage+1);
    
    out_img = uint8(out_img * 255);  
end

