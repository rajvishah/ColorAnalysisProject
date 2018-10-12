function I = MakeColorPaletteImage(colors, freq, cut_off)
% Visualize palettes
[sorted_freq,idx] = sort(freq, 'descend');
sorted_colors = colors(idx, :);

I = zeros(cut_off*1000, 100);
sum_frac = 0;
count = 1;
last_pos = 0;

while(sum_frac < cut_off)    
    start_pos = last_pos + 1;
    last_pos = floor(start_pos + sorted_freq(count)*1000);
    I(start_pos:last_pos, 1:end, 1) = sorted_colors(count,1)/255;
    I(start_pos:last_pos, 1:end, 2) = sorted_colors(count,2)/255;
    I(start_pos:last_pos, 1:end, 3) = sorted_colors(count,3)/255;
    
    sum_frac = sum_frac + sorted_freq(count);
    count = count + 1;
end


end