% 2019-7-6 21:54:17

clear,clc,close all;

Task='FFT';
mkdir(Task);

% original image
I0=imread(sprintf('%s_sample.jpg',Task));
I=rgb2gray(I0);
[h,w]=size(I);
X0=I;

% generate frames
nFrame=7;
for iFrame=1:nFrame
    % parameter
    R=2.^iFrame;
    
    % index
    % R=20;
    IDX=zeros(size(I));
    for i=1:h
        for j=1:w
            if (i-h/2)^2+(j-w/2)^2<=R^2
                IDX(i,j)=1;
            end
        end
    end
    
    % FFT & IFFT
    X1=fft2(I);
    X2=fftshift(X1);
    X3=log(abs(X2));
    
    X4=X2.*(IDX==0);
    X5=fftshift(X4);
    X6=log(abs(X5));
    X7=ifft2(X5);
    
    X8=X2.*(IDX==1);
    X9=fftshift(X8);
    X10=log(abs(X9));
    X11=ifft2(X9);
    
    X12=X3.*(IDX==0);
    X13=X3.*(IDX==1);
    
    % plot
    figure;
    subplot(2,3,1);
    imshow(X0,[]);
    subplot(2,3,2);
    imshow(real(X7),[]);
    subplot(2,3,3);
    imshow(real(X11),[]);
    subplot(2,3,4);
    imshow(X3,[]);
    subplot(2,3,5);
    imshow(X13,[]);
    subplot(2,3,6);
    imshow(X12,[]);
    
    % scale
    scale=1.2;
    pos=get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);
    
    % save frames
    saveas(gcf,sprintf('%s/Frame_%d.png',Task,iFrame),'png');
end
close all;

% read frames
iFrame=1;
F0=imread(sprintf('%s/Frame_%d.png',Task,iFrame));
[h,w,c]=size(F0);
X_GIF=zeros(h,w,1,nFrame);
X_GIF=uint8(X_GIF);
for iFrame=1:nFrame
    F0=imread(sprintf('%s/Frame_%d.png',Task,iFrame));
    F=rgb2gray(F0);
    X_GIF(:,:,1,iFrame)=F;
end

% generate GIF
GIF_name=sprintf('%s_GIF.gif',Task);
DelayTime=1;
MultImage2Gif(X_GIF,GIF_name,DelayTime);
