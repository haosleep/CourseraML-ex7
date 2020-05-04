%% Machine Learning Online Class
%  Exercise 7 | Principle Component Analysis and K-Means Clustering
%
%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     pca.m
%     projectData.m
%     recoverData.m
%     computeCentroids.m
%     findClosestCentroids.m
%     kMeansInitCentroids.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% ================== Part 1: Load Example Dataset  ===================
%  We start this exercise by using a small dataset that is easily to
%  visualize
%
fprintf('Visualizing example dataset for PCA.\n\n');

%  The following command loads the dataset. You should now have the 
%  variable X in your environment
% 這邊要練習的是用PCA對資料降維
% 先載入用於練習的資料
% 裡面只有X矩陣,格式50x2
load ('ex7data1.mat');

%  Visualize the example dataset
% 繪製ex7data1.mat的二維圖
plot(X(:, 1), X(:, 2), 'bo');
axis([0.5 6.5 2 8]); axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =============== Part 2: Principal Component Analysis ===============
%  You should now implement PCA, a dimension reduction technique. You
%  should complete the code in pca.m
%
fprintf('\nRunning PCA on example dataset.\n\n');

%  Before running PCA, it is important to first normalize X
% 執行PCA前要先進行特徵縮放
[X_norm, mu, sigma] = featureNormalize(X);

%  Run PCA
% 使用pca.m執行PCA算出資料的協方差矩陣(part2作業)
[U, S] = pca(X_norm);

%  Compute mu, the mean of the each feature

