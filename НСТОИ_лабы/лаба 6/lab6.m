%1. Провести тестирование сети Кохонена для нового вектора и
%определить его принадлежность к одному из кластеров
clear all;
close all;
P=rands(2,100);
figure('Name','Исходные векторы');
plot(P(1,:),P(2,:),'*g');

net=newsom([-1 1; -1 1],[5 6]);
figure('Name','Весовые коэффициенты - до обучения');
plotsom(net.IW{1,1},net.layers{1}.distances);

net.trainParam.epochs=10;
net=train(net,P);
figure('Name','Весовые коэффициенты - 10 эпох');
plotsom(net.IW{1,1},net.layers{1}.distances);
hold on;
plot(P(1,:),P(2,:),'*g');
hold off;

Y=sim(net,[0.7;-0.3]);
disp(Y);
figure('Name','Тестирование сети Кохонена');
plot(0.7,-0.3,'*k');
hold on;
plotsom(net.IW{1,1},net.layers{1}.distances);
plot(P(1,:),P(2,:),'*g');
hold off;

a=sim(net,P)
disp(a);
%анализ рапределения данных по кластерам
figure('Name','Анализ рапределения данных по кластерам');
bar(sum(a'));

smesh=7.5;
P1=randn(2,20);
A2(1,1:20)=0;
A2(2,1:20)=smesh;
P2=randn(2,20) + A2;
A3(1,1:20)=smesh;
A3(2,1:20)=0;
P3=randn(2,20) + A3;
A4(1,1:20)=smesh;
A4(2,1:20)=smesh;
P4=randn(2,20) + A4;
A5(1,1:20)=0;
A5(2,1:20)=2*smesh;
P5=randn(2,20) + A5;
A6(1,1:20)=smesh;
A6(2,1:20)=2*smesh;
P6=randn(2,20) + A6;

P=[P1 P2 P3 P4 P5 P6];%входной вектор
figure('Name','Исходные векторы');
plot(P(1,:),P(2,:),'*b');
net=newsom([-1 1; -1 1],[3 2],'randtop');
figure('Name','Весовые коэффициенты - до обучения');
plotsom(net.IW{1,1},net.layers{1}.distances);

%развертывание сетки
net.trainParam.epochs=50;
net=train(net,P);
figure('Name','Весовые коэффициенты - 50 эпох');
hold on;
plotsom(net.IW{1,1},net.layers{1}.distances);
plot(P(1,:),P(2,:),'*b');
hold off;

%тестируем сеть на кластере как и P2
PT=randn(2,20);
Y=sim(net,PT);
Y
figure('Name','Тестирование сети Кохонена');
hold on;
plot(P(1,:),P(2,:),'*b');
plot(PT(1,:),PT(2,:),'og');
hold off;
a=sim(net,PT);
%анализ рапределения тестирующей выборки по кластерам
figure('Name','Анализ рапределения тестирующей выборки по кластерам');
bar(sum(a'));

a=sim(net,P);
%анализ рапределения данных по кластерам
figure('Name','Анализ рапределения данных по кластерам');
bar(sum(a'));