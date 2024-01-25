%pset4q2
alpha = 0.36;
beta = 0.95;
delta = 0.025;
l = 1/3;

k_steady = ((1/beta + delta - 1)/(alpha*l^(1-alpha)))^(1/(alpha-1));
c = k_steady^alpha * l^(1-alpha) - delta * k_steady;
gamma = (1-alpha)*l^(-alpha)*k_steady^(alpha)/c;
disp(k_steady)
disp(c)
disp(gamma)

%dynare
addpath /Applications/Dynare/5.5-arm64/matlab/;
dynare ngm_labor;

T = 100;
kt_dyn_q2 = k(1:T);
ct_dyn_q2 = c(2:T);
lt_dyn_q2 = l(2:T);

subplot(3,2,1);
plot (kt_dyn_q2, '-*g');
grid on
title('Captial Stock')
legend({'dynare'},'Location','southeast')
subplot(3,2,3);
plot (ct_dyn_q2, '-*g');
grid on
title('Consumption')
legend({'dynare'},'Location','southeast')
subplot(3,2,5);
plot (lt_dyn_q2, '-*g');
grid on
title('Labor')
legend({'dynare'},'Location','southeast')

%linear approximation using dynare
dynare ngm_labor_linear;

T = 100;
kt_dyn_q2_linear = k(1:T);
ct_dyn_q2_linear = c(2:T);
lt_dyn_q2_linear = l(2:T);

subplot(3,2,2);
plot (0:T-1, kt_dyn_q2, '-*g', 0:T-1, kt_dyn_q2_linear, 'r');
grid on
title('Captial Stock')
legend({'dynare','dynare(linear approximation'},'Location','southeast')
subplot(3,2,4);
plot (2:T, ct_dyn_q2, '-*g', 2:T, ct_dyn_q2_linear, 'r');
grid on
title('Consumption')
legend({'dynare','dynare(linear approximation'},'Location','southeast')
subplot(3,2,6);
plot (2:T, lt_dyn_q2, '-*g', 2:T, lt_dyn_q2_linear, 'r');
grid on
title('Labor')
legend({'dynare','dynare(linear approximation'},'Location','southeast')