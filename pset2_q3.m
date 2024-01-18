% q3b
% parameter setting
beta = 0.95;
r = 0.05;

% iteration condition
w_grid = linspace(0.1, 15, 1000);
v = 0 * w_grid;
v_new = v;
diff = 1;

while diff > 10^(-10)
    for i = 1:length(w_grid)
        v_t = -Inf * ones(1, length(v));
        for j = 1:length(w_grid)
            if w_grid(j) <= w_grid(i) * (1+r)
                c = w_grid(i) - w_grid(j)/(1+r);
                v_t(j) = log(c) + beta * v(j);
            else
                break
            end
        end
        v_new(i) = max(v_t);
    end
    diff = max(abs(v_new - v));
    v = v_new;
end

v_analytical = zeros(1000);
for w_ind = 1:length(w_grid)
    v_analytical(w_ind) = value_fn_analytical(w_grid(w_ind), beta, r);
end
%plot
plot(w_grid, v_analytical)
hold on
plot(w_grid, v)
xlabel('w') 
ylabel('Value Function')
legend('Anlytical','Numerical')
title('Value Functions')
hold off

function value = value_fn_analytical(w, beta, r)
    B = 1/(1-beta);
    A = (log(1-beta)+log(1/(beta*(1+r)))*beta/(1-beta))/(1-beta);
    value = A + B*log(w);
end