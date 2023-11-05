% 數值初始化
WindowLen = 256;
AnalysisLen = 95;
SynthesisLen = 90;
Fs = 16000;
Hopratio = SynthesisLen/AnalysisLen;
play_flag = 1;

% 音檔讀取
reader = dsp.AudioFileReader('singing16k16bit-clean.wav', ...
  'SamplesPerFrame',AnalysisLen, ...
  'OutputDataType','double');

% 時間調整
win = sqrt(hanning(WindowLen,'periodic'));
logger = dsp.SignalSink;
ats = audioTimeScaler(1/Hopratio,'Window',win,'OverlapLength',WindowLen-AnalysisLen);


% 根據音窗遍歷
while ~isDone(reader)
    
    x = reader();

    % Time-scale the signal
    y = ats(x);

    logger(y)
end

% 釋放記憶體
release(reader)
release(player)

% 播放Pitch-Scaled訊號
loggedSpeech = logger.Buffer(200:end)';
Fs_new = round(Fs*(SynthesisLen/AnalysisLen));
if play_flag==1
    player = audioDeviceWriter('SampleRate',Fs_new, ...
        'SupportVariableSizeInput',true, ...
        'BufferSize',1024);
    player(loggedSpeech.');
end

% 存檔
audiowrite('C:\AG\課程講義\digtal signal porcessing\HW3\singing16k16bit-clean_4.wav',loggedSpeech.',Fs_new);