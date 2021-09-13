function [ index, XT ] = cfar_so( xc, N, pro_N, PAD)
%   假设回波服从高斯分布
%   alpha赋值有些问题，一个比较复杂的高次函数
alpha=N.*(PAD.^(-1./N)-1);

index=1+N/2+pro_N/2:length(xc)-N/2-pro_N/2;
XT=zeros(1,length(index));

for i=index
    cell_left=xc(1,i-N/2-pro_N/2:i-pro_N/2-1);
    cell_right=xc(1,i+pro_N/2+1:i+N/2+pro_N/2);
    Z=min([mean(cell_left),mean(cell_right)]);
    
    XT(1,i-N/2-pro_N/2)=Z.*alpha;
end

end