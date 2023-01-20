# Tehnički, primeri sa rešenjima
using ControlSystems
using Plots

# Zadatak 1
# Odrediti funkciju prenosa sa elektično kolo sa slike
function model_el_kola(R, L, C)
	s = tf("s")

	Zr = R
	Zl = s * L
	Zc = 1 / (s * C)
	Zek = ((Zc + Zr) * Zr) / (Zc + 2 * Zr)
	
	return minreal(Zek / (Zek + Zl))
end

R = 100				# 0.1 kΩ
L = 0.022			# 22 mH
C = 4.7 * 10ˆ-7		# 470 nF

G = model_el_kola(R, L, C)

t = 0:0.01:10
u = abs.(sin.(t))
y_step, t, x = step(G, t)
y_sin, t, x = lsim(G, u', t)

plot(t, y_step', lw=2, xticks=0:10, label="y_step")
plot!(t, y_sin', lw=2, label="y_sin")

# Zadatak 2
# Definisati matematički model u prostoru stanja za električno kolo sa slike
function model_el_kola(R, L, C)
	ssA = [-R/L -1/L; 1/C -1/(R * C)]
	ssB = [1/L -1/L; 0 -1/(R * C)]
	ssC = [0 1/R; 0 1]
	ssD = [0 1/R; 0 1]

	return ss(ssA, ssB, ssC, ssD)
end

R = 1000			# 1 kΩ
L = 0.022			# 22 mH
C = 4.7 * 10ˆ-7		# 470 nF

model = model_el_kola(R, L, C)

t = 0:0.01:10
u = sin.(t)
y, t, x = lsim(model, [u u]', t)

p1 = plot(t, y[1, :], lw=2, label="i1(t)", xlabel="t")
p2 = plot(t, y[2, :], lw=2, label="u0(t)", xlabel="t")

plot(p1, p2, layout=(2, 1))
