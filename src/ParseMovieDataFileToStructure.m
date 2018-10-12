function record = ParseMovieDataFileToStructure(file_path)
fid = fopen(file_path);
line = fgetl(fid);
append_path='C:/Users/Fluffy/Work/data/movies_data/';
ctr = 1;
record = struct;

% To avoid duplicates
nameMap = containers.Map();
genreMap = containers.Map();
invalidYear = [];

lineNum= -1; 


while(line)
    lineNum = lineNum + 1;
    contents = strsplit(line,'|');
    year = str2double(regexp(contents{3},'\d*','Match'));
%     year = str2double(strrep(strrep(strrep(strrep(contents{3},'(',' '),')',' '),'I',' '),' ',''));
    country = strsplit(contents{6},',');
        
    validCountry = 0;
    for i = 1:numel(country)
        if(strcmp(strrep(country{i},' ',''),'USA'))
            validCountry = 1;
            break
        end
    end
    
    if(~validCountry)
        line = fgetl(fid);
        continue;
    end
    
    if(isempty(year))
        invalidYear = [invalidYear lineNum];
        line = fgetl(fid);
        continue;
    end
    
    if(~isKey(nameMap, contents{1}))
        nameMap(contents{1}) = ctr;
    else
        valueArr = [nameMap(contents{1})];
        yearArr = [record(valueArr).release];
        if(isempty(find(yearArr == year)))
           valueArr = [valueArr ctr];
           nameMap(contents{1}) = valueArr;
        else
           line = fgetl(fid);
           continue;
        end
    end
    
    record.name{ctr} = contents{1};
    record.rating{ctr} = contents{2};
    record.release{ctr} = year;
    genres = strrep(strsplit(contents{4},','),' ','');
    record.genres{ctr} = genres;
    record.path{ctr} = [append_path contents{5}(3:end-1)];
    record.country{ctr} = strsplit(contents{6},',');
    
    
    for i = 1: numel(genres)
        genreWord = strrep(genres{i},' ','');
        if(~isKey(genreMap, genreWord))
            genreMap(genreWord) =  ctr;
        else
            valueArr = [genreMap(genreWord); ctr];
            genreMap(genreWord) = valueArr;
        end
    end
    line = fgetl(fid);
    ctr = ctr + 1;
    if(line == -1)
        break;
    end
end

% save('record', 'record');
% save('genreMap', 'genreMap');


end