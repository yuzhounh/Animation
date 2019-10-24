% 2019-7-7 19:25:42

clear,clc,close all;

task='FFT';
filename=sprintf('%s_GIF.gif',task);

sFile=dir(sprintf('%s',task));
nFile=length(sFile)-2;

I0=imread(sprintf('%s/Frame_%d.png',task,1));
[h,w,c]=size(I0);

x=zeros(h,w,1,nFile);
x=uint8(x);
for i=1:nFile
    I0=imread(sprintf('%s/Frame_%d.png',task,i));
    I=rgb2gray(I0);
    x(:,:,1,i)=I;
end
MultImage2Gif(x,filename);