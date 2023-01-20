using ControlSystems;

# Model u prostoru stanja - ss
A = [0 1; 0 -12.5]
B = [0; 38.9]
C = [0 1]
D = 0
m = ss(A, B, C, D)

# Vremenski diskretizovan ss
Ts = 0.025
E = [1 0.02147; 0 0.73160]
F = [0.01098; 0.83520]
C = [0 1]
D = 0
md = ss(E, F, C, D, Ts)

# Funkcija prenosa opisana količnikom polinoma - tf
P = [38.9]
Q = [1.0, 5.0, 6.0]
G = tf(P, Q)

# Eksplicitna definicija promenljive s
s = tf("s")
G = 38.9 / (sˆ2 + 5 * s + 6)

# Funkcija prenosa opisana preko nula, polova i pojačanja - zpk
nule = []
polovi = [-2, -3]
pojacanje = 38.9
G = zpk(nule, polovi, pojacanje)

# Podaci o funkciji prenosa
G = tf([1, 1], [1, 3, 2])
z, p, k = zpkdata(G)

# Multivarijabilni sistem (2 ulaza, 2 izlaza)
W = [tf(1, [2, 3]) tf(1, [1, 0]); tf(10, [3, 1]) tf(1, [1, 2, 3])]

# Konverzije modela
G1 = tf(1, [1, 2, 1])
G2 = zpk(G1)
sys = ss(G1)

# Jedinični odziv u trajanju od 5 sekundi modela opisanog pomoću funkcije prenosa
G = tf(38, [1, 5, 6])
y, t, x = step(G, 5)
plot(t, x', label=["x1(t)" "x2(t)"], lw=2, xlabel="t", ylabel="x(t)")

# Impulsni odziv za isti model
G = tf(38, [1, 5, 6])
y, t, x = impulse(G, 5)
plot(t, y', label="y(t)", lw=2, xlabel="t", ylabel="y(t)")

# Primer sa pobudom definisanom kao složen sistem
function signal(t)
	return abs.(sin.(pi / 3 * t))
end

G = tf(38.9, [1, 5, 6])

t = 0:0.01:12
u = signal(t)
y, t, x = lsim(G, u', t)

plot(t, x', label=["x1(t)" "x2(t)"], lw=2, xlabel="t", xticks=0:12)
plot!(t, u, label="u(t)", lw=2, xticks=0:12)

