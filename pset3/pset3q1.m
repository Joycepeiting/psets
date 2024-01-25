%Q1b Steady state calculation
beta = 0.95; sigma = 2; alpha = 0.36; delta = 0.025;

k_steady = ((1/beta + delta - 1)/alpha)^(1/(alpha-1));
disp(k_steady)

c_steady = k_steady^alpha - delta*k_steady;
disp(c_steady)

%Q1d eigenvalues & eigenvectors
du = c_steady^(-sigma);
d2u = c_steady^(-sigma-1) * (-sigma);
d2f = alpha*(alpha-1)*k_steady^(alpha-2);
A = [1/beta -1; -du*d2f/d2u 1+beta*du*d2f/d2u];
disp(A)
[V, D] = eig(A);
disp(D)
[~, ind] = sort(diag(D));
disp(V)
DS = D(ind, ind);
disp(DS)
VS = V(:, ind);
disp(VS)
V_inverse = inv(VS);
disp(V_inverse)


k_interval = linspace(0, 200, 200);
ct_simulation = zeros(1,200);
kt1_simulation = zeros(1,200);
k_t = 0.1*k_steady;
for i = 1:length(k_interval)
    ct_simulation(i) = ct_value(k_t, c_steady, k_steady, V_inverse);
    kt1_simulation(i) = k_tplus1_value(k_t, k_steady , DS);
    k_t = kt1_simulation(i);
end
k_analytical = [0.1*k_steady, kt1_simulation];
subplot(3,2,1)
plot(k_analytical(1:100));
grid on
title('Captial Stock')
legend({'linear approximation(analytical)'},'Location','southeast')
subplot(3,2,2)
plot(ct_simulation(1:100));
grid on
title('Consumption')
legend({'linear approximation(analytical)'},'Location','southeast')


addpath /Applications/Dynare/5.5-arm64/matlab/;
dynare ngm_model;

T = 100;
kt_dyn = k(1:T);
ct_dyn = c(2:T);
subplot(3,2,3)
plot (0:T-1,k_analytical(1:T), 'r', 0:T-1, kt_dyn, '-*g');
grid on
title('Captial Stock')
legend({'linear approximation(analytical)','dynare'},'Location','southeast')
subplot(3,2,4)
plot (2:T,ct_simulation(2:T), 'r', 2:T, ct_dyn, '-*g');
grid on
title('Consumption')
legend({'linear approximation(analytical)','dynare'},'Location','southeast')

dynare ngm_model_linear;

kt_dyn_linear = k(1:T);
ct_dyn_linear = c(2:T);
subplot(3,2,5)
plot ( 0:T-1, kt_dyn_linear, '-*g', 0:T-1,k_analytical(1:T), 'r');
grid on
title('Captial Shock')
legend({'dynare(linear approximation)','linear approximation(analytical)'},'Location','southeast')
subplot(3,2,6)
plot (2:T,ct_simulation(2:T), 'r', 2:T, ct_dyn_linear, '-*g');
grid on
title('Consumption')
legend({'dynare(linear approximation)','linear approximation(analytical)'},'Location','southeast')

function ct = ct_value(kt, c, k, V_inverse)
    ct = c - (kt - k) * V_inverse(2,1)/V_inverse(2,2);
end
function k_tplus1 = k_tplus1_value(kt, k, DS)
    k_tplus1 = k + DS(1,1)*(kt - k);
end
