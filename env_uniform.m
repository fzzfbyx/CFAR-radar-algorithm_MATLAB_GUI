function [ xc ] = env_uniform(variance,  shape, power_db, show_out)
%UNIFORM_EN 此处显示有关此函数的摘要
%   此处显示详细说明
if (nargin==3)
    show_out=0;
end

c=10^(power_db/10);     % 这里是幅度——功率
xc=c + random('Normal',0,variance,1,shape); 
if show_out==1
plot(10.*log(abs(xc))./log(10));
end

end