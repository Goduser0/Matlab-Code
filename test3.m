function test3
%数值实验5.1：常微分方程性态和R-K法稳定性实验

input=inputdlg({'请输入[-50,50]间的参数a：'},'test3',1,{'-8'});
a=str2double(char(input));
if((a<-50)||(a>50))
    errordlg('ERROR:参数a输入错误!')
    return;
end

input=inputdlg({'请输入(0,1)之间的步长h：'},'test3',1,{'0.02'});
h=str2double(char(input));
if((h<=0)||(h>=1))
    errordlg('ERROR:参数h输入错误!')
    return;
end

h=0.02
x=0:h:1;
y=x;
N=length(x);
y(1)=1;
func=inline('1+(y-x).*a');
for n=1:N-1
    k1=func(a,x(n),y(n));
    k2=func(a,x(n)+h/2,y(n)+k1*h/2);
    k3=func(a,x(n)+h/2,y(n)+k2*h/2);
    k4=func(a,x(n)+h,y(n)+k3*h/2);
    y(n+1)=y(n)+h*(k1+2*k2+2*k3+k4)/6;
end
y0=exp(a*x)+x;
plot(x,y0,'b+');
hold on;
plot(x,y,'c--');
hold on;
disp(['参数a：',sprintf('%g',a)])
disp(['步长h：',sprintf('%g',h)])
disp('精确值：')
disp(y0)
disp('计算值')
disp(y)

h=0.4;
x=0:h:1;
y=x;
N=length(x);
y(1)=1;
func=inline('1+(y-x).*a');
for n=1:N-1
    k1=func(a,x(n),y(n));
    k2=func(a,x(n)+h/2,y(n)+k1*h/2);
    k3=func(a,x(n)+h/2,y(n)+k2*h/2);
    k4=func(a,x(n)+h,y(n)+k3*h/2);
    y(n+1)=y(n)+h*(k1+2*k2+2*k3+k4)/6;
end
y0=exp(a*x)+x;
plot(x,y0,'r+');
hold on;
plot(x,y,'g--');
hold on;
disp(['参数a：',sprintf('%g',a)])
disp(['步长h：',sprintf('%g',h)])
disp('精确值：')
disp(y0)
disp('计算值')
disp(y)

xlabel('x');
ylabel('y0=exp(ax)+x:+  R-K(x):--');
legend('准确值,h=0.02','计算值,h=0.02','准确值,h=0.4','计算值,h=0.4')
