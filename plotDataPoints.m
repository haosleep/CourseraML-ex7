function plotDataPoints(X, idx, K)
%PLOTDATAPOINTS plots data points in X, coloring them so that those with the same
%index assignments in idx have the same color
%   PLOTDATAPOINTS(X, idx, K) plots data points in X, coloring them so that those 
%   with the same index assignments in idx have the same color

% Create palette
% hsv(m)功能是建立一個mx3的矩陣作為顏色表
% 利用這個來讓圖上各群的點有不同的顏色
palette = hsv(K + 1);
% 進行各群的顏色對應
colors = palette(idx, :);

% Plot the data
% scatter(x,y,sz,c)功能是繪製散點圖
% x為X軸值,y為Y軸值,sz是散點大小,c是散點顏色(須為顏色名稱或是對應RGB的三列矩陣)
scatter(X(:,1), X(:,2), 15, colors);

end
