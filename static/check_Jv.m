close all;clc;clear;

alpha = [0, -90, 0, 0, 90, -90]; 
a = [0, 0, 425, 392, 0, 0];
d = [89.2, 0, 0, 109.3, 94.75, 82.5]; 
theta = [0, -90, 0, 90, 0, 0]; 
joint_value=[0,0,90,0,-90,-90];
delta = joint_value - theta;
vec_tool = [0;0;0];
% ps -> pos start && ms -> matrix start
[ps, ms] = fk(6, alpha, a, d, theta,delta,vec_tool);
disp(ms);
disp(rpy2T(ps));

Ts=0.004;
vec = [1;1;0];
vec = vec/sqrt(sum(vec.^2));
dis = 450/20 * Ts;
t=1;

%tp stands for time points
tp = t / Ts;
%np stands for new pos
np = zeros(6,tp);

% define every pos in every time point
for i = 1:3
    for j=1:tp
        np(i,j) = ps(i) + vec(i)*j * dis;
        np(4,j) = ps(4);np(5,j) = ps(5);np(6,j) = ps(6);
    end
end

% define every joint value in every time point
q = zeros(6, tp);
previous_q = (deg2rad(joint_value))';
for i = 1:tp
    T06 = rpy2T(np(:, i));  
    q_all = ur_ik(alpha, a, d, theta, delta, T06); 
    previous_q_expanded = repmat(previous_q', 8, 1);
    q_diff = sum(abs(q_all - previous_q_expanded), 2);
    [~, index] = min(q_diff); 
    q(:, i) = q_all(index, :)';  
    previous_q = q(:, i);
end

% go!
v1 = zeros(6,1);
v1(1) = dis*vec(1)/Ts;
v1(2) = dis*vec(2)/Ts;
v1(3) = dis*vec(3)/Ts;
theta_v = zeros(6,tp);
c_v = zeros(6,tp);

% pose for time point and matrix for time point
for i = 1:tp
    %this joint_value is calculated from ground truth
    joint_value = rad2deg(q(:,i)');
    delta = joint_value - theta;
    [ptn,mtn] = fk(6, alpha, a, d, theta, delta,vec_tool);
    R = [mtn(1:3,1:3),zeros(3,3);zeros(3,3),mtn(1:3,1:3)];
    Jv = get_Jv(deg2rad(alpha),a,d,deg2rad(joint_value));
    theta_v(:,i) = pinv(Jv)*v1;
    c_v(:,i) = Jv * theta_v(:,i);
end

theta_v = rad2deg(theta_v);
q = rad2deg(q);

% view result
figure(1);
subplot(2,3,1)
plot(diff(q(1,:))/Ts,'red');hold on; plot(theta_v(1,:),'blue');
subplot(2,3,2)
plot(diff(q(2,:))/Ts,'red');hold on;plot(theta_v(2,:),'blue');
subplot(2,3,3)
plot(diff(q(3,:))/Ts,'red');hold on;plot(theta_v(3,:),'blue');
subplot(2,3,4)
plot(diff(q(4,:))/Ts,'red');hold on;plot(theta_v(4,:),'blue');
subplot(2,3,5)
plot(diff(q(5,:))/Ts,'red');hold on;plot(theta_v(5,:),'blue');
subplot(2,3,6)
plot(diff(q(6,:))/Ts,'red');hold on;plot(theta_v(6,:),'blue');

figure(2);
subplot(2,3,1)
plot(diff(q(1,:))/Ts-theta_v(1,2:tp));
subplot(2,3,2)
plot(diff(q(2,:))/Ts-theta_v(2,2:tp));
subplot(2,3,3)
plot(diff(q(3,:))/Ts-theta_v(3,2:tp));
subplot(2,3,4)
plot(diff(q(4,:))/Ts-theta_v(4,2:tp));
subplot(2,3,5)
plot(diff(q(5,:))/Ts-theta_v(5,2:tp));
subplot(2,3,6)
plot(diff(q(6,:))/Ts-theta_v(6,2:tp));

figure(3);
subplot(2,3,1)
plot(c_v(1,:));
subplot(2,3,2)
plot(c_v(2,:));
subplot(2,3,3)
plot(c_v(3,:));
subplot(2,3,4)
plot(c_v(4,:));
subplot(2,3,5)
plot(c_v(5,:));
subplot(2,3,6)
plot(c_v(6,:));










