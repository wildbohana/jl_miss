using Plots, DifferentialEquations

# Zadatak 1
function f(t)
	tp = rem(t, 8)

	y = min(sin(pi/4 * tp), 0.5) * (tp <= 4)
end

function sistem!(dx, x, p, t)
	m1, m2, c, k1, k2, R = p
	J = 1/2 * m1 * R^2

	dx[1] = x[2]
	dx[2] = 1/J * (-c*R*x[2] - k2*(x[3]+R*x[1])*R - k1*x[1])
	dx[3] = x[4]
	dx[4] = 1/m2 * (-k2*(x[3]+R*x[1]) + f(t))
end

t = 0:0.01:20
plt_F = plot(t, f.(t), ylims=(0, 1.0), label="f(t)", xticks=0:2:20, yticks=0:0.25:1, lw=2)

interval = (0.0, 20.0)
p = [10.0, 5.0, 10.0, 10.0, 15.0, 1.0]
pocetni = [0.0, 2.0, 0.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

ugao_brz = [u[2] for u in sol.u]
ugao_ubrz = diff(ugao_brz) ./ diff(sol.t)
plt_ugao = plot(sol.t, ugao_brz, label="ugaona brzina")
plot!(plt_ugao, sol.t[1:end-1], ugao_ubrz, label="ugaono ubrzanje")

pos_2 = [u[3] for u in sol.u]
brzina_2 = [u[4] for u in sol.u]
plot_2 = plot(sol.t, [pos_2, brzina_2], label=["pozicija 2" "brzina 2"], xlabel="t")

plt_final = plot(plt_F, plt_ugao, plot_2, layout=(3,1))
display(plt_final)


# Zadatak 2
function trougao(t)
	tp = rem(t, 2)
	y = 2*tp * (tp <= 1) +
		(-2*tp+4) * (tp > 1)
end

function kruznica(t)
	tp = rem(t, 2)
	y = sqrt(1 - (tp-1)^2) 
end
	
f(t) = min(kruznica(t), trougao(t))

function sistem!(dx, x, p, t)
	m, c1, c2, k1, k2, R, L1, L2 = p
	J = 1/2 * m * R^2

	dx[1] = x[2]
	dx[2] = 1/J * (-c1*R^2*x[2] - k1*x[1] - k2*R^2*x[1] - k2*R*L1*x[3])
	dx[3] = 1/(c2*L2^2) * (-k2*R*L1*x[1] - k2*L1^2*x[3] + L1*f(t))
end

t=0:0.01:10
plt_F = plot(t, trougao.(t), 
		label="trougao", xticks=0:10,
		xlabel="t", ylabel="y",
		linestyle=:dash, color=:green)
plot!(plt_F, t, kruznica.(t), 
		label="kruznica", linestyle=:dash, color=:red)
plot!(plt_F, t, f.(t), label="y", lw=2, color=:blue)

interval = (0.0, 100.0)
p = (10.0, 10.0, 8.0, 10.0, 15.0, 1.0, 1.0, 2.0)
pocetni = zeros(3)

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

ugao_1 = [u[1] for u in sol.u]
ugao_2 = [u[3] for u in sol.u]
plt_ugao = plot(sol.t, [ugao_1, ugao_2], label=["ugaona pozicija 1" "ugaona pozicija 2"])

ugao_brz_1 = [u[2] for u in sol.u]
ugao_ubrz_1 = diff(ugao_brz_1) ./ diff(sol.t)

_, index = findmax(abs.(ugao_ubrz_1))

plt_ugao_ubrz = plot(sol.t[1:end-1], ugao_ubrz_1, label="ugaono ubrzanje", xlabel="t")
scatter!(plt_ugao_ubrz, [sol.t[index]], [ugao_ubrz_1[index]], label="max ubrzanje", markerstyle=:circle, markersize=3)

plt_final = plot(plt_F, plt_ugao, plt_ugao_ubrz, layout=(3,1))
display(plt_final)


