% 數值初始化
WindowLen = 256;
AnalysisLen = 85;
SynthesisLen = 90;
Fs = 16000;
Hopratio = SynthesisLen/AnalysisLen;

% 音檔讀取
reader = dsp.AudioFileReader('singing16k16bit-clean.wav', ...
  'SamplesPerFrame',AnalysisLen, ...
  'OutputDataType','double');

% FFT
win = sqrt(hanning(WindowLen,'periodic'));
stft = dsp.STFT(win, WindowLen - AnalysisLen, WindowLen);                   
istft = dsp.ISTFT(win, WindowLen - SynthesisLen );

logger = dsp.SignalSink;

% 初始化遍歷參數
unwrapdata = 2*pi*AnalysisLen*(0:WindowLen-1)'/WindowLen;
yangle = zeros(WindowLen,1);
firsttime = true;

% 根據音窗遍歷
while ~isDone(reader)
    y = reader();

    % ST-FFT
    yfft = stft(y);
    
    % 分離出振幅與相位
    ymag       = abs(yfft);
    yprevangle = yangle;
    yangle     = angle(yfft);

    % 相位計算
    yunwrap = (yangle - yprevangle) - unwrapdata;
    yunwrap = yunwrap - round(yunwrap/(2*pi))*2*pi;
    yunwrap = (yunwrap + unwrapdata) * Hopratio;
    if firsttime
        ysangle = yangle;
        firsttime = false;
    else
        ysangle = ysangle + yunwrap;
    end

    % 將振幅與相位合成
    ys = ymag .* complex(cos(ysangle), sin(ysangle));

    % IST-FFT
    yistfft = istft(ys);

    logger(yistfft) % Log signal 
end

% 記憶體釋放
release(reader)

% 播放Time-Stretched訊號
loggedSpeech = logger.Buffer(200:end)';
player = audioDeviceWriter('SampleRate',Fs, ...
    'SupportVariableSizeInput',true, ...
    'BufferSize',512);
player(loggedSpeech.');
 
% 播放Pitch-Scaled訊號
Fs_new = round(Fs*(SynthesisLen/AnalysisLen));
player = audioDeviceWriter('SampleRate',Fs_new, ...
    'SupportVariableSizeInput',true, ...
    'BufferSize',1024);
player(loggedSpeech.');

% 存檔
audiowrite('C:\AG\課程講義\digtal signal porcessing\HW3\singing16k16bit-clean_1.wav',loggedSpeech.',Fs_new);