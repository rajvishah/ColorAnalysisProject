clear all; clc; close all;

%% Load all movie data in records
list_file = 'data/new_corrected.txt';
% record = ParseMovieDataFileToStructure(list_file);

%% Save these data mats to intermediate storage
% save('record', 'record');
load('record','record');


%% Write search functions that retrieve index of the movies based on
% - Genre, GenrePair, GenreTriplet, CountryName, YearOfRelease
% index = FindMoviesWithFieldValues(record, 'genres', {'Animation'},[]);
index = 1:length(record.release);

%% Write Color Analysis Function that clusters retrieved data into relevant clusters
save_path = 'C:\Users\Fluffy\Work\data\movies_data\ColorCompressed\'
color_output = AnalyzeDominantColors(record, index, save_path);

%% Save these data mats to intermediate storage
save('color_output', 'color_output');
% load('record','record');
