function test1
%% 递推步数
step=9;
x=0:1:step;
%% 精确计算
I=cal_I(x);
%% 递推计算
I_star=zeros(1,length(x));
I_star(1)=1-0.3679;
for x=1:step
    I_star(x+1)=1-x*I_star(x);
end
%%
x=0:1:step;
subplot(1,2,1)
plot(x,I,'--')
hold on;
plot(x,I_star,'-*')
xlabel('递推步数')
ylabel('精确值/递推值')
legend('精确计算','递推计算')
subplot(1,2,2)
plot(x,abs(I-I_star),'--');
xlabel('递推步数')
ylabel('误差绝对值')
grid on;
disp(['递推步数：',sprintf('%g\t',step)]);
disp('精确值：');
disp(I);
disp(['递推值：',sprintf('%g\t',I_star)])
disp(['误差值：',sprintf('%g\t',abs(I-I_star))])
%%
function result=cal_I(n)
%功能：计算积分I
syms x
fx=(x.^n)*(exp(x-1));
result=int(fx,x,0,1);
