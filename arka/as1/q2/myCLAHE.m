function [out_img] = myCLAHE(inp_img, h, N)
    [m, n] = size(inp_img);
    out_img = zeros(m,n);
    deviation = (N+1)/2;
    tic;
    for i=1:m
        for j=1:n
            tmp_img = getNeighbourhoodWindow(inp_img, i, j, N);
            tmp_out_img = myCLHE(tmp_img+1, h);
            out_img(i,j) = tmp_out_img(min(i,deviation),min(j, deviation));
        end
    end
    out_img = uint8(out_img);
    toc;
    
end
