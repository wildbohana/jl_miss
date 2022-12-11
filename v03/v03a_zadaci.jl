using LinearAlgebra, Plots, DifferentialEquations

# Zadatak 1
function f(t)
	tp = rem.(t, 2)
	y = 5*tp * (tp <= 1) + (-5*tp+10) * (tp > 1)
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, c3, k1, k2 = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k2*(x[1]-x[3]) - k1*x[1])
	dx[3] = x[4]
	dx[4] = 1/m2 * (-(c3+c2)*x[4] + k2*(x[1]-x[3]) + f(t))
end

t = 0:0.01:20
plt_F = plot(t, f.(t), label="f(t)", xticks=0:1:20)

interval = (0.0, 20.0)
p = (20.0, 10.0, 10.0, 10.0, 10.0, 20.0, 40.0)
pocetni = [1.0, 0.0, 2.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

brzina_1 = [u[2] for u in sol.u]
pozicija_1 = [u[1] for u in sol.u]
brzina_2 = [u[4] for u in sol.u]
pozicija_2 = [u[3] for u in sol.u]

plt_sol = plot(sol.t, [brzina_1, brzina_2], label=["brzina 1" "brzina 2"], xlabel="t")

_, index_1 = findmax(abs.(brzina_1))
_, index_2 = findmax(abs.(brzina_2))

scatter!(plt_sol, 
		[sol.t[index_1], sol.t[index_2]],
		[brzina_1[index_1], brzina_2[index_2]],
		label="max brzina",
		marker=:circle, markersize=3)

put_1 = sum(abs.(diff(pozicija_1)))
put_2 = sum(abs.(diff(pozicija_2)))

println("Ukupan predjeni put 1. i 2. tela je:\n$put_1\n$put_2")

plt_final = plot(plt_F, plt_sol, layout=(2,1))
display(plt_final)

# Zadatak 2
function f(t)
	tp = rem(t, 1)
	
	y = 1/2 * t * (tp <= 0.5) + 0.0
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, k1, k2, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k1*x[1] - k2*(x[1]-x[3]) + m1*g)
	dx[3] = x[4]
	dx[4] = 1/m2 * (-c2*x[4] + k2*(x[1]-x[3]) + m2*g + f(t))
end

t = 0:0.01:10
plt_F = plot(t, f.(t), label="f(t)", xticks=0:1:10)

interval = (0.0, 10.0)
p = (20.0, 10.0, 10.0, 10.0, 20.0, 40.0, 9.81)
pocetni = [-1.0, 0.0, -1.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

pos_1 = [u[1] for u in sol.u]
brzina_1 = [u[2] for u in sol.u]

plt_sol = plot(sol.t, [pos_1, brzina_1], label=["pozicija 1" "brzina 1"])

ubrz = diff(brzina_1) ./ diff(sol.t)
plt_ubrz = plot(sol.t[1:end-1], ubrz, label="ubrzanje 1", xlabel="t")

_, index = findmax(abs.(ubrz))
scatter!(plt_ubrz, [sol.t[index]], [ubrz[index]],
		label="max ubrzanje",
		markerstyle=:circle, markersize=3)

plt_final = plot(plt_F, plt_sol, plt_ubrz, layout=(3,1))
display(plt_final)

# Zadatak 3
function f(t)
	tp = rem.(t, 3)

	y = sin(pi/3 * tp)
end

function sistem!(dx, x, p, t)
	m1, m2, m3, c, k, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c*(x[2]-x[4]) - 2*k*x[1] + k*x[3] + m1*g)
	dx[3] = x[4]
	dx[4] = 1/m2 * (c*(x[2]-x[4]) - k*(3*x[3]-x[1]-x[5]) + m2*g)
	dx[5] = x[6]
	dx[6] = 1/m3 * (k*(x[3]-x[5]) + m3*g - f(t))
end

t = 0:0.01:12
plt_F = plot(t, f.(t), label="f(t)", xtick=0:1:12, yticks=0.0:0.25:1.0)

interval = (0.0, 12.0)
p = (5.0, 10.0, 5.0, 10.0, 15.0, 9.81)
pocetni = [0.0 3.0 0.0 3.0 0.0 3.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

pos_1 = [u[1] for u in sol.u]
pos_2 = [u[3] for u in sol.u]

plt_pos = plot(sol.t, [pos_1, pos_2], label=["pozicija 1" "pozicija 2"])

_, index_1 = findmax(abs.(pos_1))
_, index_2 = findmax(abs.(pos_2))

scatter!(plt_pos, 
		[sol.t[index_1], sol.t[index_2]],
		[pos_1[index_1], pos_2[index_2]],
		label="max pozicija",
		markerstyle=:circle, markersize=3)

pocetni[5] = 2.0
prob_new = ODEProblem(sistem!, pocetni, interval, p)
sol_new = solve(prob_new)

pos_2 = [u[3] for u in sol_new.u]
pos_3 = [u[5] for u in sol_new.u]
rastojanje = abs.(pos_2 .- pos_3)

plt_pos_new = plot(sol_new.t, rastojanje,
			label="rastojanje",
			xlabel="t")

plt_final = plot(plt_F, plt_pos, plt_pos_new, layout=(3,1))
display(plt_final)

# Zadatak 4
function f(t)
	tp = rem(t, 3)

	y = min(sin(pi/3 * tp), 1/3 * tp)
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, k1, k2, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k1*(x[1]-x[3]) + f(t))
	dx[3] = x[4]
	dx[4] = 1/m2 * (-c2*x[4] - k2*x[3] + k1*(x[1]-x[3]) - m2*g)
end

t = 0:0.01:18
plt_F = plot(t, f.(t), label="f(t)", xticks=0:1:18, yticks=0:0.25:1)

interval = (0.0, 12.0)
p = (10.0, 8.0, 5.0, 10.0, 15.0, 15.0, 9.81)
pocetni = zeros(4)

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

pos_1 = [u[1] for u in sol.u]
pos_2 = [u[3] for u in sol.u]

plt_pos = plot(sol.t, [pos_1, pos_2], label=["pozicija 1" "pozicija 2"])

brzina_1 = [u[2] for u in sol.u]
ubrz_1 = diff(brzina_1) ./ diff(sol.t)

plt_brz = plot(sol.t, brzina_1, label="brzina 1")
plot!(plt_brz, sol.t[1:end-1], ubrz_1, label="ubrzanje 1", xlabel="t")

_, index_brz = findmax(abs.(brzina_1))
_, index_ubrz = findmax(abs.(ubrz_1))

scatter!(plt_brz, [sol.t[index_brz]], [brzina_1[index_brz]],
		label="max brzina 1", markerstyle=:circle, markersize=3)
scatter!(plt_brz, [sol.t[index_ubrz]], [ubrz_1[index_ubrz]],
		label="max ubrzanje 1", markerstyle=:circle, markersize=3)

plt_final = plot(plt_F, plt_pos, plt_brz, layout=(3,1))
display(plt_final)


