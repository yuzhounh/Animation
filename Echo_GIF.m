% 2019-8-1 19:10:24

clear,clc,close all;

Task='Echo';
mkdir(Task);

% record data or read data

% % 1, record data
% fs=8000; % sampling frequency
% rd=2; % record duration
% recObj = audiorecorder;
% fprintf('Speaking for %d seconds. \n',rd);
% disp('Start speaking.')
% recordblocking(recObj, rd); % Record your voice for 5 seconds.
% disp('End of Recording.');
% % play(recObj); % Play back the recording.
%
% % Store data in double-precision array.
% x = getaudiodata(recObj);

% % 2, read data
[x,fs]=audioread('Record_x.wav');

% variables
n=length(x);
rd=n/fs;

% pulse response function h(t)
t=[0:1/fs:rd]';
h = 1*myDelta(t-0.2) + 0.8*myDelta(t-0.4) + 0.6*myDelta(t-0.6) + ...
    0.4*myDelta(t-0.8) + 0.2*myDelta(t-1.0);

% generate echo by convolution
y=1/fs*conv(x,h);
echo=audioplayer(y,fs);
play(echo); % play the echo
y=y/max(abs(y));

% % write to audio file
% audiowrite('Record_x.wav',x,fs);
audiowrite('Record_y.wav',y,fs);

% display & save

count=0;
delta=1000;
iSet=[1:delta:fs*(rd+1.0)];
nFrame=length(iSet);
for iFrame=1:nFrame    
    i=iSet(iFrame);
    figure;
    
    subplot(2,1,1); % original wave
    t=[1/fs:1/fs:rd]';
    if i<fs*rd
        plot(t(1:i),x(1:i),'r','linewidth',2);
    else
        plot(t,x,'r','linewidth',2);
    end
    xlabel('Time(s)');
    ylabel('x');
    xlim([0,3]);
    ylim([-1,1]);
    
    subplot(2,1,2); % echo
    t=[1/fs:1/fs:rd*2]';
    if i>fs*0.2 && i<=fs*(rd+1.0)
        plot(t(1:i),y(1:i),'b','linewidth',2);
    end
    xlabel('Time(s)');
    ylabel('y');
    xlim([0,3]);
    ylim([-1,1]);
    
    % save frames
    saveas(gcf,sprintf('%s/Frame_%d.png',Task,iFrame),'png');
    close; 
end

% read frames
iFrame=1;
F0=imread(sprintf('%s/Frame_%d.png',Task,iFrame));
[h,w,c]=size(F0);
X_GIF=zeros(h,w,c,nFrame);
X_GIF=uint8(X_GIF);
for iFrame=1:nFrame
    F0=imread(sprintf('%s/Frame_%d.png',Task,iFrame));
    X_GIF(:,:,:,iFrame)=F0;
end

% generate GIF
GIF_name=sprintf('%s_GIF.gif',Task);
DelayTime=0.2;
MultImage2Gif(X_GIF,GIF_name,DelayTime);
