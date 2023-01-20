using LinearAlgebra, ControlSystems
using Plots

# Primer 1
# Izvršiti diskretizaciju datog linearnog vremenski
# kontinualnog matematičkog modela u prostoru stanja
A = [-3 -2; 1 0];
B = [1; 0];
C = [0 5];
D = 0;

m = ss(A, B, C, D);		# remenski kontinualan model

Ts = 0.1;
md = c2d(m,Ts)			# vremenski diskretitovan model

# Simulacija
n = Int(5 / Ts+1)			# broj trenutaka u intervalu [0 5] sekundi
u = ones(n)				# neka je ulaz konstantan: u(t)=1
x0 = [0.0; 0.0]			# pocetne vrednosti promenljivih stanja
x = x0
X = zeros(n,2)			# trajektorija kretanja prom. stanja
X[1,:] = x'				# x0

for k = 1:(n-1)
	global x = E*x + F*u[k]
	global X[k+1,:] = x'
end

Y = C*X' + D*u'			# izlazi modela
t = (0:n-1)*Ts

plot(t, Y', title="Jedinicni odziv - diskretizovan", xlabel="t", linetype=:steppost)

# Primer 2
# Izvršiti diskretizaciju datog linearnog vremenski
# kontinualnog matematičkog modela u prostoru stanja
A = [-2 1; 0 -3];
B = [0; 5];
C = [1 0];
D = 0;

Ts = 0.1;

m = ss(A, B, C, D);
md = c2d(m,Ts)

# Simulacija
n = Int(10/Ts+1)		# broj trenutaka u intervalu [0 10] sekundi
u = ones(n)				# neka je ulaz konstantan: u(t)=1
x0 = [0.0; 0.0]			# pocetne vrednosti promenljivih stanja
x = x0
X = zeros(n,2)			# trajektorija kretanja prom. stanja
X[1,:] = x'				# x0

for k = 1:(n-1)
	global x = E*x + F*u[k]
	global X[k+1,:] = x'
end

Y = C*X' + D*u'			# izlazi modela
t = (0:n-1)*Ts

plot(t, Y', title="Jedinicni odziv - diskretizovan", xlabel="t", linetype=:steppost)

