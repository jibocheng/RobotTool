format long g;
sum = length(t);
global U;
tao1 = linspace(0,0,sum);
tao2 = linspace(0,0,sum);
tao3 = linspace(0,0,sum);
tao4 = linspace(0,0,sum);


for i = 1:sum
    q_1 = q1(i,2); q_2 = q2(i,2); q_3 = q3(i,2); q_4 = q4(i,2);
    dq_1 = dq1(i,2); dq_2 = dq2(i,2); dq_3 = dq3(i,2); dq_4 = dq4(i,2);
    ddq_1 = ddq1(i,2);ddq_2 = ddq2(i,2);ddq_3 = ddq3(i,2); ddq_4 = ddq4(i,2);
    
    %[tao1(i),tao2(i)] = twolinkT2_tao_cal(q_1,dq_1,ddq_1,q_2,dq_2,ddq_2);
    %[tao1(i),tao2(i)] = twolinkT2_tao_linear_seprate_cal(q_1,dq_1,ddq_1,q_2,dq_2,ddq_2);
    [tao11, tao22,tao33,tao44] = lagrange_tao_cal(q_1, dq_1, ddq_1, q_2, dq_2, ddq_2, q_3, dq_3, ddq_3, q_4, dq_4, ddq_4);
    tao1(i) = tao11; tao2(i) = tao22; tao3(i) = tao33; tao4(i) = tao44;
end
figure;
subplot(4,1,1);
plot(tao1,'r');hold on;plot(tao_data_1.Data,'b');
subplot(4,1,2);
plot(tao2,'r');hold on;plot(tao_data_2.Data,'b');
subplot(4,1,3);
plot(tao3,'r');hold on;plot(tao_data_3.Data,'b');
subplot(4,1,4);
plot(tao4,'r');hold on;plot(tao_data_4.Data,'b');
%error
figure;
subplot(4,1,1);
plot(tao1'-tao_data_1.Data);
subplot(4,1,2);
plot(tao2'-tao_data_2.Data);
subplot(4,1,3);
plot(tao3'-tao_data_3.Data);
subplot(4,1,4);
plot(tao4'-tao_data_4.Data);

