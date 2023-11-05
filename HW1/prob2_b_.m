coeff = 1.8*cos(pi/16);
a = [1 -coeff 0.81];
b = [1 0.5];
n = -10:1:100;
x = (n==0);

y = filter(b,a,x);
stem(n,y);

% 設定圖標
legend('causal')
xlabel('n');
ylabel('value');
grid on;
title('Impulse response with filter function'); 
