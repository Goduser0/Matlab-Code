function test2
%数值分析上机实验二：编制多项式最小二乘拟合程序，并对习题3.9中的数据进行最小二乘拟合
%输入：
%输出：

%%原始数据
x_origin=5:5:55;
y_origin=[1.27 2.16 2.86 3.44 3.87 4.15 4.37 4.51 4.58 4.62 4.64];
scatter(x_origin,y_origin,'*');
title('原始数据');
xlabel('时间t/min');
ylabel('浓度y(×10^-4)');
hold on;
%% 选择拟合类型
fun = listdlg(...
    "ListString",{'多项式最小二乘拟合','指数型转多项式最小二乘拟合','正交化多项式最小二乘拟合'}, ...
    "SelectionMode","single", ...
    "PromptString",'请选择拟合类型'...
    );
if(fun==1)
    x0=x_origin;
    y0=y_origin;
elseif(fun==2)
    x0=1./x_origin;
    y0=log(y_origin);
elseif(fun==3)
    x0=x_origin;
    y0=y_origin;
else
    errordlg('ERROR:拟合类型选择错误')
end
%% 输入拟合阶次
n=inputdlg({'请输入拟合阶次:'},'拟合阶次',1,{'1'});
n=str2double(char(n));
%% 多项式拟合
alpha=polyfit(x0,y0,n);
%多项式拟合误差
y_hat=polyval(alpha,x0);
r=(y0-y_hat)*(y0-y_hat)';
%% 绘制拟合图像
x_start=x_origin(1);
x_end=x_origin(end);
if(fun==1)
    x=x_start:0.05:x_end;
    y=polyval(alpha,x);
    plot(x,y)
    fprintf('%g次多项式拟合\n',n);
    disp(['平方误差：',sprintf('%g',r)]);
    disp(['参数alpha：',sprintf('%g\t',alpha)])
elseif(fun==2)
    x=x_start:0.05:x_end;
    y=exp(alpha(2)).*exp(alpha(1)./x);
    fprintf('指数型转%g次多项式拟合\n',n);
    disp(['平方误差：',sprintf('%g',r)]);
    disp(['参数alpha：',sprintf('%g\t',alpha)])
    plot(x,y)
elseif(fun==3)
    w=ones(1,length(x_origin));
    dlsa(x_origin,y_origin,w,n);
end
legend('原始数据','拟合曲线')

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
disp('正交化多项式最小二乘拟合');
disp(['平方误差：',sprintf('%g',r)]);
disp(['参数alpha：',sprintf('%g\t',alpha)])
grid on;