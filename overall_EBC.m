%������EBC
%���룺�ֵĿ���r��ÿ�������Ϊn���Ƿ�����ѡ��P_FLAG
%���������NCC������λ�ú���ֵ
%�Ƽ����룺overall_EBC(16,0.06,1)
function overall_EBC(r,n,P_FLAG)
tic;
template_rgb=imread('TT.png');
src_rgb=imread('II.png');
template=rgb2gray(template_rgb);
src=rgb2gray(src_rgb);
T=im2double(template);
I=im2double(src);
%ģ����ԭʼͼ��ĵĴ�С
tempSize=size(T);
N=tempSize(1);%ģ�������
M=tempSize(2);%ģ�������
srcSize=size(I);
H=srcSize(1);%����ͼƬ������
W=srcSize(2);%����ͼƬ������
%����k��ֵ��kֵ��������ӳ���������С������
k=1:min(M,N);
fk=min((W-M)*(H-N)*M*N./k.^4+(4*k).^2*M*N);
k=find((W-M)*(H-N)*M*N./k.^4+(4*k).^2*M*N==fk);
mm=floor(M/k);%ӳ���ģ����
nn=floor(N/k);%ӳ���ģ����
tt=zeros(nn,mm);%ӳ����ģ��
%��ԭģ��T����k����ӳ�䵽ģ��tt
k1=ones(1,k);
k2=ones(k,1);
for i=0:k:k*(nn-1)
    for j=0:k:k*(mm-1)
        tt(i/k+1,j/k+1)=1/(k*k)*k1*T(i+1:i+k,j+1:j+k)*k2;
    end
end
HH=floor(H/k);%ӳ����������������
WW=floor(W/k);%ӳ����������������
%��ԭ��������I����k��ӳ�䵽����������ii
ii=zeros(HH,WW);
for i=0:k:k*(HH-1)
    for j=0:k:k*(WW-1)
        ii(i/k+1,j/k+1)=1/(k*k)*k1*I(i+1:i+k,j+1:j+k)*k2;
    end
end
%���ӳ���ĵ����NCCֵ��ΪPr����λ�ã�x1,y1��
[x1,y1,Pr]=core_EBC(ii,tt,16,round(0.06*nn),-1);
%�Ƿ�����ѡ��
if (P_FLAG)
    [r,n]=predict(Pr,N);%����ӳ��ͼ������ѡ�����
else
    n=round(n*N);%����ѡ�������ÿ�������Ϊn
end
%��ӳ������λ��Ϊ������ԭ���������4k*4k�ķ�Χ��Ih���������ѵĳ�ʼNCCֵNm1
Ih=I((x1-1)*k+1-2*k:(x1-1)*k+2*k+N,(y1-1)*k+1-2*k:(y1-1)*k+2*k+M);
[~,~,Nm1]=core_EBC(Ih,T,r,n,-1);
%���������ѳ�ʼNCCֵ�������EBC�����������NCCֵNm��������λ��(Xm,Ym)
[Xm,Ym,Nm]=core_EBC(I,T,r,n,Nm1);
[Xm Ym Nm]
%�������ƥ����
figure('name','ģ��ƥ����'),
subplot(1,2,1),imshow(template),title('ģ��');
subplot(1,2,2),imshow(src);title('ƥ����'),hold on
rectangle('Position',[Ym Xm M N],'LineWidth',1,'LineStyle','--','EdgeColor','r'),
hold off
toc;
end



