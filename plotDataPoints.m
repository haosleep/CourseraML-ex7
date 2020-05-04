function plotDataPoints(X, idx, K)
%PLOTDATAPOINTS plots data points in X, coloring them so that those with the same
%index assignments in idx have the same color
%   PLOTDATAPOINTS(X, idx, K) plots data points in X, coloring them so that those 
%   with the same index assignments in idx have the same color

% Create palette
% hsv(m)�\��O�إߤ@��mx3���x�}�@���C���
% �Q�γo�Ө����ϤW�U�s���I�����P���C��
palette = hsv(K + 1);
% �i��U�s���C�����
colors = palette(idx, :);

% Plot the data
% scatter(x,y,sz,c)�\��Oø�s���I��
% x��X�b��,y��Y�b��,sz�O���I�j�p,c�O���I�C��(�����C��W�٩άO����RGB���T�C�x�})
scatter(X(:,1), X(:,2), 15, colors);

end
