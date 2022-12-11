using Plots, DifferentialEquations

# Primer 1
function sistem!(dx, x, p, t)
	m1, m2, c, k1, k2, R, g = p
	f = sin(t)
	J = 1 / 2 * m1 * Rˆ2
	
	dx[1] = x[2]
	dx[2] = (1 / J) * (k2 * (x[3] - R * x[1]) * R - k1 * x[1] - c * x[2])
	dx[3] = x[4]
	dx[4] = (1 / m2) * (f + m2 * g - k2 * (x[3] - R * x[1]))
end

t = (0.0, 20.0)
p = (10.0, 5.0, 10.0, 15.0, 10.0, 1.0, 9.81)
x0 = [0.0, 0.0, 2.0, 0.0]

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

θ = [x[1] for x in sol.u]
ω = [x[2] for x in sol.u]
α = diff(ω) ./ diff(sol.t)

plot(sol.t, [θ, ω], lw=2, label=["θ(t)" "ω(t)"])
plot!(sol.t[1:end-1], α, lw=2, label="α(t)")

# Primer 2
using Plots, DifferentialEquations

function signal(t)
	tp = rem.(t, 3)
	y = (-1 / 3 * t .+ 5) .* (tp .< 2)
end

function sistem!(dx, x, p, t)
	m1, m2, c, k1, k2, R, g = p
	J = 1 / 2 * m1 * Rˆ2
	f = signal(t)

	dx[1] = x[2]
	dx[2] = (-1 / J) * (k2 * (x[3] + R * x[1]) * R + c * Rˆ2 * x[2])
	dx[3] = x[4]
	dx[4] = (1 / m2) * (m2 * g - f - k1 * x[3] - k2 * (x[3] + R * x[1]))
end

t = (0.0, 15.0)
p = (10.0, 5.0, 10.0, 15.0, 10.0, 1.0, 9.81)
x0 = [0.0, 0.0, 0.0, 0.0]

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

x = [x[3] for x in sol.u]
predjeni_put = sum(abs.(diff(x)))
println(predjeni_put)

θ = [x[1] for x in sol.u]
ω = [x[2] for x in sol.u]
plot(sol.t, [θ, ω], lw=2, label=["θ(t)" "ω(t)"])

# Primer 3
function sistem!(dx, x, p, t)
	m, c1, c2, k1, k2, g = p
	f = sin(t)
	
	dx[1] = x[2]
	dx[2] = (1 / m) * (m * g - k1 * x[1] - k2 * (x[1] - x[3]) - c1 * x[2])
	dx[3] = (k2 * (x[1] - x[3]) - 3 * f) / (9 * c2)
end

x0 = [-1.0, 0.0, 0.0]
t = (0.0, 100.0)
p = (10.0, 10.0, 10.0, 15.0, 10.0, 9.81)

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

v = [x[2] for x in sol.u]
plot(sol.t[sol.t .<= 20], v[sol.t .<= 20], label="v(t)", lw=2)

x1 = [x[1] for x in sol.u]
x2 = [x[3] for x in sol.u]
plot(sol.t, [x1, x2], label=["x1(t)" "x2(t)"], legend=:bottomright, lw=2, yticks=-1:6)

