function [ classify_map ] = run_classification(test_data, prob_prior, prob_condition)
% implementation on test data
% - test_data: H x W x F, where H, W, F are height, width and the number of
% channels for an hyperspectral image.
% - prob_prior: Nc x 1, where Nc is the number of classes in ground truth
% - prob_condition: Nc x F x 256

%% test Naive Bayes Classification on test data
[height, width, featdim] = size(test_data);
classify_map = zeros(height, width);
for i=1:height
    for j=1:width
        sample = squeeze(test_data(i,j,:));
        posterior = zeros(length(prob_prior),1);
        for k=1:length(prob_prior)
            prior = prob_prior(k);
            condition = squeeze(prob_condition(k,:,:));
            cond = zeros(featdim,1);
            for n=1:featdim
                cond(n) = condition(n, sample(n));
            end
            cond = cond .* 100;  % to avoid extremely small values after prod multiply operation
            posterior(k) = prior * prod(cond);
        end
        [~, pred_cls] = max(posterior);
        classify_map(i,j) = pred_cls;
    end
end

end

