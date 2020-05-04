function drawLine(p1, p2, varargin)
%DRAWLINE Draws a line from point p1 to point p2
%   DRAWLINE(p1, p2) Draws a line from point p1 to point p2 and holds the
%   current figure

% 用plot畫兩點連線的寫法
% 第一個變數對應X,第二個變數對應Y
% varargin放在呼叫函數的最後一個變數,用來代表"數量不固定的參數",讓drawLine也可以用上plot的指令
plot([p1(1) p2(1)], [p1(2) p2(2)], varargin{:});

end