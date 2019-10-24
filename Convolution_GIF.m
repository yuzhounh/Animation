% 2019-7-6 21:54:17

clear,clc,close all;

Task='Convolution';
mkdir(Task);

% generate frames
xSet=[-2.5:0.25:2.5];
nFrame=length(xSet);
for iFrame=1:nFrame    
    x=xSet(iFrame);
    
    figure;
    hold on;
    
    % triangle
    if x<=-1
    elseif x>-1 && x<=0
        fill([-0.5,-0.5,x+0.5,x+0.5],[1,0,0,1],'y'); % yellow box
        plot([-1,x],[0,x+1],'-g','linewidth',2); % triangle
    elseif x>0 && x<=1
        fill([x-0.5,x-0.5,0.5,0.5],[1,0,0,1],'y','linewidth',2); % yellow box
        plot([-1,0],[0,1],'-g','linewidth',2); % triangle
        plot([0,x],[1,1-x],'-g','linewidth',2);
    elseif x>1
        plot([-1,0],[0,1],'-g','linewidth',2); % triangle
        plot([0,1],[1,0],'-g','linewidth',2); 
    end
    
    % blue box
    plot([-0.5,-0.5],[0,1],'-b','linewidth',2);
    plot([0.5,0.5],[0,1],'-b','linewidth',2);
    plot([-0.5,0.5],[1,1],'-b','linewidth',2);
    plot([0,0],[0,1],'--b','linewidth',2); % middle line
    
    % red box
    plot([x-0.5,x-0.5],[0,1],'-r','linewidth',2);
    plot([x+0.5,x+0.5],[0,1],'-r','linewidth',2);
    plot([x-0.5,x+0.5],[1,1],'-r','linewidth',2);
    plot([x,x],[0,1],'--r','linewidth',2); % middle line
    
    xlabel('$t$','interpreter','latex','FontSize',14);
        
    xlim([-2,2]);
    ylim([0,1]);
    
    grid on;
    pos=get(gcf,'Position');
    scale=1;
    set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale*0.8]);
    
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
