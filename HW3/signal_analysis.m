[y0,fs0] = audioread('singing16k16bit-clean.wav');
[y1,fs1] = audioread('singing16k16bit-clean_3.wav');
[y2,fs2] = audioread('singing16k16bit-clean_4.wav');

m0 = length(y0);
n0 = pow2(nextpow2(m0));
y0_f = fft(y0,n0);
f0 = (0:n0-1)*(fs0/n0)/10;
power0 = abs(y0_f).^2/n0;

m1 = length(y1);
n1 = pow2(nextpow2(m1));
y1_f = fft(y1,n1);
f1 = (0:n1-1)*(fs1/n1)/10;
power1 = abs(y1_f).^2/n1;

m2 = length(y2);
n2 = pow2(nextpow2(m2));
y2_f = fft(y2,n2);
f2 = (0:n2-1)*(fs2/n2)/10;
power2 = abs(y2_f).^2/n2;  

tiledlayout(3,1)

ax1 = nexttile;
plot(f0(1:floor(n0/2)),power0(1:floor(n0/2)))
xlabel('Frequency')
ylabel('Power')

ax2 = nexttile;
plot(f1(1:floor(n1/2)),power1(1:floor(n1/2)))
xlabel('Frequency')
ylabel('Power')

ax3 = nexttile;
plot(f2(1:floor(n2/2)),power2(1:floor(n2/2)))
xlabel('Frequency')
ylabel('Power')

linkaxes([ax1 ax2 ax3],'xy')
ax1.XLim = [0 200];