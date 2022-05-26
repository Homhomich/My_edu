clear all;
close all;
Isize=5;%размер обрабатываемых изображений
IB=[0 1 1 1 0; %условное бинарное отображение буквы B
    0 1 0 1 0;
    0 1 1 0 0;
    0 1 0 1 0;
    0 1 1 1 0];
figure('Name','Буква - B - исходное');
imagesc(IB);
IC=[0 1 1 1 0; %условное бинарное отображение буквы С
    0 1 0 0 0;
    0 1 0 0 0;
    0 1 0 0 0;
    0 1 1 1 0];
figure('Name','Буква - C - исходное');
imagesc(IC);
for i=1:Isize,
      for j=1:Isize,
          if IB(i,j)==0 IB(i,j)=-1; end;
          if IC(i,j)==0 IC(i,j)=-1; end;
      end;
end;
%развертка матриц в векторы
cB=IB(:);
cC=IC(:);
T=[cB cC]
net=newhop(T);%создание сети  Хопфилда

po=0.1;%вероятность искажения единичного элемента (пикселя) изображения
IB1=IB;
IC1=IC;
for i=1:Isize,
      for j=1:Isize,
          xb=rand;
          xc=rand;
          if xb<po 
              IB1(i,j)=-IB(i,j); 
          end
          if xc<po 
              IC1(i,j)=-IC(i,j); 
          end
     end;
end;
Bi=IB1(:);
Ci=IC1(:);
figure('Name','Буква - B - испорченное');
imagesc(reshape(Bi,[5 5]));
figure('Name','Буква - C - испорченное');
imagesc(reshape(Ci,[5 5]));

% восстановление изображения
[Yb,Pf,Bf]=sim(net, 1, [], Bi);
[Yc,Pf,Cf]=sim(net, 1, [], Ci);
Yb1=round(Yb);
Yc1=round(Yc);
figure('Name','Буква - B - восстановленное');
imagesc(reshape(Yb1,[5 5]));
figure('Name','Буква - C - восстановленное');
imagesc(reshape(Yc1,[5 5]));

% Провести исследование влияние вероятности искажения пикселя на
%качество восстановления исходного изображения

cnt=1;
for po=0.1:0.05:0.3,
    IB1=IB;
    IC1=IC;
    for i=1:Isize,
          for j=1:Isize,
              xb=rand;
              xc=rand;
              if xb<po 
                  IB1(i,j)=-IB(i,j); 
              end
              if xc<po 
                  IC1(i,j)=-IC(i,j); 
              end
         end;
    end;
    Bi=IB1(:);
    Ci=IC1(:);

    % восстановление изображения
    [Yb,Pf,Bf]=sim(net, 1, [], Bi);
    [Yc,Pf,Cf]=sim(net, 1, [], Ci);
    Yb1=round(Yb);
    Yc1=round(Yc);
    
    IBish = IB(:);
    ICish = IC(:);
    errb_count = 0;
    errc_count = 0;
    for j = 1:size(IBish,1),
        if IBish(j) ~= Yb1(j)
            errb_count = errb_count+1;
        end;
        if ICish(j) ~= Yc1(j)
            errc_count = errc_count+1;
        end;
    end;
    errb(cnt) = errb_count/25;
    errc(cnt) = errc_count/25;
    errb_count = 0;
    errc_count = 0;
    cnt = cnt+1;
end;
x=0.1:0.05:0.3;
figure('Name','Ошибка восстановления буквы B');
plot(x, errb);
figure('Name','Ошибка восстановления буквы C');
plot(x, errc);

% Пункт 3
Isize=8;%размер обрабатываемых изображений
IB=[0 0 0 0 0 0 0 0; %условное бинарное отображение буквы B
    0 0 0 0 0 0 0 0;
    0 0 0 1 1 0 0 0;
    0 0 1 1 1 1 0 0;
    0 1 1 1 1 1 1 0;
    0 0 1 1 1 1 0 0;
    0 0 0 1 1 0 0 0;
    0 0 0 0 0 0 0 0];
figure('Name','Картинка - исходное');
imagesc(IB);
for i=1:Isize,
      for j=1:Isize,
          if IB(i,j)==0 IB(i,j)=-1; end;
      end;
end;
%развертка матриц в векторы
cB=IB(:);
T=[cB]
net=newhop(T);%создание сети  Хопфилда

po=0.1;%вероятность искажения единичного элемента (пикселя) изображения
IB1=IB;
for i=1:Isize,
      for j=1:Isize,
          xb=rand;
          xc=rand;
          if xb<po 
              IB1(i,j)=-IB(i,j); 
          end
     end;
end;
Bi=IB1(:);
figure('Name','Картинка - испорченное');
imagesc(reshape(Bi,[8 8]));

% восстановление изображения
[Yb,Pf,Bf]=sim(net, 1, [], Bi);
Yb1=round(Yb);
figure('Name','Картинка - восстановленное');
imagesc(reshape(Yb1,[8 8]));

% Провести исследование влияние вероятности искажения пикселя на
%качество восстановления исходного изображения

cnt=1;
for po=0.1:0.05:0.3,
    IB1=IB;
    for i=1:Isize,
          for j=1:Isize,
              xb=rand;
              if xb<po 
                  IB1(i,j)=-IB(i,j); 
              end
         end;
    end;
    Bi=IB1(:);

    % восстановление изображения
    [Yb,Pf,Bf]=sim(net, 1, [], Bi);
    Yb1=round(Yb);
    
    errb_count = 0;
    for j = 1:size(IBish,1),
        if Bi(j) ~= Yb1(j)
            errb_count = errb_count+1;
        end;
    end;
    errb(cnt) = errb_count/64;
    errb_count = 0;
    cnt = cnt+1;
end;
x=0.1:0.05:0.3;
figure('Name','Зависимость вероятности искажения от вероятности восстановления');
plot(x, errb);