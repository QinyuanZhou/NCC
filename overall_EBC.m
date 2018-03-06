%完整的EBC
%输入：分的块数r，每块的行数为n，是否在线选参P_FLAG
%输出：最大的NCC的所在位置和其值
%推荐输入：overall_EBC(16,0.06,1)
function overall_EBC(r,n,P_FLAG)
tic;
template_rgb=imread('TT.png');
src_rgb=imread('II.png');
template=rgb2gray(template_rgb);
src=rgb2gray(src_rgb);
T=im2double(template);
I=im2double(src);
%模板与原始图像的的大小
tempSize=size(T);
N=tempSize(1);%模板的行数
M=tempSize(2);%模板的列数
srcSize=size(I);
H=srcSize(1);%搜索图片的行数
W=srcSize(2);%搜索图片的列数
%计算k的值，k值的依据是映射所需的最小计算量
k=1:min(M,N);
fk=min((W-M)*(H-N)*M*N./k.^4+(4*k).^2*M*N);
k=find((W-M)*(H-N)*M*N./k.^4+(4*k).^2*M*N==fk);
mm=floor(M/k);%映射的模板列
nn=floor(N/k);%映射的模板行
tt=zeros(nn,mm);%映射后的模板
%将原模板T缩放k倍后映射到模板tt
k1=ones(1,k);
k2=ones(k,1);
for i=0:k:k*(nn-1)
    for j=0:k:k*(mm-1)
        tt(i/k+1,j/k+1)=1/(k*k)*k1*T(i+1:i+k,j+1:j+k)*k2;
    end
end
HH=floor(H/k);%映射的搜索区域的行数
WW=floor(W/k);%映射的搜索区域的列数
%将原搜索区域I缩放k倍映射到的搜索区域ii
ii=zeros(HH,WW);
for i=0:k:k*(HH-1)
    for j=0:k:k*(WW-1)
        ii(i/k+1,j/k+1)=1/(k*k)*k1*I(i+1:i+k,j+1:j+k)*k2;
    end
end
%求出映射后的的最佳NCC值记为Pr和其位置（x1,y1）
[x1,y1,Pr]=core_EBC(ii,tt,16,round(0.06*nn),-1);
%是否在线选参
if (P_FLAG)
    [r,n]=predict(Pr,N);%根据映射图像在线选择参数
else
    n=round(n*N);%离线选参情况下每块的行数为n
end
%以映射的最佳位置为中心在原搜索区域的4k*4k的范围（Ih）内求出最佳的初始NCC值Nm1
Ih=I((x1-1)*k+1-2*k:(x1-1)*k+2*k+N,(y1-1)*k+1-2*k:(y1-1)*k+2*k+M);
[~,~,Nm1]=core_EBC(Ih,T,r,n,-1);
%以上求的最佳初始NCC值带入核心EBC函数求的最终NCC值Nm及其所在位置(Xm,Ym)
[Xm,Ym,Nm]=core_EBC(I,T,r,n,Nm1);
[Xm Ym Nm]
%输出最终匹配结果
figure('name','模板匹配结果'),
subplot(1,2,1),imshow(template),title('模板');
subplot(1,2,2),imshow(src);title('匹配结果'),hold on
rectangle('Position',[Ym Xm M N],'LineWidth',1,'LineStyle','--','EdgeColor','r'),
hold off
toc;
end



