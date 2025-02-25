format long g;
sum = length(t);
global U;
tao1 = linspace(0,0,sum);

for i = 1:sum
    q_1 = q1(i,2); dq_1 = dq1(i,2); ddq_1 = ddq1(i,2);
    tao1(i) = lagrange_forward(q_1,dq_1,ddq_1);
end
tao_out1_gen1_data = tao_out1_gen1.Data';
figure;
subplot(3,1,1);
plot(tao1,'r');
subplot(3,1,2);
plot(tao_out1_gen1_data,'g');
%error
subplot(3,1,3);
plot(tao1 - tao_out1_gen1_data);

