var c k;

parameters alpha beta delta sigma k_b c_b k0;

alpha = 0.36;
beta = 0.95;
delta = 0.025;
sigma = 2;
k_b = (alpha*beta/(1-beta*(1-delta)))^(1/(1-alpha));
c_b = k_b^alpha-delta*k_b;
k0 = 0.1 * k_b;

model;

//resouce constraint
k + c = k(-1)^alpha + (1-delta)*k(-1);
//euler equation
c^(-sigma) = beta*c(+1)^(-sigma)*(alpha*k^(alpha-1)+1-delta);


end;

initval;
k = k0;
end;

endval;
k = k_b;
c = c_b;
end; 

resid;
check;

perfect_foresight_setup(periods = 200);
perfect_foresight_solver;