%���������µ��������
%����(x,y)Ϊ��ǰ����λ�ã�IΪ��������ģ���СM��N��
%���ÿ���ƽ����I3���ͻ��������µ�2����
function [I3,Isum]=Ic(x,y,r,n,I,M,N)
%�����������Ϊ��Ӧ��r�֣�����ΪI1{r}
I1=cell(r,1);
for t=1:r-1
    I1{t}=I(((t-1)*n+x):(x+t*n-1),y:y+M-1);
end
I1{r}=I(((r-1)*n+x):x+N-1,y:y+M-1);
I2=cell(r,1);
%����ÿ�ݵ�ÿ��Ԫ��ƽ����ΪI2
for t=1:r
    I2{t}=I1{t}.^2;
end
%����ÿ�ݵ�ƽ���ͼ�ΪI3
I3=zeros(r,1);
for t=1:r
    I3(t)=sum(sum(I2{t}));
end
%���㻬�����µ�2��������ΪIsum
Is=0;
for t=1:r
    Is=Is+I3(t);
end
Isum=sqrt(Is);
    