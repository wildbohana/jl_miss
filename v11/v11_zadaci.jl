using DifferentialEquations, Plots, LinearAlgebra

# Primer 1
function sistem(dx, x, p, t)
	y = x[1] - 2 * x[2]
	r = sin(2 * t)
	u = r - 0.1 * yˆ2

	dx[1] = -0.1 * x[1] + 0.25 * x[2]
	dx[2] = -0.5 * x[1] + 0.75 * u
end

tspan = (0.0, 5.0)
x0 = [0.5, -0.2]

prob = ODEProblem(sistem, x0, tspan)
sol = solve(prob)

x1 = [x[1] for x in sol.u]
x2 = [x[2] for x in sol.u]

y = x1 - 2 * x2
r = sin.(2 * sol.t)

plot(sol.t, r, label = "r")
plot!(sol.t, y, label = "y", xlabel = "t[s]")

# Primer 2
function sistem(dx, x, p, t)
	v = p;
	e = u(t) - 2*x[4];
	q = v(t) + x[1];

	dx[1] = e - 2*x[1];
	dx[2] = x[3];
	dx[3] = 3*q - x[2];
	dx[4] = 4*x[2] - x[4];
end

function u(t)
	tp = rem(t, 5);
	y = 5*tp * (tp < 1) + 5 * ((tp >=1) & (tp < 4)) + (-5*tp + 25) * (tp >=4);
end

interval = (0.0, 10.0);
x0 = [0.0, 2.0, 1.0, 0.0];
param = (t -> (t >= 3.0) ? 1.0 : 0.0);

prob = ODEProblem(sistem, x0, interval, param);
r = solve(prob);

y = [x[4] for x in r.u];
plot(r.t, y, label = "izlaz y", xlabel = "t[s]")

# Primer 3
function sistem!(dx, x, p, t)
	u = signal(t)
	e = u - x[5]
	k = 4 * x[3] + x[4]
	
	dx[1] = x[2]
	dx[2] = 0.5 * u + x[1] - x[1] * x[2]
	dx[3] = x[4]
	dx[4] = e - 2 * x[3] - x[4]
	dx[5] = k - 4/5 * x[5]
end

tspan = (0.0, 8.0)
x0 = [-1.0, 0.5, 0.0, 0.0, 0.0]

prob = ODEProblem(sistem!, x0, tspan)
sol = solve(prob)

t = 0:0.01:8
sol_interpolirano = sol(t)

y = [x[1] for x in sol_interpolirano.u]

p = 3 .* (y .< -3) .+ (-3/4 * y .+ 3/4) .* ((y .>= -3) .& (y .< 1))
x3 = [x[3] for x in sol_interpolirano.u]
x4 = [x[4] for x in sol_interpolirano.u]
k = 4 * x3 .+ x4

z = p .+ k
plot(t, z, lw=2)
