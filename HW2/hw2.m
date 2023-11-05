[y,fs] = audioread('singing16k16bit-clean.wav');
y2 = resample(y,3,4);
audiowrite('C:\AG\課程講義\digtal signal porcessing\HW2\singing16k16bit-clean_2.wav',y2,12e3);

subplot(2,1,1)
plot((0:length(y)-1)/fs,y)
subplot(2,1,2)
plot((0:length(y2)-1)/(3/4*fs),y2)