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

%% ================= Part 1: Find Closest Centroids ====================
%  To help you implement K-Means, we have divided the learning algorithm 
%  into two functions -- findClosestCentroids and computeCentroids. In this
%  part, you should complete the code in the findClosestCentroids function. 
%
fprintf('Finding closest centroids.\n\n');

% Load an example dataset that we will be using
% 本次作業要練習的是非監督式學習的K-Means演算法,先載入用來練習的資料
% 裡面只有X矩陣,格式300x2
load('ex7data2.mat');

% Select an initial set of centroids
% 一開始的練習,先自動設定好要分成幾群和各群的群心
K = 3; % 3 Centroids
initial_centroids = [3 3; 6 2; 8 5];

% Find the closest centroids for the examples using the
% initial_centroids
% 首先是K-Means重複步驟的第一步,找各資料距離最近的群心
% 利用findClosestCentroids.m將資料X分群(part1作業內容)
idx = findClosestCentroids(X, initial_centroids);

% 拿前三筆資料看看分群結果是否正確
fprintf('Closest centroids for the first 3 examples: \n')
fprintf(' %d', idx(1:3));
fprintf('\n(the closest centroids should be 1, 3, 2 respectively)\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ===================== Part 2: Compute Means =========================
%  After implementing the closest centroids function, you should now
%  complete the computeCentroids function.
%
fprintf('\nComputing centroids means.\n\n');

%  Compute means based on the closest centroids found in the previous part.
% 接下來是K-Means重複步驟的第二步,更新群心
% 利用computeCentroids.m將各群的資料取平均(part2作業內容)
centroids = computeCentroids(X, idx, K);

fprintf('Centroids computed after initial finding of closest centroids: \n')
fprintf(' %f %f \n' , centroids');
fprintf('\n(the centroids should be\n');
fprintf('   [ 2.428301 3.157924 ]\n');
fprintf('   [ 5.813503 2.633656 ]\n');
fprintf('   [ 7.119387 3.616684 ]\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== Part 3: K-Means Clustering ======================
%  After you have completed the two functions computeCentroids and
%  findClosestCentroids, you have all the necessary pieces to run the
%  kMeans algorithm. In this part, you will run the K-Means algorithm on
%  the example dataset we have provided. 
%
fprintf('\nRunning K-Means clustering on example dataset.\n\n');

% Load an example dataset
load('ex7data2.mat');

% Settings for running K-Means
% 前面的部分完成後開始進行K-Means的迭代
K = 3;
max_iters = 10;

% For consistency, here we set centroids to specific values
% but in practice you want to generate them automatically, such as by
% settings them to be random examples (as can be seen in
% kMeansInitCentroids).
initial_centroids = [3 3; 6 2; 8 5];

% Run K-Means algorithm. The 'true' at the end tells our function to plot
% the progress of K-Means
% 利用runkMeans.m來執行K-Means演算法
[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
fprintf('\nK-Means Done.\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============= Part 4: K-Means Clustering on Pixels ===============
%  In this exercise, you will use K-Means to compress an image. To do this,
%  you will first run K-Means on the colors of the pixels in the image and
%  then you will map each pixel onto its closest centroid.
%  
%  You should now complete the code in kMeansInitCentroids.m
%

% 上面的練習完成後,接著試試利用K-Means進行圖像壓縮
fprintf('\nRunning K-Means clustering on pixels from an image.\n\n');

%  Load an image of a bird
% 讀取圖檔(imread的影像類型是uint8,範圍是0~255,為了K-Means方便處理,再轉double類型)
% 格式是128x128x3(圖檔長x圖檔寬xRGB)
A = double(imread('bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

% 把圖檔資料範圍縮為0~1
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);

% Reshape the image into an Nx3 matrix where N = number of pixels.
% Each row will contain the Red, Green and Blue pixel values
% This gives us our dataset matrix X that we will use K-Means on.
% 把原本分成128x128x3(長x寬xRGB)的圖檔資料轉換成16384x3((長x寬)xRGB)的矩陣
% 這樣才便於接下來的處理
X = reshape(A, img_size(1) * img_size(2), 3);

% Run your K-Means algorithm on this data
% You should try different values of K and max_iters here
% 設定分群數和迭代次數
K = 16; 
max_iters = 10;

% When using K-Means, it is important the initialize the centroids
% randomly. 
% You should complete the code in kMeansInitCentroids.m before proceeding
% 這一次不直接給初始群心位置,而是利用kMeansInitCentroids.m隨機決定初始群心位置(part4作業)
% 也是比較正規的作法
initial_centroids = kMeansInitCentroids(X, K);

% Run K-Means
% 執行K-Means演算法
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 5: Image Compression ======================
%  In this part of the exercise, you will use the clusters of K-Means to
%  compress an image. To do this, we first find the closest clusters for
%  each example. After that, we 

fprintf('\nApplying K-Means to compress an image.\n\n');

% Find closest cluster members
% K-Means在重複步驟時的第二步是找新群心
% 這邊再針對新群心進行分群
idx = findClosestCentroids(X, centroids);

% Essentially, now we have represented the image X as in terms of the
% indices in idx. 

% We can now recover the image from the indices (idx) by mapping each pixel
% (specified by its index in idx) to the centroid value
% 再根據分群的結果,取得用於還原圖像的X_recovered(格式16384x3)
% 隸屬於同一群的像素
% 記的就是此群的群心(此群的平均) ==> 此群像素顏色的平均
X_recovered = centroids(idx,:);

% Reshape the recovered image into proper dimensions
% 恢復成128x128x3的格式
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Display the original image
% subplot (ROWS, COLS, INDEX)是用於繪製多圖
% ROWS和COLS是將圖的區域縱向分割和橫向分割
% 1,2就表示最後會是左右各一張的圖的情況
% INDEX表示的就是接下來要繪製的是哪一格
subplot(1, 2, 1);
% 左邊繪製原圖
imagesc(A); 
title('Original');

% Display compressed image side by side
subplot(1, 2, 2);
% 右邊繪製K-Means後的16色壓縮圖
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));


fprintf('Program paused. Press enter to continue.\n');
pause;

