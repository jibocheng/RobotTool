format long g;
sum = length(t);


tao1 = linspace(0,0,sum);
tao2 = linspace(0,0,sum);
tao3 = linspace(0,0,sum);
tao4 = linspace(0,0,sum);
tao5 = linspace(0,0,sum);
tao6 = linspace(0,0,sum);



for i = 1:sum
    

    q(1) = q1(i,2);       q(2) = q2(i,2);       q(3) = q3(i,2);       q(4) = q4(i,2);       q(5) = q5(i,2);         q(6) = q6(i,2); 
    dq(1) = dq1(i,2);     dq(2) = dq2(i,2);     dq(3) = dq3(i,2);     dq(4) = dq4(i,2);     dq(5) = dq5(i,2);       dq(6) = dq6(i,2);
    ddq(1) = ddq1(i,2);   ddq(2) = ddq2(i,2);   ddq(3) = ddq3(i,2);   ddq(4) = ddq4(i,2);   ddq(5) = ddq5(i,2);     ddq(6) = ddq6(i,2);
    
   tao = newtonEuler_cal(q,dq,ddq);
   
    tao1(i) = tao(1);
    tao2(i) = tao(2);
    tao3(i) = tao(3);  
    tao4(i) = tao(4);
    tao5(i) = tao(5);
    tao6(i) = tao(6);

end


figure;
subplot(6,1,1);
plot(tao1,'r');hold on;plot(tao_data_1.Data,'b');
subplot(6,1,2);
plot(tao2,'r');hold on;plot(tao_data_2.Data,'b');
subplot(6,1,3);
plot(tao3,'r');hold on;plot(tao_data_3.Data,'b');
subplot(6,1,4);
plot(tao4,'r');hold on;plot(tao_data_4.Data,'b');
subplot(6,1,5);
plot(tao5,'r');hold on;plot(tao_data_5.Data,'b');
subplot(6,1,6);
plot(tao6,'r');hold on;plot(tao_data_6.Data,'b');

figure;
subplot(6,1,1);
plot(tao1'-tao_data_1.Data);
subplot(6,1,2);
plot(tao2'-tao_data_2.Data);
subplot(6,1,3);
plot(tao3'-tao_data_3.Data);
subplot(6,1,4);
plot(tao4'-tao_data_4.Data);
subplot(6,1,5);
plot(tao5'-tao_data_5.Data);
subplot(6,1,6);
plot(tao6'-tao_data_6.Data);