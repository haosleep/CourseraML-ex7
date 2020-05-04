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
% �����@�~�n�m�ߪ��O�D�ʷ����ǲߪ�K-Means�t��k,�����J�Ψӽm�ߪ����
% �̭��u��X�x�},�榡300x2
load('ex7data2.mat');

% Select an initial set of centroids
% �@�}�l���m��,���۰ʳ]�w�n�n�����X�s�M�U�s���s��
K = 3; % 3 Centroids
initial_centroids = [3 3; 6 2; 8 5];

% Find the closest centroids for the examples using the
% initial_centroids
% �����OK-Means���ƨB�J���Ĥ@�B,��U��ƶZ���̪񪺸s��
% �Q��findClosestCentroids.m�N���X���s(part1�@�~���e)
idx = findClosestCentroids(X, initial_centroids);

% ���e�T����Ƭݬݤ��s���G�O�_���T
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
% ���U�ӬOK-Means���ƨB�J���ĤG�B,��s�s��
% �Q��computeCentroids.m�N�U�s����ƨ�����(part2�@�~���e)
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
% �e��������������}�l�i��K-Means�����N
K = 3;
max_iters = 10;

% For consistency, here we set centroids to specific values
% but in practice you want to generate them automatically, such as by
% settings them to be random examples (as can be seen in
% kMeansInitCentroids).
initial_centroids = [3 3; 6 2; 8 5];

% Run K-Means algorithm. The 'true' at the end tells our function to plot
% the progress of K-Means
% �Q��runkMeans.m�Ӱ���K-Means�t��k
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

% �W�����m�ߧ�����,���۸ոէQ��K-Means�i��Ϲ����Y
fprintf('\nRunning K-Means clustering on pixels from an image.\n\n');

%  Load an image of a bird
% Ū������(imread���v�������Ouint8,�d��O0~255,���FK-Means��K�B�z,�A��double����)
% �榡�O128x128x3(���ɪ�x���ɼexRGB)
A = double(imread('bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

% ����ɸ�ƽd���Y��0~1
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);

% Reshape the image into an Nx3 matrix where N = number of pixels.
% Each row will contain the Red, Green and Blue pixel values
% This gives us our dataset matrix X that we will use K-Means on.
% ��쥻����128x128x3(��x�exRGB)�����ɸ���ഫ��16384x3((��x�e)xRGB)���x�}
% �o�ˤ~�K�󱵤U�Ӫ��B�z
X = reshape(A, img_size(1) * img_size(2), 3);

% Run your K-Means algorithm on this data
% You should try different values of K and max_iters here
% �]�w���s�ƩM���N����
K = 16; 
max_iters = 10;

% When using K-Means, it is important the initialize the centroids
% randomly. 
% You should complete the code in kMeansInitCentroids.m before proceeding
% �o�@������������l�s�ߦ�m,�ӬO�Q��kMeansInitCentroids.m�H���M�w��l�s�ߦ�m(part4�@�~)
% �]�O������W���@�k
initial_centroids = kMeansInitCentroids(X, K);

% Run K-Means
% ����K-Means�t��k
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 5: Image Compression ======================
%  In this part of the exercise, you will use the clusters of K-Means to
%  compress an image. To do this, we first find the closest clusters for
%  each example. After that, we 

fprintf('\nApplying K-Means to compress an image.\n\n');

% Find closest cluster members
% K-Means�b���ƨB�J�ɪ��ĤG�B�O��s�s��
% �o��A�w��s�s�߶i����s
idx = findClosestCentroids(X, centroids);

% Essentially, now we have represented the image X as in terms of the
% indices in idx. 

% We can now recover the image from the indices (idx) by mapping each pixel
% (specified by its index in idx) to the centroid value
% �A�ھڤ��s�����G,���o�Ω��٭�Ϲ���X_recovered(�榡16384x3)
% ���ݩ�P�@�s������
% �O���N�O���s���s��(���s������) ==> ���s�����C�⪺����
X_recovered = centroids(idx,:);

% Reshape the recovered image into proper dimensions
% ��_��128x128x3���榡
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Display the original image
% subplot (ROWS, COLS, INDEX)�O�Ω�ø�s�h��
% ROWS�MCOLS�O�N�Ϫ��ϰ��a�V���ΩM��V����
% 1,2�N��̫ܳ�|�O���k�U�@�i���Ϫ����p
% INDEX��ܪ��N�O���U�ӭnø�s���O���@��
subplot(1, 2, 1);
% ����ø�s���
imagesc(A); 
title('Original');

% Display compressed image side by side
subplot(1, 2, 2);
% �k��ø�sK-Means�᪺16�����Y��
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));


fprintf('Program paused. Press enter to continue.\n');
pause;

