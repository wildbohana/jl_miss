using LinearAlgebra, Plots, DifferentialEquations

# Primer 1
function sistem!(dx, x, p, t)
	m, c1, c2, k = p
	f = sin(t)

	dx[1] = x[2]
	dx[2] = 1 / m * (f - k * x[1] - (c1 + c2) * x[2])
end

t = (0.0, 10.0)
x0 = [0, 0]
p = (10.0, 20.0, 20.0, 40.0)

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

plot(sol, label=["x1(t)" "x2(t)"], lw=2, xticks=0:10)

# Primer 2
function sistem!(dx, x, p, t)
	m, c, k, g = p
	f = cos(t)

	dx[1] = x[2]
	dx[2] = 1 / m * (f + m * g - k * x[1] - c * x[2])
end

t = (0.0, 20.0)
x0 = [0.0, 0.0]
p = (5.0, 10.0, 20.0, 9.81)

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

plot(sol, label=["x1(t)" "x2(t)"], lw=2, xticks=0:20)

# Primer 3
using LinearAlgebra, Plots, DifferentialEquations

function pobuda(t)
	tp = rem.(t, 5)

	y1 = (4 * tp) .* (tp .< 1)
	y2 = 4 .* ((tp .>= 1) .& (tp .< 2))
	y3 = (-2 * tp .+ 8) .* ((tp .>= 2) .& (tp .< 3)) 
	y4 = 2 .* ((tp .>= 3) .& (tp .< 4)) 
	y5 = (-2 * tp .+ 10) .* (tp .>= 4)

	y = y1 + y2 + y3 + y4 + y5
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, c3, k1, k2 = p
	f = pobuda(t)

	dx[1] = x[2]
	dx[2] = 1 / m1 * (f + c1 * (x[4] - x[2]) - k1 * x[1])
	dx[3] = x[4]
	dx[4] = - 1 / m2 * (c1 * (x[4] - x[2]) + (c2 + c3) * x[4] + k2 * x[3])
end

t = (0.0, 10.0)
p = (10.0, 15.0, 20.0, 20.0, 20.0, 40.0, 40.0)
x0 = [0.0, 0.0, 0.0, 0.0]

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

poz1 = [x[1] for x in sol.u]
poz2 = [x[3] for x in sol.u]
~ , index1 = findmax(abs.(poz1))
~ , index2 = findmax(abs.(poz2))

plot(sol.t, [poz1, poz2], lw=2, xticks=0:10, label=["x1(t)" "x2(t)"])
plot!([sol.t[index1]], [poz1[index1]], markershape=:o, label="max_poz1")
plot!([sol.t[index2]], [poz2[index2]], markershape=:o, label="max_poz2")

put1 = sum(abs.(diff(poz1)))
put2 = sum(abs.(diff(poz2)))

print("Predjeni put prvog tela je: ")
println(put1)
print("Predjeni put drugog tela je: ")
println(put2)

# Primer 4
function sistem!(dx, x, p, t)
	m1, m2, c, k1, k2, k3, g = p
	
	dx[1] = x[2]
	dx[2] = 1 / m1 * (m1 * g + k2 * x[3] - (k1 + k2) * x[1])
	dx[3] = x[4]
	dx[4] = 1 / m2 * (k2 * x[1] - m2 * g - c * x[4] - (k2 + k3) * x[3])
end

t = (0.0, 20.0)
p = (5.0, 8.0, 10.0, 20.0, 20.0, 20.0, 9.81)
x0 = [2.0, 0.0, 0.0, 0.0]

prob = ODEProblem(sistem!, x0, t, p)
sol = solve(prob)

v1 = [x[2] for x in sol.u]
v2 = [x[4] for x in sol.u]

~ , index1 = findmax(abs.(v1))
~ , index2 = findmax(abs.(v2))

plot(sol.t, [v1, v2], lw=2, label=["v1(t)" "v2(t)"])
plot!([sol.t[index1]], [v1[index1]], markershape=:o, label="max_v1")
plot!([sol.t[index2]], [v2[index2]], markershape=:o, label="max_v2")

a1 = diff(v1) ./ diff(sol.t)
a2 = diff(v2) ./ diff(sol.t)
plot(sol.t[1:end-1], [a1, a2], lw=2, label=["a1(t)", "a2(t)"])

