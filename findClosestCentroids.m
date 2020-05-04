function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

% findClosestCentroids�n�B�z���O���s
% �N�O�p��C�Ӹ�ƩM�s�ߪ��ڦ��Z��,�ݭ��@�Ӹs�߶Z���̪�
for i = 1 : size(X,1)
  % �Q��for�j��,�p��X�U�Ӹ�ƩM�C�Ӹs�ߪ��t��(�榡�|�O1xn - kxn,�|�۰ʹ�����kxn�����G)
  % �A�U���������C�[�`,�N��o���i����ƩM�U�s�ߪ��ڦ��Z��������
  K = sum((X(i,:) - centroids).^2, 2);
  % �A��X���@�Ӹs�߶Z���̪�(�ȳ̤p),�s�iidx�Y�i
  [value, idx(i)] = min(K);
endfor




% =============================================================

end
