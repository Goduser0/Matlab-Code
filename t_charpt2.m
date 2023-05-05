function t_charpt2
%数值实验二：含"实验2.1：多项式插值的振荡现象"和"实验2.2：样条插值的收敛"
%输入：试验选择，函数式选择，插值节点数
%输出：拟合函数及原函数的图形
%% 选择递推关系式
options = {'2.1', '2.2'};
test = listdlg( ...
    'PromptString', '请选择实验：', ...
    'SelectionMode', 'single', ...
    'ListString', options);
%% 选择实验函数
options = {'f(x)', 'h(x)', 'g(x)'};
fun = listdlg( ...
    "PromptString", '请选择实验函数：',...
    "SelectionMode", 'single', ...
    "ListString", options...
    );
%% 选择插值多项式的次数
Nd = inputdlg({'请选择插值多项式的次数N：'}, 'charpt_2', 1, {'10'});
Nd = str2double(char(Nd));
%%
switch fun
    case 1
        f = inline('1./(1+25*x.^2)');a = -1;b = 1;
    case 2
        f = inline('x./(1+x.^4)');a = -5;b = 5;
    case 3
        f = inline('atan(x)');a = -5;b = 5;
end
%%
if(test==1)
    x0=linspace(a,b,Nd+1);y0=feval(f,x0);
    x=a:0.1:b;y=Lagrange(x0,y0,x);
    clf;
    fplot(f,[a b],'co');
    hold on;
    plot(x,y,'b-');
    xlabel('x');ylabel('y=f(x)o and y=Ln(x)--')
elseif(test==2)
    x0=linspace(a,b,Nd+1);y0=feval(f,x0);
    x=a:0.1:b;
    cs=spline(x0,y0);y=ppval(cs,x);
    clf;
    fplot(f,[a b],'co');
    hold on;
    plot(x,y,'k-');
    xlabel('x');ylabel('y=f(x)o and y=Spline(x)-')
end
%%
function y=Lagrange(x0,y0,x)
    n=length(x0);
    m=length(x);
    for i=1:m
        z=x(i);
        s=0.0;
        for k=1:n
            p=1.0;
            for j=1:n
                if(j~=k)
                    p=p*(z-x0(j))/(x0(k)-x0(j));
                end
            end
            s=s+p*y0(k);
        end
        y(i)=s;
    end

%%
x0=0:10;
y0=[0.8,0.0,0.79,1.53,2.19,2.71,3.03,3.27,2.89,3.06,3.19,3.29,0.2];
x=0:0.1:10;
cs=spline(x0,y0);
y=ppval(cs,x);
plot(x0,y0(2:12),'o');
hold on;
plot(x,y,'k-');
xlabel('x');
ylabel('y=f(x) o and y=Spline(x) -')

