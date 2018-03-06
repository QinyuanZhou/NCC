%EBC�ĺ��ĺ���
%���룺��������I��ģ��T���ֿ�r��ÿ������n��NCC��ֵth
%�����NCC���ֵNm����������λ�ã�Xm��Ym��
function [Xm,Ym,Nm]=core_EBC(I,T,r,n,th)
Nm=th;%��ǰ��NCCֵ
%ģ����ԭʼͼ��ĵĴ�С
tempSize=size(T);
N=tempSize(1);%ģ�������
M=tempSize(2);%ģ�������
srcSize=size(I);
H=srcSize(1);%����ͼƬ������
W=srcSize(2);%����ͼƬ������
%��ģ��ֳ�r�֣�1��r-1ÿ��n�У�ʣ����ǵ�r��
A=cell(r,1);
for t=1:r-1
    A{t}=T(((t-1)*n+1):t*n,:);
end
A{r}=T(((r-1)*n+1):N,:);
%����ÿ�ݵ�ÿ��Ԫ��ƽ����ΪAA
AA=cell(r,1);
for t=1:r
    AA{t}=A{t}.^2;
end
%����ÿ�ݵ�ƽ���ͼ�Ϊaa
aa=zeros(r,1);
for i=1:r
    aa(i)=sum(sum(AA{i}));
end
Tsum=sqrt(sum(aa));%����ģ���2����
Xm=1;
Ym=1;%��ʼNCC���ֵλ��Ϊ��1,1��
%������������
for height=1:H-N
    for width=1:W-M
%����ǰ�������ڷֳɶ�Ӧr�飬���µ�ÿ���ƽ����I3���ͻ��������µ�2����Isum
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
%������Nmxһֱ����Nmʱ�����ù�ʽ�Է������ν���r�����ţ��ӿ����
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
                Nmx=BB/(Tsum*Isum);%��λ���µ�NCCֵ
   %�����֮ǰ���ҵ�NCCֵ�������Nm�����´�ʱλ�ã�Xm,Ym��
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
            
                   
            
            
            
                    
            
        