function charpt4
%数值实验四：含"实验4.1：复化求积公式计算定积分"和"实验4.2：比较复化Simpson方法与变步长Simpson方法"
options={'实验4.1', '实验4.2'};
Nt=listdlg( ...
    'PromptString', '请选择实验：', ...
    'SelectionMode', 'single', ...
    'ListString', options);
if(Nt==1)
    Nb=listdlg( ...
        'PromptString','请选择积分公式',...
        'SelectionMode','single', ...
        'ListString',{'复化梯形','复化Simpson','复化Gauss_Legendre'}...
        );
    Nb_f=listdlg( ...
        'PromptString','请选择积分式题号1-4', ...
        'SelectionMode','single', ...
        'ListString',{'1','2','3','4'} ...
        );
    switch Nb_f
        case 1
            fun=inline('-2./(x.^2-1)');a=2;b=3;
        case 2
            fun=inline('4./(x.^2+1)');a=0;b=1;
        case 3
            fun=inline('3.^x');a=0;b=1;
        case 4
            fun=inline('x.*exp(x)');a=1;b=2;
    end
    tol=0.5e-7;
    if(Nb==1)%用复化梯形公式
        tic;
        t=(fun(a)+fun(b))*(b-a)/2;
        k=1;t0=0;
        while(abs(t-t0)>=tol*3)
            t0=t;
            h=(b-a)/2^k;
            t=t0/2+h*sum(fun(a+h:2*h:b-h));
            k=k+1;
        end
        time=toc;
    elseif(Nb==2)%用复化Simpson公式
        
    elseif(Nb==3)%拥复化Gauss_Legendre公式
    end

elseif(NT==2)

end
    