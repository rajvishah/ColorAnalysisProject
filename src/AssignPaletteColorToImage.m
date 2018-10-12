function out = AssignPaletteColorToImage(palette, idx, im_size)
n_channels = 1;
if(numel(im_size) == 3)
    n_channels = 3;
end
out = uint8(zeros(im_size));
for i=1:n_channels
    arr = uint8(zeros(size(idx)));
    arr(idx) = palette(idx, i);
    im = reshape(arr(idx), [im_size(1) im_size(2)]);
    out(:,:,i) = im;
end
end