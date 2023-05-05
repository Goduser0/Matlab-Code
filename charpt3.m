function charpt3
%数值实验三：含"实验3.1"和"实验3.2"
%子函数调用：dlsa
%输入：实验选择
%输出：原函数及求得的相应插值多项式的函数的图像以及参数alpha和误差r

result=inputdlg({'请选择实验，若选3.1，请输入1，否则输入2：'},'charpt_3',1,{'1'});
Nb=str2double(char(result));
if(Nb~=1)&&(Nb~=2) 
    errordlg('实验选择错误！');
    return;
end

x0=-1:0.5:2;
y0=[-4.447 -0.452 0.551 0.048 -0.447 0.549 4.552];
n=3;%n为拟合阶次
if(Nb==1)
    alpha=polyfit(x0,y0,n);
    y=polyval(alpha,x0);
    r=(y0-y)*(y0-y)';
    x=-1:0.01:2;
    y=polyval(alpha,x);
    plot(x,y,'k--');
    xlabel('x');ylabel('y0 * and polyfit. y--');
    hold on;
    plot(x0,y0,'*');
    title('离散数据的多项式拟合');
    grid on;
else
    result=inputdlg({'请输入权向量w:'},'charpt_3',1,{'[1 1 1 1 1 1 1]'});
    w=str2double(char(result));
    w=[1 1 1 1 1 1 1];
    [a,b,c,alpha,r]=dlsa(x0,y0,w,n);
end
disp(['平方误差：',sprintf('%g',r)]);
disp(['参数alpha：',sprintf('%g\t',alpha)])

%%
function [a,b,c,alpha,r]=dlsa(x,y,w,n)
%功能：用正交化方法对离散数据做多项式最小二乘拟合
%输入：m+1个离散点(x,y,w)，x，y，w分别用行向量给出
%   拟合多项式的次数n，0<n<m
%输出：三项递推公式的参数a，b，拟合多项式s(x)的系数c和alpha
%   平方误差r=(y-s,y-s)，并作离散点列和拟合曲线的图形
m=length(x)-1;
if(n<1||n>=m)
    errordlg('错误：n<1或者n>=m!');
    return;
end
%求三项递推公式的参数a，b，拟合多项式s(x)的系数c，其中d(k)=(y,sk)
s1=0; s2=ones(1,m+1); v2=sum(w);
d(1)=y*w'; c(1)=d(1)/v2;
for k=1:n
    xs=x.*s2.^2*w';
    a(k)=xs/v2;
    if(k==1)
        b(k)=0;
    else
        b(k)=v2/v1;
    end
    s3=(x-a(k)).*s2-b(k)*s1;
    v3=s3.^2*w';
    d(k+1)=y.*s3*w';
    c(k+1)=d(k+1)/v3;
    s1=s2;
    s2=s3;
    v1=v2;
    v2=v3;
end
%求平方误差
r=y.*y*w'-c*d';
%求拟合多项式s(x)的降幂系数alpha
alpha=zeros(1,n+1);
T=zeros(n+1,n+2);
T(:,2)=ones(n+1,1);
T(2,3)=-a(1);
if(n>=2)
    for k=3:n+1
        for i=3:k+1
            T(k,i)=T(k-1,i)-a(k-1)*T(k-1,i-1)-b(k-1)*T(k-2,i-2);
        end
    end
end
for i=1:n+1
    for k=i:n+1
        alpha(n+2-i)=alpha(n+2-i)+c(k)*T(k,k+2-i);
    end
end
%用秦九韶方法计算s(t)的输出序列(t,s)
xmin=min(x);
xmax=max(x);
dx=(xmax-xmin)/(25*m);
t=(xmin-dx):dx:(xmax+dx);
s=alpha(1);
for k=2:n+1
    s=s.*t+alpha(k);
end
%输出点列x-y和拟合曲线t-s的图形
plot(x,y,'*',t,s,'-');
title('离散数据的多项式拟合');
xlabel('x');ylabel('y');
grid on;
