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
% �o��n�m�ߪ��O��PCA���ƭ���
% �����J�Ω�m�ߪ����
% �̭��u��X�x�},�榡50x2
load ('ex7data1.mat');

%  Visualize the example dataset
% ø�sex7data1.mat���G����
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
% ����PCA�e�n���i��S�x�Y��
[X_norm, mu, sigma] = featureNormalize(X);

%  Run PCA
% �ϥ�pca.m����PCA��X��ƪ����t�x�}(part2�@�~)
[U, S] = pca(X_norm);

%  Compute mu, the mean of the each feature

%  Draw the eigenvectors centered at mean of data. These lines show the
%  directions of maximum variations in the dataset.
% �b�G���ϤWø�s�X�S�x�V�q
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
% ���U�ӴN�n�B�z����������
fprintf('\nDimension reduction on example dataset.\n\n');

%  Plot the normalized dataset (returned from pca)
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

%  Project the data onto K = 1 dimension
% �Q��projectData.m��X_norm������(�쥻�O2��)����K��(1��) (part3�@�~�@)
K = 1;
Z = projectData(X_norm, U, K);
fprintf('Projection of the first example: %f\n', Z(1));
fprintf('\n(this value should be about 1.481274)\n\n');

% �o��recoverData.m�h�O�n�N�����᪺Z�٭즨�쥻��X(�����) (part3�@�~�G)
X_rec  = recoverData(Z, U, K);
fprintf('Approximation of the first example: %f %f\n', X_rec(1, 1), X_rec(1, 2));
fprintf('\n(this value should be about  -1.047419 -1.047419)\n\n');

%  Draw lines connecting the projected points to the original points
% �b�G���ϤW�N���G��ܥX��
% �쥻����ƬO�Ŧ���I(part1,plot���O��'bo')
% �������v���I�h�O������I('ro')
% �A�ζ¦��u('--k')�N���I�۳s�Ӫ�{�o��M��
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
% ���۫h�O�m�ߧQ��PCA���y���Ϲ���ƶi�歰��
fprintf('\nLoading face dataset.\n\n');

%  Load Face dataset
% ���J�y���Ϲ����
% X�榡��5000x1024 (32x32���Ƕ���,�@5000��)
load ('ex7faces.mat')

%  Display the first 100 faces in the dataset
% �N�e100�i����ܥX��
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
% �@�˭n���S�x�Y��
[X_norm, mu, sigma] = featureNormalize(X);

%  Run PCA
% ����t�x�}
[U, S] = pca(X_norm);

%  Visualize the top 36 eigenvectors found
% �Ϥ���ܫe36�ժ��S�x�V�q
displayData(U(:, 1:36)');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ============= Part 6: Dimension Reduction for Faces =================
%  Project images to the eigen space using the top k eigenvectors 
%  If you are applying a machine learning algorithm 
fprintf('\nDimension reduction for face dataset.\n\n');

% ���U�Өϥ�projectData.m�N�쥻1024������ƭ���100��
% �o�˴N�঳�Ī��[�־����ǲߺ�k���ǲ߳t��
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

% �o��ϥ�recoverData.m�N�w�g����100����Z�٭즨1024����X�������
K = 100;
X_rec  = recoverData(Z, U, K);

% Display normalized data
% subplot�����e100�������,�k���PCA��,��100��������٭�X�Ӫ������
% �i�H�[��쾨�ޥk�䪺������ܱo����ҽk
% ���L�٬O���O�d�U�y�����S�x,�Ω��y���ѧO�̵M����
% �ӥB�S��N1024���Y��100��,�i�H�b�ϥγo����ƶi������ǲ߮ɯ঳�ĥ[�־ǲ߳t��
% �o�N�OPCA�t��k���@�j�\��
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

% PCA�t��k�٦��t�@�إ\�άO�N��ƥi����
% �@��W�L�T���H�W�����,�n�ഫ����K�ݪ��Ϫ��e��
% �o�ɥi�Q��PCA�t��k�N��ƭ������T���H�U,�n�i���ƼƾڴN�ܱo�e���\�h

% �bex7.m���ΤFK-Means��RGB�Ϥ����Y���F16��
% �o��N�Q��PCA�t��k�ӱN�������G�����G�����ഫ���G����
close all; close all; clc

% Reload the image from the previous exercise and run K-Means on it
% For this to work, you need to complete the K-Means assignment first
A = double(imread('bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

% �o�����N�Oex7��part4
A = A / 255;
img_size = size(A);
X = reshape(A, img_size(1) * img_size(2), 3);
K = 16; 
max_iters = 10;
initial_centroids = kMeansInitCentroids(X, K);
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

%  Sample 1000 random indexes (since working with all the data is
%  too expensive. If you have a fast computer, you may increase this.

% �쥻����ƬO128x128 = 16384��
% ���F�`�ٮɶ�,�o��N�u�H����1000�ըӳB�z
sel = floor(rand(1000, 1) * size(X, 1)) + 1;

%  Setup Color Palette
% ���w�U�s�b�ϤW���C��(�MplotDataPoints.m�@��)
palette = hsv(K);
colors = palette(idx(sel), :);

%  Visualize the data and centroid memberships in 3D
% �ϥ�scatter3���O�e�X�T���Ϭ�R,G,B�U���h�֮ɪ����s
% (�I���C��u�O�N����ǬO�P�@�s�Ӥw,�ä��Oex7�̭����Y�᪺���s���C��(�s��))
figure;
scatter3(X(sel, 1), X(sel, 2), X(sel, 3), 10, colors);
title('Pixel dataset plotted in 3D. Color shows centroid memberships');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% === Part 8(b): Optional (ungraded) Exercise: PCA for Visualization ===
% Use PCA to project this cloud to 2D for visualization

% Subtract the mean to use PCA

% ���U�ӴN�n��PCA�N��ƭ���
% �@�˥��i��S�x�Y�� 
[X_norm, mu, sigma] = featureNormalize(X);

% PCA and project the data to 2D
% PCA����
[U, S] = pca(X_norm);
Z = projectData(X_norm, U, 2);

% Plot in 2D
% �⭰���᪺���s�ϥΤG���Ϫ�ܥX��
figure;
plotDataPoints(Z(sel, :), idx(sel), K);
title('Pixel dataset plotted in 2D, using PCA for dimensionality reduction');
fprintf('Program paused. Press enter to continue.\n');
pause;
