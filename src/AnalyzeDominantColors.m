function features = AnalyzeDominantColors(record, index, save_path)
addpath('lib');
for i=1:length(index)
    i
    tic
    file_path_cell = record.path(index(i));
    features{i} = analyze_poster(file_path_cell{1}, save_path);
    toc
end