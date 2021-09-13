function [ index, XT, xc_tpn ] = cfar_tc( xc, xc_tp, N, pro_N, PAD)
%   假设回波服从高斯分布
%   
xc_tc=zeros(1,length(xc));
alpha=N.*(PAD.^(-1./N)-1);
xc_tc(1,2:end-1)=xc_tp(1,2:end-1)./3+xc(1,1:end-2)./3+xc(1,3:end)./3;
xc_tpn=xc_tp(1,1:end)./2+xc(1,1:end)./2;
xc_tc(1,1)=xc_tpn(1,1);
xc_tc(1,end)=xc_tpn(1,end);

index=1+N/2+pro_N/2:length(xc)-N/2-pro_N/2;
XT=zeros(1,length(index));

for i=index
    cell_left=xc_tc(1,i-N/2-pro_N/2:i-pro_N/2-1);
    cell_right=xc_tc(1,i+pro_N/2+1:i+N/2+pro_N/2);
    Z=(sum(cell_left)+sum(cell_right))./N;
    
    XT(1,i-N/2-pro_N/2)=Z.*alpha;
end

end