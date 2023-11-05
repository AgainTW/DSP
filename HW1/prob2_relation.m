% 第a小題
a = 1.8*cos(pi/16);

% Initial rest conditions: causal，所以y[n]=0,n<0
% 初始化
y1 = [1];
y1 = [y1 a*y1(1)+0.5];
y1 = [y1 a*y1(2)-0.81*y1(1)];
n_1 = 3:1:100;
for i = n_1
	y1 = [y1 a*y1(i)-0.81*y1(i-1)];
end
temp = zeros(1,10);
y1 = [temp y1]
step_1 = -10:1:100;
stem(step_1, y1, "x");
hold on;

% Initial rest conditions: noncausal,所以y[n]=0,n>0
% 初始化
y2 = [0];
y2 = [y2 (a*y2(1)+0.5)/0.81];
y2 = [y2 (a*y2(2)-y2(1)+1)/0.81];
n_2 = 3:1:20;   % 算到-20
for i = n_2
	y2 = [y2 (a*y2(i)-y2(i-1))/0.81];
end
y2 = fliplr(y2);
temp = zeros(1,100);
y2 = [y2 temp];
% 正負號反轉
n_2 = 1:1:121;
for i = n_2
	y2(i) = y2(i)*-1;
end
step_2 = -20:1:100;
stem(step_2, y2);
hold on;

% 設定圖標
legend('causal','non-causal (sign reverse)')
xlabel('n');
ylabel('value');
grid on;
title('Present the relation of causal and non-causal'); 