%  Draw the eigenvectors centered at mean of data. These lines show the
%  directions of maximum variations in the dataset.
% 在二維圖上繪製出特徵向量
hold on;
drawLine(mu, mu + 1.5 * S(1,1) * U(:,1)', '-k', 'LineWidth', 2);
drawLine(mu, mu + 1.5 * S(2,2) * U(:,2)', '-k', 'LineWidth', 2);
hold off;

fprintf('Top eigenvector: \n');
fprintf(' U(:,1) = %f %f \n', U(1,1), U(2,1));
fprintf('\n(you should expect to see -0.707107 -0.707107)\n');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== Part 3: Dimension Reduction ===================
%  You should now implement the projection step to map the data onto the 
%  first k eigenvectors. The code will then plot the data in this reduced 
%  dimensional space.  This will show you what the data looks like when 
%  using only the corresponding eigenvectors to reconstruct it.
%
%  You should complete the code in projectData.m
%
% 接下來就要處理降維的部分
fprintf('\nDimension reduction on example dataset.\n\n');

%  Plot the normalized dataset (returned from pca)
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

%  Project the data onto K = 1 dimension
% 利用projectData.m讓X_norm的維度(原本是2維)降為K維(1維) (part3作業一)
K = 1;
Z = projectData(X_norm, U, K);
fprintf('Projection of the first example: %f\n', Z(1));
fprintf('\n(this value should be about 1.481274)\n\n');

% 這邊recoverData.m則是要將降維後的Z還原成原本的X(近似值) (part3作業二)
X_rec  = recoverData(Z, U, K);
fprintf('Approximation of the first example: %f %f\n', X_rec(1, 1), X_rec(1, 2));
fprintf('\n(this value should be about  -1.047419 -1.047419)\n\n');

%  Draw lines connecting the projected points to the original points
% 在二維圖上將結果表示出來
% 原本的資料是藍色圓點(part1,plot指令的'bo')
% 降維後投影的點則是紅色圓點('ro')
% 再用黑色虛線('--k')將兩點相連來表現得更清楚
hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== Part 4: Loading and Visualizing Face Data =============
%  We start the exercise by first loading and visualizing the dataset.
%  The following code will load the dataset into your environment
%
% 接著則是練習利用PCA對臉部圖像資料進行降維
fprintf('\nLoading face dataset.\n\n');

%  Load Face dataset
% 載入臉部圖像資料
% X格式為5000x1024 (32x32的灰階圖,共5000筆)
load ('ex7faces.mat')

%  Display the first 100 faces in the dataset
% 將前100張圖顯示出來
displayData(X(1:100, :));

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 5: PCA on Face Data: Eigenfaces  ===================
%  Run PCA and visualize the eigenvectors which are in this case eigenfaces
%  We display the first 36 eigenfaces.
%
fprintf(['\nRunning PCA on face dataset.\n' ...
         '(this might take a minute or two ...)\n\n']);

%  Before running PCA, it is important to first normalize X by subtracting 
%  the mean value from each feature
% 一樣要先特徵縮放
[X_norm, mu, sigma] = featureNormalize(X);

%  Run PCA
% 算協方差矩陣
[U, S] = pca(X_norm);

%  Visualize the top 36 eigenvectors found
% 圖片顯示前36組的特徵向量
displayData(U(:, 1:36)');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ============= Part 6: Dimension Reduction for Faces =================
%  Project images to the eigen space using the top k eigenvectors 
%  If you are applying a machine learning algorithm 
fprintf('\nDimension reduction for face dataset.\n\n');

% 接下來使用projectData.m將原本1024維的資料降到100維
% 這樣就能有效的加快機器學習算法的學習速度
K = 100;
Z = projectData(X_norm, U, K);

fprintf('The projected data Z has a size of: ')
fprintf('%d ', size(Z));

fprintf('\n\nProgram paused. Press enter to continue.\n');
pause;

%% ==== Part 7: Visualization of Faces after PCA Dimension Reduction ====
%  Project images to the eigen space using the top K eigen vectors and 
%  visualize only using those K dimensions
%  Compare to the original input, which is also displayed

fprintf('\nVisualizing the projected (reduced dimension) faces.\n\n');

% 這邊使用recoverData.m將已經降成100維的Z還原成1024維的X的近似值
K = 100;
X_rec  = recoverData(Z, U, K);

% Display normalized data
% subplot左邊放前100項的原圖,右邊放PCA後,用100維的資料還原出來的近似圖
% 可以觀察到儘管右邊的近似圖變得比較模糊
% 不過還是有保留下臉部的特徵,用於臉部識別依然夠用
% 而且又能將1024維縮為100維,可以在使用這份資料進行機器學習時能有效加快學習速度
% 這就是PCA演算法的一大功用
subplot(1, 2, 1);
displayData(X_norm(1:100,:));
title('Original faces');
axis square;

% Display reconstructed data from only k eigenfaces
subplot(1, 2, 2);
displayData(X_rec(1:100,:));
title('Recovered faces');
axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% === Part 8(a): Optional (ungraded) Exercise: PCA for Visualization ===
%  One useful application of PCA is to use it to visualize high-dimensional
%  data. In the last K-Means exercise you ran K-Means on 3-dimensional 
%  pixel colors of an image. We first visualize this output in 3D, and then
%  apply PCA to obtain a visualization in 2D.

% PCA演算法還有另一種功用是將資料可視化
% 一般超過三維以上的資料,要轉換成方便看的圖表不容易
% 這時可利用PCA演算法將資料降維成三維以下,要可視化數據就變得容易許多

% 在ex7.m中用了K-Means對RGB圖片壓縮成了16色
% 這邊就利用PCA演算法來將分類結果降成二維後轉換成二維圖
close all; close all; clc

% Reload the image from the previous exercise and run K-Means on it
% For this to work, you need to complete the K-Means assignment first
A = double(imread('bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

% 這部分就是ex7的part4
A = A / 255;
img_size = size(A);
X = reshape(A, img_size(1) * img_size(2), 3);
K = 16; 
max_iters = 10;
initial_centroids = kMeansInitCentroids(X, K);
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

%  Sample 1000 random indexes (since working with all the data is
%  too expensive. If you have a fast computer, you may increase this.

% 原本的資料是128x128 = 16384組
% 為了節省時間,這邊就只隨機取1000組來處理
sel = floor(rand(1000, 1) * size(X, 1)) + 1;

%  Setup Color Palette
% 給定各群在圖上的顏色(和plotDataPoints.m一樣)
palette = hsv(K);
colors = palette(idx(sel), :);

%  Visualize the data and centroid memberships in 3D
% 使用scatter3指令畫出三維圖看R,G,B各為多少時的分群
% (點的顏色只是代表哪些是同一群而已,並不是ex7裡面壓縮後的此群的顏色(群心))
figure;
scatter3(X(sel, 1), X(sel, 2), X(sel, 3), 10, colors);
title('Pixel dataset plotted in 3D. Color shows centroid memberships');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% === Part 8(b): Optional (ungraded) Exercise: PCA for Visualization ===
% Use PCA to project this cloud to 2D for visualization

% Subtract the mean to use PCA

% 接下來就要用PCA將資料降維
% 一樣先進行特徵縮放 
[X_norm, mu, sigma] = featureNormalize(X);

% PCA and project the data to 2D
% PCA降維
[U, S] = pca(X_norm);
Z = projectData(X_norm, U, 2);

% Plot in 2D
% 把降維後的分群圖用二維圖表示出來
figure;
plotDataPoints(Z(sel, :), idx(sel), K);
title('Pixel dataset plotted in 2D, using PCA for dimensionality reduction');
fprintf('Program paused. Press enter to continue.\n');
pause;
