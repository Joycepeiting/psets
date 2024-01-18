%q1a
clear
A = sym('a',[2 2]);
[V, D] = eig(A);
disp(V)
disp(D)
m1 = A*V;
m2 = V*D;
disp(norm(A*V - V*D))

%q1b
syms a11 a12 a21 a22
eigen_vector_q1b = eig([a11 a12; 0 a22]);
disp(eigen_vector_q1b)
[V2,D2] = eig([a11 a12; 0 a22]);
disp(V2)

%q1c
eigen_vector_q1c = eig([a11 0; a21 a22]);
disp(eigen_vector_q1c)
[V3,D3] = eig([a11 0; a21 a22]);
disp(V3)
