using Plots, DifferentialEquations

# Zadatak 1
function dif_jednacina!(dx, x, params, t)
	alpha, beta, gamma = params

	dx[1] = alpha * (x[2] - x[1])
	dx[2] = x[1] * (beta - x[3]) - x[2]
	dx[3] = x[1] * x[2] - gamma * x[3]
end

alpha = 10
beta = 27
gamma = 8/3
params = (alpha, beta, gamma)

interval = (0.0, 30.0)

pocetni_0 = [1.0, 0.0, 0.0]
pocetni_1 = [1.0, 0.01, 0.01]

prob_0 = ODEProblem(dif_jednacina!, pocetni_0, interval, params)
sol_0 = solve(prob_0)

prob_1 = ODEProblem(dif_jednacina!, pocetni_1, interval, params)
sol_1 = solve(prob_1)

plt_0 = plot(sol_0,
	title="Plot 0",
	xlabel = "t",
	ylabel = "u(t)")

plt_1= plot(sol_1,
	title="Plot 1",
	xlabel = "t",
	ylabel = "u(t)")

plt_final = plot(plt_0, plt_1, layout = (2, 1))
display(plt_final)

# Zadatak 2
function F(t)
	tp = rem(t, 3)

	y1 = 4 * tp * (tp < 1)
	y2 = 4 * ((tp >= 1) & (tp < 2))
	y3 = 0 * ((tp >= 2) & (tp < 3))

	y = y1 + y2 + y3
end

function dif_jednacina!(dx, x, params, t)
	A, B, C = params

	dx[1] = x[2]
	dx[2] = -3*x[2] - C*(x[2]-x[4]) - B*(x[1]-x[3])
	dx[3] = x[4]
	dx[4] = 1/2 * (C*(x[2]-x[4]) - A*x[3] + B*(x[1]-x[3]) + F(t))
end

A = 12
B = 8
C = 4
params = (A, B, C)

interval = (0.0, 9.0)
pocetni = [0.0 0.0 0.0 0.0]

plt_F = plot(F, interval[1], interval[2], ylabel="F", label="F(t)", xticks=0:1:9)

prob = ODEProblem(dif_jednacina!, pocetni, interval, params)
sol = solve(prob)

plt_sol = plot(sol, xlabel="t", ylabel="u(t)")

plt_final = plot(plt_F, plt_sol, layout = (2, 1))
display(plt_final)

