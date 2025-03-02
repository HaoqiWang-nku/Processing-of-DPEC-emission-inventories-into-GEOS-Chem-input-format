close all; clc; clear;

% 定义文件夹路径
directory = 'Z:\李嘉城硕士论文\DEPC\v1.2\V1.2SAPRC99\on-time_peak-net_zero-clean_air_SAPRC99\on-time_peak-net_zero-clean_air\grid\on-time_peak-net_zero-clean_air\DDDD_2025_on-time_peak-net_zero-clean_air\';

% 文件名列表（根据实际情况更改文件名的获取方式）
files = { 
'MEIC_0.25_NonVOC_2020_01.nc',
'MEIC_0.25_NonVOC_2020_02.nc',
'MEIC_0.25_NonVOC_2020_03.nc',
'MEIC_0.25_NonVOC_2020_04.nc',
'MEIC_0.25_NonVOC_2020_05.nc',
'MEIC_0.25_NonVOC_2020_06.nc',
'MEIC_0.25_NonVOC_2020_07.nc',
'MEIC_0.25_NonVOC_2020_08.nc',
'MEIC_0.25_NonVOC_2020_09.nc',
'MEIC_0.25_NonVOC_2020_10.nc',
'MEIC_0.25_NonVOC_2020_11.nc',
'MEIC_0.25_NonVOC_2020_12.nc',
'MEIC_0.25_NonVOC_2025_01.nc',
'MEIC_0.25_NonVOC_2025_02.nc',
'MEIC_0.25_NonVOC_2025_03.nc',
'MEIC_0.25_NonVOC_2025_04.nc',
'MEIC_0.25_NonVOC_2025_05.nc',
'MEIC_0.25_NonVOC_2025_06.nc',
'MEIC_0.25_NonVOC_2025_07.nc',
'MEIC_0.25_NonVOC_2025_08.nc',
'MEIC_0.25_NonVOC_2025_09.nc',
'MEIC_0.25_NonVOC_2025_10.nc',
'MEIC_0.25_NonVOC_2025_11.nc',
'MEIC_0.25_NonVOC_2025_12.nc',
'MEIC_0.25_NonVOC_2030_01.nc',
'MEIC_0.25_NonVOC_2030_02.nc',
'MEIC_0.25_NonVOC_2030_03.nc',
'MEIC_0.25_NonVOC_2030_04.nc',
'MEIC_0.25_NonVOC_2030_05.nc',
'MEIC_0.25_NonVOC_2030_06.nc',
'MEIC_0.25_NonVOC_2030_07.nc',
'MEIC_0.25_NonVOC_2030_08.nc',
'MEIC_0.25_NonVOC_2030_09.nc',
'MEIC_0.25_NonVOC_2030_10.nc',
'MEIC_0.25_NonVOC_2030_11.nc',
'MEIC_0.25_NonVOC_2030_12.nc',
'MEIC_0.25_NonVOC_2035_01.nc',
'MEIC_0.25_NonVOC_2035_02.nc',
'MEIC_0.25_NonVOC_2035_03.nc',
'MEIC_0.25_NonVOC_2035_04.nc',
'MEIC_0.25_NonVOC_2035_05.nc',
'MEIC_0.25_NonVOC_2035_06.nc',
'MEIC_0.25_NonVOC_2035_07.nc',
'MEIC_0.25_NonVOC_2035_08.nc',
'MEIC_0.25_NonVOC_2035_09.nc',
'MEIC_0.25_NonVOC_2035_10.nc',
'MEIC_0.25_NonVOC_2035_11.nc',
'MEIC_0.25_NonVOC_2035_12.nc',
'MEIC_0.25_NonVOC_2040_01.nc',
'MEIC_0.25_NonVOC_2040_02.nc',
'MEIC_0.25_NonVOC_2040_03.nc',
'MEIC_0.25_NonVOC_2040_04.nc',
'MEIC_0.25_NonVOC_2040_05.nc',
'MEIC_0.25_NonVOC_2040_06.nc',
'MEIC_0.25_NonVOC_2040_07.nc',
'MEIC_0.25_NonVOC_2040_08.nc',
'MEIC_0.25_NonVOC_2040_09.nc',
'MEIC_0.25_NonVOC_2040_10.nc',
'MEIC_0.25_NonVOC_2040_11.nc',
'MEIC_0.25_NonVOC_2040_12.nc',
'MEIC_0.25_NonVOC_2045_01.nc',
'MEIC_0.25_NonVOC_2045_02.nc',
'MEIC_0.25_NonVOC_2045_03.nc',
'MEIC_0.25_NonVOC_2045_04.nc',
'MEIC_0.25_NonVOC_2045_05.nc',
'MEIC_0.25_NonVOC_2045_06.nc',
'MEIC_0.25_NonVOC_2045_07.nc',
'MEIC_0.25_NonVOC_2045_08.nc',
'MEIC_0.25_NonVOC_2045_09.nc',
'MEIC_0.25_NonVOC_2045_10.nc',
'MEIC_0.25_NonVOC_2045_11.nc',
'MEIC_0.25_NonVOC_2045_12.nc',
'MEIC_0.25_NonVOC_2050_01.nc',
'MEIC_0.25_NonVOC_2050_02.nc',
'MEIC_0.25_NonVOC_2050_03.nc',
'MEIC_0.25_NonVOC_2050_04.nc',
'MEIC_0.25_NonVOC_2050_05.nc',
'MEIC_0.25_NonVOC_2050_06.nc',
'MEIC_0.25_NonVOC_2050_07.nc',
'MEIC_0.25_NonVOC_2050_08.nc',
'MEIC_0.25_NonVOC_2050_09.nc',
'MEIC_0.25_NonVOC_2050_10.nc',
'MEIC_0.25_NonVOC_2050_11.nc',
'MEIC_0.25_NonVOC_2050_12.nc',
'MEIC_0.25_NonVOC_2055_01.nc',
'MEIC_0.25_NonVOC_2055_02.nc',
'MEIC_0.25_NonVOC_2055_03.nc',
'MEIC_0.25_NonVOC_2055_04.nc',
'MEIC_0.25_NonVOC_2055_05.nc',
'MEIC_0.25_NonVOC_2055_06.nc',
'MEIC_0.25_NonVOC_2055_07.nc',
'MEIC_0.25_NonVOC_2055_08.nc',
'MEIC_0.25_NonVOC_2055_09.nc',
'MEIC_0.25_NonVOC_2055_10.nc',
'MEIC_0.25_NonVOC_2055_11.nc',
'MEIC_0.25_NonVOC_2055_12.nc',
'MEIC_0.25_NonVOC_2060_01.nc',
'MEIC_0.25_NonVOC_2060_02.nc',
'MEIC_0.25_NonVOC_2060_03.nc',
'MEIC_0.25_NonVOC_2060_04.nc',
'MEIC_0.25_NonVOC_2060_05.nc',
'MEIC_0.25_NonVOC_2060_06.nc',
'MEIC_0.25_NonVOC_2060_07.nc',
'MEIC_0.25_NonVOC_2060_08.nc',
'MEIC_0.25_NonVOC_2060_09.nc',
'MEIC_0.25_NonVOC_2060_10.nc',
'MEIC_0.25_NonVOC_2060_11.nc',
'MEIC_0.25_NonVOC_2060_12.nc',
    % 继续列出其他文件...
};

