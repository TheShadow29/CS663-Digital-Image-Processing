function [out_img] = myUnsharpMasking(inp_img, hsize, sigma)
    h = fspecial('log', hsize, sigma);
    out_1 = imfilter(inp_img, h);
    out_2 = out_1 - min(out_1(:));
    out_2 = out_2 / (max(out_2(:)));
    out_img = out_2;
    figure; imshow(inp_img);
    figure; imshow(out_img);
end