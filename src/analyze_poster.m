function output = analyze_poster(file_path, save_path)
main_palette = csvread('data/main_palette.txt');
output = [];
try
    input_image = imread(file_path);
catch
    fprintf('%s', ['File not openable ' file_path]);
    return
end

if(numel(size(input_image)) ~= 3)
    fprintf('%s', ['File not in color ' file_path]); 
    return
end

[I, map, palette, pcount] = KMeansColorReduction(input_image, 32);

% match palettes in alternate color spaces
% source_palette = rgb2lab(palette);
% reference_palette = rgb2lab(main_palette);
% 
% source_palette = rgb2lab(palette);
% reference_palette = rgb2lab(main_palette);
% 
source_palette = palette;
reference_palette = main_palette;

I_safe_r = uint8(zeros(size(map)));
I_safe_g = uint8(zeros(size(map)));
I_safe_b = uint8(zeros(size(map)));
safe_palette_freq_table = zeros([size(main_palette,1) 1]);

for i=1:size(palette,1)
%     weight_vec = [0 0.5 0.5];
    weight_vec = [1 1 1];
    curr_col_mat = repmat(source_palette(i,:), [size(reference_palette,1) 1]);
    weight_mat = repmat(weight_vec, [size(reference_palette,1) 1]);

%     diff_vec = sum((reference_palette' - curr_col_mat').^2);
%     weight_vec = [1/3 1/3 1/3];
   
    diff_vec = sum(weight_mat'.*(reference_palette' - curr_col_mat').^2);
    
    [~, best_match] = min((diff_vec));
    main_palette_idx(i) = best_match;
    idx = find(map == i);
    safe_palette_freq_table(best_match) = safe_palette_freq_table(best_match) + length(idx);
%     [id1,id2] = ind2sub(size(I(:,:,1)),idx);
    I_safe_r(idx) = main_palette(best_match,1);
    I_safe_g(idx) = main_palette(best_match,2);
    I_safe_b(idx) = main_palette(best_match,3);
    
    I_safe = cat(3, reshape(I_safe_r, size(I(:,:,1))),...
        reshape(I_safe_g, size(I(:,:,1))),...
        reshape(I_safe_b, size(I(:,:,1))));
    
end

% figure; subplot(1,3,1); imshow(imread(file_path));subplot(1,3,2); imshow(uint8(I)); subplot(1,3,3); imshow(uint8(I_safe))

safe_palette_freq_table = safe_palette_freq_table/length(map);
safe_palette_with_freq = [main_palette safe_palette_freq_table];
safe_palette_with_sorted_freq = sortrows(safe_palette_with_freq, 4, 'descend');

clustered_palette_with_freq = [palette pcount'/length(map)];
clustered_palette_with_sorted_freq = sortrows(clustered_palette_with_freq, 4, 'descend');

if(~isempty(save_path))
    [~,name,ext] = fileparts(file_path);
    imwrite(I,[save_path '/' name '_clustered' ext]);
    imwrite(I_safe,[save_path '/' name '_safe' ext]);
    csvwrite([save_path '/clustered_palette_histogram.txt'], clustered_palette_with_sorted_freq);
    csvwrite([save_path '/safe_palette_histogram.txt'], safe_palette_with_sorted_freq);
end

% colI1 = MakeColorPaletteImage(palette,pcount, 0.99);
% colI2 = MakeColorPaletteImage(safe_palette_with_freq(:,1:3),...
%     safe_palette_with_freq(:,4), 0.99);
% 
% output.colmap_orig = colI1;
% output.colmap_quant = colI2;
% output.c_palette = clustered_palette_with_sorted_freq;
% output.s_palette = safe_palette_with_sorted_freq;
