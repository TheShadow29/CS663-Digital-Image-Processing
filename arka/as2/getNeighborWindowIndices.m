function [indices] = getNeighborWindowIndices(inp_img, i, j, window_size)
    area = size(inp_img);
    length = (window_size - 1)/2;
    A = 1:area(1)*area(2);
    A = reshape(A, area(1), area(2));
    indices = A( max(1,i - length) : min(area(1),i + length) , max(1,j - length) : min(area(2),j + length) );
    indices = indices(:);
end