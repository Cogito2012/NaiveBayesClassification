function [data,data_gt,band_index] = load_datasets(datapath, remove, bit)
% prepare_data 
if nargin < 2, remove = false; end
if nargin < 3, bit = 8; end

data_folder = fullfile(datapath,'Indian Pines');
load(fullfile(data_folder,'Indian_pines.mat'));
load(fullfile(data_folder,'Indian_pines_gt.mat'));

band_index = [1:size(indian_pines,3)];
if remove
    % We remove the following hyperspectral bands as the E-FDPC's
    % authors's suggestion. For the bands 221-224, they are zero bands 
    % and not included in source data files.
    % Reference:
    % S. Jia, G. Tang, J. Zhu, and Q. Li, "A Novel Ranking-Based 
    % Clustering Approach for Hyperspectral Band Selection," IEEE Trans. 
    % Geosci. Remote Sens., vol. 54, no. 1, pp. 88-102, 2016.
    remove_bands = [1:3,103:112,148:165,217:220]; 
    band_index(remove_bands) = [];
    preserved_num = length(band_index);
    data(:,:,1:preserved_num) = indian_pines(:,:,band_index);
else
    data = indian_pines;
end
for i=1:size(data, 3)
    data_channel = data(:,:,i);
    data_channel = round( data_channel ./ max(max(data_channel)) .* (2^(bit)-1));
    data(:,:,i) = data_channel;
end

data_gt = indian_pines_gt;
clear indian_pines;
