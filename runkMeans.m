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
% �P�_�O�_�n���q����ܹ�
% �bpart3���ɭ�,plot_progress�]�w��true
% ���檺�L�{���i�H�ݨ�C�@�������N,��Ƥ��s�M�s�ߪ��ܤ�
% part4�������Y�ɴN�S��plot_progress�F
if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

% Plot the data if we are plotting progress
% �]���n��ܦb�P�@�i�ϤW,�p�Gplot_progress��true�ɻݭnhold on;
if plot_progress
    figure;
    hold on;
end

% Initialize values
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
% �����e�@�����s��(�o�O�ΦbplotProgresskMeans.m��ø�ϥΪ�)
previous_centroids = centroids;
idx = zeros(m, 1);

% Run K-Means
for i=1:max_iters
    
    % Output progress
    fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    % �p�G�O�ϥ�Octave�i��sĶ
    if exist('OCTAVE_VERSION')
        % fflush(stdout);���bprintf�᭱�@�άO�ߨ�N�n��X�����e��X
        % printf�O�t�αN�n��X�����e�s�i��X�w�İ�,���ɶ������t�Ϊ���X�{���ɦA��X
        % �[�Wfflush(stdout);�h�|�ߨ�N�w�İϤ��e��X�òM�Žw�İ�
        % �o�˥i�H�קK��X����ƥX�{�çǪ����p
        fflush(stdout);
    end
    
    % For each example in X, assign it to the closest centroid
    % �Ĥ@�B:�i����s
    idx = findClosestCentroids(X, centroids);
    
    % Optionally, plot progress here
    % �p�Gplot_progress��true
    if plot_progress
        % �bplotProgresskMeans.m��ø�s�������N�᪺���I��
        plotProgresskMeans(X, centroids, previous_centroids, idx, K, i);
        % ��s�e�@�����s��
        previous_centroids = centroids;
        fprintf('Press enter to continue.\n');
        pause;
    end
    
    % Given the memberships, compute new centroids
    % �ĤG�B:�p��s�s�ߦ�m
    centroids = computeCentroids(X, idx, K);
end

% Hold off if we are plotting progress
if plot_progress
    hold off;
end

end

