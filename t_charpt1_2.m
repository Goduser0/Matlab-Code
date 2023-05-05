function  t_charpt1_2

%% 选择递推关系式
options = {'E.1.6', 'E.1.7'};
equation = listdlg( ...
    'PromptString', '请选择递推关系式：', ...
    'SelectionMode', 'single', ...
    'ListString', options);
%% 选择递推步数
steps = inputdlg( ...
    {'请输入递推步数n:'}, ...
    'chatpt 1_2', ...
    1, ...
    {'10'});
steps = str2double(char(steps));

if steps<1
    errordlg('递推步数错误！！！');
    return;
end
%% 选择有效数字位数
Sd = inputdlg( ...
    {'请输入计算中所采用的有效数字位数：'}, ...
    'charpt1_2', ...
    1, ...
    {'5'});
Sd = str2double(char(Sd));
%%
format long %设置显示精度
result = zeros(1, steps); %存储计算结果
err = result; %存储计算的绝对误差
func = result; %存储用库函数quadl计算出的积分的近似值
%% 用库函数quadl计算积分的近似值
for n=1:steps
    fun = @(x) x.^n.*exp(x-1);
    func(n) = integral(fun, 0, 1);
end

if equation == 1
    %用E.1.6计算
    digits(Sd);
    result(1) = subs(vpa(1-n*result(n-1)));
    for n=2:steps
        result(n) = subs(vpa(1-n*result(n-1)));
    end
    err = abs(result-func);

elseif equation == 2
    %用E.1.7计算
    digits(Sd);
    result(steps) = 0;
    for n=steps:-1:2
        result(n-1)=subs(vpa((1-result(n))/n));
    end
    err = abs(result-func);
end
%% Display
clf;
disp('递推值：');
fprintf('%e \n', result);
disp('误差：');
fprintf('%e \n', err);
plot(1:steps, result, '-');
grid on
hold on;
plot(1:steps, err, 'r--');
xlabel('n');
ylabel('En- and ERR n--');
text(2, err(2), '\uparrow err(n)');
text(4, result(4), '\downarrow En');
