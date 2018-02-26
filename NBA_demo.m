

clc
clear
close all
addpath('./utils')
%% prepare training data as standard form for classification 
% read source data and remove noisy bands with 'true'
data_file = fullfile('./data', 'traindata.mat');
if ~exist(data_file, 'file')
    % load HSI data with 8-bit quantization.
    [data,data_gt,band_index] = load_datasets('./data', true, 8);
    [train_data, train_label] = prepare_cls_data(data,data_gt);
    save(data_file, 'train_data', 'train_label', 'data', 'data_gt');
else
    load(data_file);
end
%% run Naive Bayes Algorithm on training dataset
% bayesian estimation is computed based on Maximum Likelihood Estimation (MLE)
[prob_prior, prob_condition] = Naive_Bayes(train_data, train_label, 'MLE');
MLE_classify_map = run_classification(data, prob_prior, prob_condition);

% bayesian estimation is computed based on Bayesian Estimation (BE)
[prob_prior, prob_condition] = Naive_Bayes(train_data, train_label, 'BE');
BE_classify_map = run_classification(data, prob_prior, prob_condition);

%% visualize
figure(1)
imagesc(data_gt);
colorbar;
title('Ground Truth of Hyperspectral Image');

figure(2)
imagesc(MLE_classify_map);
colorbar;
title('Classified Hyperspectral Image by Naive Bayes (with MLE)');

figure(3)
imagesc(BE_classify_map);
colorbar;
title('Classified Hyperspectral Image by Naive Bayes (with BE)');
