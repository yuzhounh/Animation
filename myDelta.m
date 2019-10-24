function y=myDelta(t)

n=length(t);
y=zeros(n,1);
for i=1:n
    if t(i)==0
        y(i)=1e4; % infinity when t=0
    else
        y(i)=0;
    end
end