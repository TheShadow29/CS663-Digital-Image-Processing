function [out_img] = myAHE(inp_img, wind)
% assume window to be integer, such that nxn neighborhood is taken
    tic;
    deviation = (wind-1)/2;
    [m, n] = size(inp_img);
    out_img = zeros(m,n);
    r2 = 1:m;
    c2 = 1:n;
    r2 = repmat(r2,m,1);
    c2 = repmat(c2,n,1);
    r2 = r2(:)';
    c2 = c2(:)';
    indexFcn = @ (r,c) inp_img(max(r - deviation, 1):min(r + deviation,m) , max(c -deviation, 1):min(c + deviation,n));
    tmp_img = arrayfun(indexFcn, r2,c2, 'UniformOutput', false);
    tmp_out_img = cellfun(@myHE, tmp_img,'UniformOutput', false);
    out_img_cell = cellfun(@(x) getMiddleElem(x,deviation), tmp_out_img);
    out_img(:) = out_img_cell(:);
    toc;
end