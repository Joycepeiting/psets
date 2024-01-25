var c k l;

parameters alpha beta delta sigma k_b c_b l_b k0 gamma;

alpha = 0.36;
beta = 0.95;
delta = 0.025;
sigma = 2;
gamma = 2.1718;
l_b = 1/3;
k_b = ((1/beta + delta - 1)/(alpha*l_b^(1-alpha)))^(1/(alpha-1));
c_b = k_b^alpha * l_b^(1-alpha) - delta * k_b;
k0 = 0.1 * k_b;

model;

//resouce constraint
k + c = k(-1)^alpha * l^(1-alpha) + (1-delta)*k(-1);
//euler equation
c = c(+1)/(beta * (alpha*k^(alpha-1)*l(+1)^(1-alpha)+1-delta));
//l^alpha = (k(-1)^alpha * (1-alpha))/(c*gamma);
l^(alpha) = beta * k(-1)^alpha * (alpha*k^(alpha-1)*l(+1)^(1-alpha)+1-delta) / (k^alpha * l(+1)^(-alpha));
end;

initval;
k = k0;
end;

endval;
k = k_b;
c = c_b;
l = l_b;
end; 

resid;
check;

perfect_foresight_setup(periods = 200);
//perfect_foresight_solver(linear_approximation);
perfect_foresight_solver;