format long g;
sum = length(t);

tao1 = linspace(0,0,sum);
tao2 = linspace(0,0,sum);

for i = 1:sum
    q_1 = q1(i,2); q_2 = q2(i,2);
    dq_1 = dq1(i,2); dq_2 = dq2(i,2);
    ddq_1 = ddq1(i,2);ddq_2 = ddq2(i,2);
    
    [tao1(i),tao2(i)] = twolinkT2_tao_cal(q_1,dq_1,ddq_1,q_2,dq_2,ddq_2);
end
figure;
subplot(4,1,1);
plot(tao1,'r');hold on;plot(tao_data_1.Data,'b');
subplot(4,1,2);
plot(tao2,'r');hold on;plot(tao_data_2.Data,'b');
%error
subplot(4,1,3);
plot(tao1'-tao_data_1.Data);
subplot(4,1,4);
plot(tao2'-tao_data_2.Data);

