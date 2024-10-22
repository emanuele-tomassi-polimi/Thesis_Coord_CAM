function struct_CDM = read_CDM(filename)
% Read the whole CDM content
% -------------------------------------------------------------------------
% INPUTS:
% - filename: CDM filename
% -------------------------------------------------------------------------
% OUTPUT:
% - struct_CDM: strucuture containing CDM content, whose keys are the names
%               of the written variables. Structure fields are:
%                   - header
%                   - relative_metadata
%                   - object1_metadata_and_data
%                   - object2_metadata_and_data
% -------------------------------------------------------------------------
% Author:        Marco Felice Montaruli, Politecnico di Milano, 27 November 2020
%                e-mail: marcofelice.montaruli@polimi.it

fid=fopen(filename);
str = fgetl(fid);

while ischar(str) && ~feof(fid)
    
    
    % ------------------------------- Header ------------------------------
    header_struct = containers.Map;
    
    str=strrep(str,"="," ");
    str=strrep(str,"["," ");
    row_struct = split(str);
    key = row_struct{1};
    
    
    while ~strcmp(key,"TCA")
        
        if ~(strcmp(key,"COMMENT")||isempty(key))
            value = row_struct{2};
            header_struct(key) = value;
        end
        
        str = fgetl(fid);
        str=strrep(str,"="," ");
        str=strrep(str,"["," ");
        row_struct = split(str);
        key = row_struct{1};
        
    end
    
    % --------------------------- Relative metadata -----------------------
    relative_metadata_struct = containers.Map;
    
    str=strrep(str,"="," ");
    str=strrep(str,"["," ");
    row_struct = split(str);
    key = row_struct{1};
    
    while ~strcmp(key,"OBJECT")
        
        if ~(strcmp(key,"COMMENT")||isempty(key))
            value = row_struct{2};
            relative_metadata_struct(key) = value;
        end
        
        str = fgetl(fid);
        str=strrep(str,"="," ");
        str=strrep(str,"["," ");
        row_struct = split(str);
        key = row_struct{1};
        
    end
    
    
    % --------------------------- Object1 metadata ------------------------
    object1_metadata_and_data_struct = containers.Map;
    
    str = fgetl(fid);
    str=strrep(str,"="," ");
    str=strrep(str,"["," ");
    row_struct = split(str);
    key = row_struct{1};
    
    while ~strcmp(key,"OBJECT")
        
        if ~(strcmp(key,"COMMENT")||isempty(key))
            value = row_struct{2};
            object1_metadata_and_data_struct(key) = value;
        end
        
        if contains(str,'COMMENT Exclusion Volume Radius')
            value = row_struct{5};
            object1_metadata_and_data_struct('RADIUS') = value;
        end
        
        str = fgetl(fid);
        str=strrep(str,"="," ");
        str=strrep(str,"["," ");
        row_struct = split(str);
        key = row_struct{1};
        
    end
    
    % --------------------------- Object2 metadata ------------------------
    object2_metadata_and_data_struct = containers.Map;
    
    str = fgetl(fid);
    str=strrep(str,"="," ");
    str=strrep(str,"["," ");
    row_struct = split(str);
    key = row_struct{1};
    
    while ~feof(fid)
        
        if ~(strcmp(key,"COMMENT")||isempty(key))
            value = row_struct{2};
            object2_metadata_and_data_struct(key) = value;
        end
        
        if contains(str,'COMMENT Exclusion Volume Radius')
            value = row_struct{5};
            object2_metadata_and_data_struct('RADIUS') = value;
        end
        
        str = fgetl(fid);
        str=strrep(str,"="," ");
        str=strrep(str,"["," ");
        row_struct = split(str);
        key = row_struct{1};
        
    end
    
    if ~(strcmp(key,"COMMENT")||isempty(key))
        value = row_struct{2};
        object2_metadata_and_data_struct(key) = value;
    end
    
    
end

fclose(fid);

% Save in the overall structure
struct_CDM.header = header_struct;
struct_CDM.relative_metadata = relative_metadata_struct;
struct_CDM.object1_metadata_and_data = object1_metadata_and_data_struct;
struct_CDM.object2_metadata_and_data = object2_metadata_and_data_struct;

end