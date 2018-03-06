%EBC的核心函数
%输入：搜索区域I，模板T，分块r，每块行数n，NCC初值th
%输出：NCC最大值Nm，及其所在位置（Xm，Ym）
function [Xm,Ym,Nm]=core_EBC(I,T,r,n,th)
Nm=th;%当前的NCC值
%模板与原始图像的的大小
tempSize=size(T);
N=tempSize(1);%模板的行数
M=tempSize(2);%模板的列数
srcSize=size(I);
H=srcSize(1);%搜索图片的行数
W=srcSize(2);%搜索图片的列数
%将模板分成r分，1到r-1每份n行，剩余的是第r行
A=cell(r,1);
for t=1:r-1
    A{t}=T(((t-1)*n+1):t*n,:);
end
A{r}=T(((r-1)*n+1):N,:);
%计算每份的每个元素平方记为AA
AA=cell(r,1);
for t=1:r
    AA{t}=A{t}.^2;
end
%计算每份的平方和记为aa
aa=zeros(r,1);
for i=1:r
    aa(i)=sum(sum(AA{i}));
end
Tsum=sqrt(sum(aa));%计算模板的2范数
Xm=1;
Ym=1;%初始NCC最大值位置为（1,1）
%滑动窗口搜索
for height=1:H-N
    for width=1:W-M
%将当前滑动窗口分成对应r块，记下的每块的平方和I3，和滑动窗口下的2范数Isum
        [I3,Isum]=Ic(height,width,r,n,I,M,N);
        B=zeros(r,1);
        for t=1:r
            B(t)=sqrt(I3(t)*aa(t));
        end
        BB=sum(B);
        Nmx=BB/(Tsum*Isum);
        if Nmx<=Nm
            continue;
        else
            c=zeros(r,1);
%当所求Nmx一直大于Nm时，利用公式对分子依次进行r次缩放，加快计算
            k=0;
            for t=1:r-1
                for i=(t-1)*n+1:t*n
                    for j=1:M
                        c(t)=c(t)+I(height+i,width+j)*T(i,j);
                    end                    
                end
                BB=BB+c(t)-B(t);
                Nmx=BB/(Tsum*Isum);
                if Nmx<=Nm
                    break;
                else
                    k=k+1;
                end
            end
            if k==r-1
                for i=(r-1)*n+1:N
                    for j=1:M
                        c(r)=c(r)+I(height+i,width+j)*T(i,j);
                    end
                end
                BB=BB+c(r)-B(r);
                Nmx=BB/(Tsum*Isum);%此位置下的NCC值
   %如果比之前所找的NCC值大，则代替Nm并记下此时位置（Xm,Ym）
                if Nmx>=Nm
                    Xm=height;
                    Ym=width;
                    Nm=Nmx;
                end
            end
        end
    end
end
end
            
                   
            
            
            
                    
            
        