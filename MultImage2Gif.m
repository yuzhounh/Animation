function MultImage2Gif(x,filename,DelayTime)
% 2012-12-7 20:35:57
% x is a 4D data
% filename is sth like 'photo.gif'

for i=1:size(x,4)
    imshow(x(:,:,:,i),'Border','tight'); drawnow;
    
    frame=getframe(gcf);
    % frame=getframe; 
    
    im = frame2im(frame);
    [im_index,color_map] = rgb2ind(im,256);
    if i==1
        imwrite(im_index,color_map,filename,'gif','Loopcount',inf,'DelayTime',DelayTime);
    else
        imwrite(im_index,color_map,filename,'gif','WriteMode','append','DelayTime',DelayTime);
    end
end