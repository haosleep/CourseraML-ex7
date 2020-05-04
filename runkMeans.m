function [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters, plot_progress)
%RUNKMEANS runs the K-Means algorithm on data matrix X, where each row of X
%is a single example
%   [centroids, idx] = RUNKMEANS(X, initial_centroids, max_iters, ...
%   plot_progress) runs the K-Means algorithm on data matrix X, where each 
%   row of X is a single example. It uses initial_centroids used as the
%   initial centroids. max_iters specifies the total number of interactions 
%   of K-Means to execute. plot_progress is a true/false flag that 
%   indicates if the function should also plot its progress as the 
%   learning happens. This is set to false by default. runkMeans returns 
%   centroids, a Kxn matrix of the computed centroids and idx, a m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set default value for plot progress
% 判斷是否要階段性顯示圖
% 在part3的時候,plot_progress設定為true
% 執行的過程中可以看到每一次的迭代,資料分群和群心的變化
% part4圖檔壓縮時就沒給plot_progress了
if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

% Plot the data if we are plotting progress
% 因為要顯示在同一張圖上,如果plot_progress為true時需要hold on;
if plot_progress
    figure;
    hold on;
end

% Initialize values
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
% 紀錄前一次的群心(這是用在plotProgresskMeans.m中繪圖用的)
previous_centroids = centroids;
idx = zeros(m, 1);

% Run K-Means
for i=1:max_iters
    
    % Output progress
    fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    % 如果是使用Octave進行編譯
    if exist('OCTAVE_VERSION')
        % fflush(stdout);接在printf後面作用是立刻將要輸出的內容輸出
        % printf是系統將要輸出的內容存進輸出緩衝區,等時間輪轉到系統的輸出程式時再輸出
        % 加上fflush(stdout);則會立刻將緩衝區內容輸出並清空緩衝區
        % 這樣可以避免輸出的資料出現亂序的狀況
        fflush(stdout);
    end
    
    % For each example in X, assign it to the closest centroid
    % 第一步:進行分群
    idx = findClosestCentroids(X, centroids);
    
    % Optionally, plot progress here
    % 如果plot_progress為true
    if plot_progress
        % 在plotProgresskMeans.m中繪製此次迭代後的散點圖
        plotProgresskMeans(X, centroids, previous_centroids, idx, K, i);
        % 更新前一次的群心
        previous_centroids = centroids;
        fprintf('Press enter to continue.\n');
        pause;
    end
    
    % Given the memberships, compute new centroids
    % 第二步:計算新群心位置
    centroids = computeCentroids(X, idx, K);
end

% Hold off if we are plotting progress
if plot_progress
    hold off;
end

end

