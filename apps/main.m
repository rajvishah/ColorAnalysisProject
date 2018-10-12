clear all; clc; close all;
addpath(genpath('../'));
pool = parpool;                      % Invokes workers
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel',1,'UseSubstreams',1,...
    'Streams',stream);

%% Load all movie data in records
list_file = '../data/new_corrected.txt';
database_path = '/home/rajvi/New_MAIN/';
% record = ParseMovieDataFileToStructure(list_file, database_path);

%% Save these data mats to intermediate storage
% save('../output/record', 'record');
load('../output/record','record');


%% Write search functions that retrieve index of the movies based on
% - Genre, GenrePair, GenreTriplet, CountryName, YearOfRelease
% index = FindMoviesWithFieldValues(record, 'genres', {'Animation'},[]);
index = 1:length(record.release);

%% Write Color Analysis Function that clusters retrieved data into relevant clusters
save_path = 'C:\Users\Fluffy\Work\data\movies_data\ColorCompressed\'
save_path = '/home/rajvi/IMDB_color/ColorCompressed/'
color_output = AnalyzeDominantColors(record, index, save_path);

%% Save these data mats to intermediate storage
save('color_output', 'color_output');
% load('record','record');