% 遍历每个文件
for i = 1:length(files)
    % 构建文件的完整路径
    filepath = fullfile(directory, files{i});
    
    % 读取需要的变量
    PMFINE_agriculture = ncread(filepath, 'PMFINE_agriculture');
    PMFINE_industry = ncread(filepath, 'PMFINE_industry');
    PMFINE_power = ncread(filepath, 'PMFINE_power');
    PMFINE_residential = ncread(filepath, 'PMFINE_residential');
    PMFINE_transportation = ncread(filepath, 'PMFINE_transportation');
    
    OC_agriculture = ncread(filepath, 'OC_agriculture');
    OC_industry = ncread(filepath, 'OC_industry');
    OC_power = ncread(filepath, 'OC_power');
    OC_residential = ncread(filepath, 'OC_residential');
    OC_transportation = ncread(filepath, 'OC_transportation');
    
    BC_agriculture = ncread(filepath, 'BC_agriculture');
    BC_industry = ncread(filepath, 'BC_industry');
    BC_power = ncread(filepath, 'BC_power');
    BC_residential = ncread(filepath, 'BC_residential');
    BC_transportation = ncread(filepath, 'BC_transportation');
    
    % 计算新的 PMFINE 值，并确保不小于0
    New_PMFINE_agriculture = PMFINE_agriculture - BC_agriculture - 1.6 .* OC_agriculture;
    New_PMFINE_industry = PMFINE_industry - BC_industry - 1.6 .* OC_industry;
    New_PMFINE_power = PMFINE_power - BC_power - 1.6 * OC_power;
    New_PMFINE_residential = PMFINE_residential - BC_residential - 1.6 .* OC_residential;
    New_PMFINE_transportation = PMFINE_transportation - BC_transportation - 1.6 .* OC_transportation;
    
    % 强制小于0的值为0
    New_PMFINE_agriculture(New_PMFINE_agriculture < 0) = 0;
    New_PMFINE_industry(New_PMFINE_industry < 0) = 0;
    New_PMFINE_power(New_PMFINE_power < 0) = 0;
    New_PMFINE_residential(New_PMFINE_residential < 0) = 0;
    New_PMFINE_transportation(New_PMFINE_transportation < 0) = 0;
    % 强制大于10^10的值为0
    New_PMFINE_transportation(New_PMFINE_transportation > 10^10) = 0;

    % 更新 NetCDF 文件中的变量
    ncwrite(filepath, 'PMFINE_agriculture', New_PMFINE_agriculture);
    ncwrite(filepath, 'PMFINE_industry', New_PMFINE_industry);
    ncwrite(filepath, 'PMFINE_power', New_PMFINE_power);
    ncwrite(filepath, 'PMFINE_residential', New_PMFINE_residential);
    ncwrite(filepath, 'PMFINE_transportation', New_PMFINE_transportation);
    
end

disp('所有文件已成功处理！');
