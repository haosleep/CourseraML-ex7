function centroids = kMeansInitCentroids(X, K)
%KMEANSINITCENTROIDS This function initializes K centroids that are to be 
%used in K-Means on the dataset X
%   centroids = KMEANSINITCENTROIDS(X, K) returns K initial centroids to be
%   used with the K-Means on the dataset X
%

% You should return this values correctly
centroids = zeros(K, size(X, 2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should set centroids to randomly chosen examples from
%               the dataset X
%


% Initialize the centroids to be random examples

% Randomly reorder the indices of examples
% �N��ƥ�randperm�H���ƦC
randidx = randperm(size(X, 1));
% Take the first K examples as centroids
% ���eK�Ӹ�Ƨ@����l�s��
centroids = X(randidx(1:K), :);





% =============================================================

end
