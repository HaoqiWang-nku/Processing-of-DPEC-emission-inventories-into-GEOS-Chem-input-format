close all; clc; clear;

lon = linspace(70, 150, 80/0.25 );
lat = linspace(10, 60, 50/0.25 );


% years = {'2025','2030','2035','2040','2045','2050','2055','2060'};
% months = {'01','02','03','04','05','06','07','08','09','10','11','12'};

years = {'2030','2035','2040','2045','2050','2055','2060'};
months = {'01','02','03','04','05','06','07','08','09','10','11','12'};

for y = 1:length(years);
    for m = 1:length(months);
        % 设置当前的年份和月份
        year = years{y};
        month = months{m};
       % 定义物种列表
       species_list_for_SAPRC = {'ETOH' };
       species_list_for_GC = { 'EOH'  }; 
       numC =  {'2'};

       % 基础路径
       base_path = 'Z:\DEPC\v1.2\V1.2CB05\on-time_peak-net_zero-clean_air_CB05\on-time_peak-net_zero-clean_air\grid\on-time_peak-net_zero-clean_air';
       load('Z:\DEPC\v1.1\V1.1SAPRC99\China_area_matrix.mat');
       China_map=China_area_matrix';
       
       for i = 1:length(species_list_for_SAPRC)
           current_species = species_list_for_SAPRC{i};
             path{i}.agriculture= fullfile(base_path, year, [year '_' month '_agriculture_CB05_' current_species '.nc']);
             path{i}.industry= fullfile(base_path, year, [year '_' month '_industry_CB05_' current_species '.nc']);
             path{i}.power= fullfile(base_path, year, [year '_' month '_power_CB05_' current_species '.nc']);
             path{i}.residential= fullfile(base_path, year, [year '_' month '_residential_CB05_' current_species '.nc']);
             path{i}.transportation= fullfile(base_path, year, [year '_' month '_transportation_CB05_' current_species '.nc']);
       end
       % 输出路径
       
       for i = 1:length(species_list_for_SAPRC)
           agr_o{i} =ncread(path{i}.agriculture,'z');
           ind_o{i} =ncread(path{i}.industry,'z');
           pow_o{i} =ncread(path{i}.power,'z');
           res_o{i} =ncread(path{i}.residential,'z');
           tra_o{i} =ncread(path{i}.transportation,'z');
       end
       
       
       % 初始化存储重塑和镜像后数据的单元数组
       agr_o_reshaped = cell(1, length(species_list_for_SAPRC));
       ind_o_reshaped = cell(1, length(species_list_for_SAPRC));
       pow_o_reshaped = cell(1, length(species_list_for_SAPRC));
       res_o_reshaped = cell(1, length(species_list_for_SAPRC));
       tra_o_reshaped = cell(1, length(species_list_for_SAPRC));
       
       % 对每个物种的数据进行重塑和镜像操作
       for i = 1:length(species_list_for_SAPRC)
           agr_o_reshaped{i} = fliplr(reshape(agr_o{i}, 320, 200));
           ind_o_reshaped{i} = fliplr(reshape(ind_o{i}, 320, 200));
           pow_o_reshaped{i} = fliplr(reshape(pow_o{i}, 320, 200));
           res_o_reshaped{i} = fliplr(reshape(res_o{i}, 320, 200));
           tra_o_reshaped{i} = fliplr(reshape(tra_o{i}, 320, 200));
       end
       
       %单位转化  百万mol 网格-1 → kg m-2 s-1
       for i = 1:length(species_list_for_SAPRC)
           % 获取当前的numC值
           current_numC = str2double(numC{i});
           agr_f{i} = (agr_o_reshaped{i}).*current_numC.*12.*1000000./1000./China_map./31./24./3600;
           ind_f{i} = (ind_o_reshaped{i}).*current_numC.*12.*1000000./1000./China_map./31./24./3600;
           pow_f{i} = (pow_o_reshaped{i}).*current_numC.*12.*1000000./1000./China_map./31./24./3600;
           res_f{i} = (res_o_reshaped{i}).*current_numC.*12.*1000000./1000./China_map./31./24./3600;
           tra_f{i} = (tra_o_reshaped{i}).*current_numC.*12.*1000000./1000./China_map./31./24./3600;
       %     ind_t{i} = (ind_o_reshaped{i}).*1000000./China_map./31./24./3600;   
       %     ind_rate{i} = ind_t{i}./ind_f{i};
       end
       
       
       
       %NETCDF文件读写
       % 定义文件名
       outputFile = fullfile(['./DDDD_on-time_peak-net_zero-clean_air/MEIC_0.25_VOC_' year '_' month '.nc']);
       
       % 创建 NetCDF 文件
        ncid = netcdf.open(outputFile, 'NC_WRITE');

        % 定义维度
       % dimid_x = netcdf.defDim(ncid, 'lon', length(lon));
       % dimid_y = netcdf.defDim(ncid, 'lat', length(lat));
       
       % % 定义 lon 和 lat 变量
       % varid_lon = netcdf.defVar(ncid, 'lon', 'float', dimid_x);
       % varid_lat = netcdf.defVar(ncid, 'lat', 'float', dimid_y);      
       % 获取 lon 和 lat 维度的标识符
        dimid_lon = netcdf.inqDimID(ncid, 'lon');
        dimid_lat = netcdf.inqDimID(ncid, 'lat');
       
        % 切换到数据模式
        netcdf.reDef(ncid);

       % 循环遍历物种列表并定义变量
       for i = 1:length(species_list_for_GC)
           current_species = species_list_for_GC{i};
          
           
           % 定义当前物种的变量名
           var_name_agr = [current_species '_agriculture'];
           var_name_ind = [current_species '_industry'];
           var_name_pow = [current_species '_power'];
           var_name_res = [current_species '_residential'];
           var_name_tra = [current_species '_transportation'];

               % 获取当前文件中的变量信息
                 info = ncinfo(outputFile);
                 existing_vars = {info.Variables.Name};
              
                 % 检查当前变量名是否已经存在
                 if ismember(var_name_agr, existing_vars) || ...
                    ismember(var_name_ind, existing_vars) || ...
                    ismember(var_name_pow, existing_vars) || ...
                    ismember(var_name_res, existing_vars) || ...
                    ismember(var_name_tra, existing_vars)
                     error('Variable name already in use. Choose a different name.');
                 end


    
            % 定义当前变量
            varid_current_agr = netcdf.defVar(ncid, var_name_agr, 'float', [dimid_lon, dimid_lat]);
            varid_current_ind = netcdf.defVar(ncid, var_name_ind, 'float', [dimid_lon, dimid_lat]);
            varid_current_pow = netcdf.defVar(ncid, var_name_pow, 'float', [dimid_lon, dimid_lat]);
            varid_current_res = netcdf.defVar(ncid, var_name_res, 'float', [dimid_lon, dimid_lat]);
            varid_current_tra = netcdf.defVar(ncid, var_name_tra, 'float', [dimid_lon, dimid_lat]);
        
            % 添加单位属性为 "kgC/m2/s"
            netcdf.putAtt(ncid, varid_current_agr, 'units', 'kgC/m2/s');
            netcdf.putAtt(ncid, varid_current_ind, 'units', 'kgC/m2/s');
            netcdf.putAtt(ncid, varid_current_pow, 'units', 'kgC/m2/s');
            netcdf.putAtt(ncid, varid_current_res, 'units', 'kgC/m2/s');
            netcdf.putAtt(ncid, varid_current_tra, 'units', 'kgC/m2/s');
        end
        
        % 结束定义模式
        netcdf.endDef(ncid);
        
        % 写入 lon 和 lat 数据（这部分数据只需要写入一次）
        % netcdf.putVar(ncid, varid_lon, lon);
        % netcdf.putVar(ncid, varid_lat, lat);
        
        %         % 循环遍历物种列表并写入数据
        for i = 1:length(species_list_for_GC)
            current_data_agr = agr_f{i};
            var_name_agr = [species_list_for_GC{i} '_agriculture'];
            varid_current_agr = netcdf.inqVarID(ncid, var_name_agr); % 获取变量ID
            netcdf.putVar(ncid, varid_current_agr, current_data_agr); % 写入数据
          
            current_data_ind = ind_f{i};
            var_name_ind = [species_list_for_GC{i} '_industry'];
            varid_current_ind = netcdf.inqVarID(ncid, var_name_ind); % 获取变量ID
            netcdf.putVar(ncid, varid_current_ind, current_data_ind); % 写入数据

            current_data_pow = pow_f{i};
            var_name_pow = [species_list_for_GC{i} '_power'];
            varid_current_pow = netcdf.inqVarID(ncid, var_name_pow); % 获取变量ID
            netcdf.putVar(ncid, varid_current_pow, current_data_pow); % 写入数据

            current_data_res = res_f{i};
            var_name_res = [species_list_for_GC{i} '_residential'];
            varid_current_res = netcdf.inqVarID(ncid, var_name_res); % 获取变量ID
            netcdf.putVar(ncid, varid_current_res, current_data_res); % 写入数据

            current_data_tra = tra_f{i};
            var_name_tra = [species_list_for_GC{i} '_transportation'];
            varid_current_tra = netcdf.inqVarID(ncid, var_name_tra); % 获取变量ID
            netcdf.putVar(ncid, varid_current_tra, current_data_tra); % 写入数据
        end
		
		file2_path = 'Z:\DEPC\MEIC\v2022-12\MEIC_0.25_NonVOC_and_VOC_2018_01.nc';

		% 从第二个文件中读取经纬度信息
		lon_new = ncread(file2_path, 'lon');
		lat_new = ncread(file2_path, 'lat');
		
		% 获取经度和纬度的单位
		lon_unit = ncreadatt(file2_path, 'lon', 'units');
		lat_unit = ncreadatt(file2_path, 'lat', 'units');


        % 读取新的经纬度信息及其单位
        new_file_path = fullfile(outputFile);

        
        % 将第一个文件中的经纬度替换为第二个文件中的值
        ncwrite(new_file_path, 'lon', lon_new);
        ncwrite(new_file_path, 'lat', lat_new);
        
        % 将新的单位信息写入第一个文件
        ncwriteatt(new_file_path, 'lon', 'units', lon_unit);
        ncwriteatt(new_file_path, 'lat', 'units', lat_unit);
        
        % 显示替换结果
        disp(['已替换文件: ', outputFile]);
		
        % 关闭NetCDF文件
        netcdf.close(ncid);

    end
end
