%% 常增益卡尔曼滤波
clc;clear
%% 最优滤波
K0 = 10;
P10 = K0 + 1;
Pk1k = [];
Pk = [];
N = 7;
for i = 1:N
    Pk1k = [Pk1k P10];
    K0 = P10/(1+P10);
    P10 = K0 +1;
    Pk = [Pk K0];
end

%% 常增益滤波
P0c = 10;
Kc = 0.618;
Pk1kc = [];
Pkc = [];
for i = 1:N
    P10c = P0c +1;
    Pk1kc = [Pk1kc P10c];
    P0c = (1-Kc)^2*P10c+Kc^2;
    Pkc = [Pkc P0c];
end
output = [Pk1k;Pk];
outputc = [Pk1kc;Pkc];
t = 1:N;
x = 1:0.1:N;
values = spcrv([[t(1) t t(end)];[Pk(1) Pk Pk(end)]],3);%曲线化
valuesc = spcrv([[t(1) t t(end)];[Pkc(1) Pkc Pkc(end)]],3);
plot(values(1,:),values(2,:), 'g',valuesc(1,:),valuesc(2,:),'r',t,Pk,'og',t,Pkc,'xr');
title('两种滤波的Pk变化');
axis([0.5 7 0.5 2.2]);%坐标位置
xlabel('k');
ylabel('Pk');
legend('最优滤波','常增益滤波')%添加图例
