% 2019-8-1 19:10:24

clear,clc,close all;

Task='Dancer';
mkdir(Task);

% spinning-dancer-big.gif (600×400) 
% http://brainden.com/images/spinning-dancer-big.gif 
[X,map]=imread('Dancer.gif');
[~,width,~,nFrame0]=size(X);
width=width/3; % the width of new gif is only 1/3 of the original one

% generate random series
nFrame=nFrame0*3; % rotate for 3 times
idx=randi(2,nFrame,1); % randomly select the left or the right picture
idx=2*(idx==2); % transform {1,2} to {0,2}

for iFrame=1:nFrame
    figure;
    iFrame0=rem(iFrame-1,nFrame0)+1;
    temp=X(:,width*idx(iFrame)+1:width*idx(iFrame)+width,:,iFrame0);
    % temp=imresize(temp,[400,300]);
    imshow(temp,map,'Border','tight');
    saveas(gcf,sprintf('%s/Frame_%d.png',Task,iFrame),'png'); % save frames
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