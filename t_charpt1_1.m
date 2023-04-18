function t_charpt1_1

result = inputdlg({'请输入扰动项：在[0 20]之间的整数'},'charpt 1_1', 1, {'19'});
Numb = str2double(char(result));
if ((Numb>20) || (Numb)<0)
    errordlg('请输入正确的扰动项：在[0 20]之间的整数！！！');
    return;
end

result = inputdlg({'请输入(0 1)之间的扰动常数：'},'charpt1_1',1,{'0.00001'});
ess = str2double(char(result));
ve = zeros(1,21);
ve(21-Numb) = ess;
root = roots(poly(1:20) + ve);
disp(['对扰动项', num2str(Numb), '加扰动',num2str(ess),'得到的全部根为：']);
disp(num2str(root))