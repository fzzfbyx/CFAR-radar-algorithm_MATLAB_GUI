function [ xc ] = env_edge(variance,  shape, power_db, show_out)
%UNIFORM_EN 此处显示有关此函数的摘要
%   此处显示详细说明
if (nargin==3)
    show_out=0;
end

c=10.^(power_db./10);               % 这里是幅度——功率
xc=random('Normal',0,variance,1,shape(1,end)); 
xc(1,1:end)=xc(1,1:end)+c(1,1);
index=1;
for i=1:length(power_db)
    xc(1,index:shape(1,i))=xc(1,index:shape(1,i)).*c(1,i)./c(1,1);
    index=shape(1,i)+1;
end


if show_out==1
   plot(20.*log(abs(xc))./log(10));
end

end