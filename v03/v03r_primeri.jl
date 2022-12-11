using Plots, DifferentialEquations

# Primer 1
function dif_jedn!(y, param, t)
	α, λ = param

	dy = λ * exp(-α*t) * y
	return dy
end

function analiticko_resenje(t, y0, param)
	α, λ = param

	y = y0*exp.(λ/α*(1 .- exp.(-α*t)))
	return y
end

y0 = 1.0
parametri = (1.0, 1.0)
interval = (0.0, 5.0)

problem = ODEProblem(dif_jedn!, y0, interval, parametri)
num = solve(problem) # resenje

t1 = 0:0.01:5
analiticko = analiticko_resenje(t1, y0, parametri)

# interpolacija resenja novim vektorom t1
numericko = num(t1) 

plot(t1, analiticko, xlabel="num.t", ylabel="num.u", label="analiticko")
plot!(t1, numericko, label="numericko")


# Primer 2
function dif_jedn!(dx, x, param, t)
	A, B = param

	dx[1] = u(t) + A*x[3]
	dx[2] = x[3]
	dx[3] = -B*x[1] + x[2]
end

function u(t)
	tp = rem(t, 5)

	u1 = 3*tp * (tp < 1) + 3 * ((tp >= 1) & (tp < 3))
	u2 = (-tp * 3/2 + 15/2) * ((tp >= 3) & (tp <= 5))

	u = u1 + u2
end

x0y0 = [-1.0, 1.0, 0.5]
interval = (0.0, 15.0)
parametri = (2.0, 1.0)

prob = ODEProblem(dif_jedn!, x0y0, interval, parametri)
sol = solve(prob)

plot(sol, xlabel="sol.t", ylabel="sol.u", label = ["x1" "x2" "x3"])


