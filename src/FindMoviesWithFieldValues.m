function index = FindMoviesWithFieldValues(record, field_name, values, sub_index)
if(isempty(sub_index))
    sub_index = 1:length(record.release);
end

if(isfield(record, field_name))
    if(strcmp(field_name, 'release'))
        data = record.release(sub_index);
        index = find(data == values);
    elseif(strcmp(field_name, 'country'))
        data = record.country(sub_index);
        index = CompareStringCellToStringCellArray(data, values);
    elseif(strcmp(field_name, 'rating'))
        if(length(values) == 1)
            index = find(record.release >= values);
        elseif(length(values) == 2)
            index = find(record.release >= values(1) && record.release <= values(2));
        end
    elseif(strcmp(field_name, 'genres'))
        data = record.genres(sub_index);
        index = CompareStringCellToStringCellArray(data, values);   
    end
end

end

function index = CompareStringCellToStringCellArray(data, values) 
index = [];
for i=1:length(data)
    for j=1:length(values)
        if(any(strcmp(data{i},values{j})))
            index = [index i];
        end
    end
end
end