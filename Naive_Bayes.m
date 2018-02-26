function [ prob_prior, prob_condition ] = Naive_Bayes( train_data, train_label, estimator, featval_num)

if nargin < 3, estimator = 'MLE'; end  % choice: MLE (default), Bayes
if nargin < 4, featval_num = 256; end  % number of possible feature values
featval_set = [1:featval_num] - 1;       % the possible values [0,1,...,255]
lambda = 1;

%% compute prior distribution
class_ids = unique(train_label);
class_num = length(class_ids);
prob_prior = zeros(class_num, 1);
for i=1:class_num
    idx = find(train_label == class_ids(i));
    prob_prior(i) = prob_prior(i) + length(idx);
end
[sample_num, feature_num] = size(train_data);
if strcmp(estimator, 'MLE')
    prob_prior = prob_prior / sample_num;
end
if strcmp(estimator, 'BE')
    prob_prior = prob_prior + lambda;
    prob_prior = prob_prior / (sample_num + class_num*lambda);
end
%% compute conditioned distribution probability
prob_condition = zeros(class_num, feature_num, featval_num);
% for each class
for i=1:class_num
    idx = find(train_label == class_ids(i));
    data_subset = train_data(idx, :);
    prob_cond = zeros(feature_num, featval_num);
    for j=1:featval_num
        [rid, cid] = find(data_subset == featval_set(j));
        % no samples has value that equal to featval_set(j) on
        % any dimensions.
        prob = zeros(feature_num, 1);
        if length(cid) ~= 0
            % stat the sample number of each feature dimension
            prob = zeros(feature_num, 1);
            feat_id = unique(cid);
            for k=1:length(feat_id)
                prob(feat_id(k)) = length(find(cid == feat_id(k)));
            end
            if strcmp(estimator, 'MLE')
                prob = prob ./ length(cid);
            end
            if strcmp(estimator, 'BE')
                prob = prob + lambda;
                prob = prob ./ (length(cid) + feature_num*lambda);
            end
        end
        prob_condition(i,:,j) = prob;
    end
%     map = squeeze(prob_condition(i,:,:));
%     imagesc(map); colorbar
end
end

