%滑动窗口下的区域求和
%输入(x,y)为当前搜索位置，I为搜索区域，模板大小M列N行
%输出每块的平方和I3，和滑动窗口下的2范数
function [I3,Isum]=Ic(x,y,r,n,I,M,N)
%将搜索区域分为相应的r分，并记为I1{r}
I1=cell(r,1);
for t=1:r-1
    I1{t}=I(((t-1)*n+x):(x+t*n-1),y:y+M-1);
end
I1{r}=I(((r-1)*n+x):x+N-1,y:y+M-1);
I2=cell(r,1);
%计算每份的每个元素平方记为I2
for t=1:r
    I2{t}=I1{t}.^2;
end
%计算每份的平方和记为I3
I3=zeros(r,1);
for t=1:r
    I3(t)=sum(sum(I2{t}));
end
%计算滑窗口下的2范数，记为Isum
Is=0;
for t=1:r
    Is=Is+I3(t);
end
Isum=sqrt(Is);
    