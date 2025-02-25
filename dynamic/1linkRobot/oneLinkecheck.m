format long g;
sum = length(t);
global U;
tao1 = linspace(0,0,sum);

for i = 1:sum
    q_1 = q1(i,2); dq_1 = dq1(i,2); ddq_1 = ddq1(i,2);
    [tao1(i)] = oneLink_tao_cal(q_1,dq_1,ddq_1);
end
tao_out1_gen1_data = tao_out1_gen1.Data';
figure;
subplot(5,1,1);
plot(tao1,'r');
subplot(5,1,2);
plot(tao_out1','b');
subplot(5,1,3);
plot(tao_out1_gen1_data,'g');
%error
subplot(5,1,4);
plot(tao1'-tao_out1);
subplot(5,1,5);
plot(tao1 - tao_out1_gen1_data);
% simulation gen1
