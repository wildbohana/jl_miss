using ControlSystems

# Primer 1
G1 = tf(1, [1, 1]);
G2 = tf(1, [1, 2]);
G3 = tf(1, [1, 3]);
H = tf(1, [1, 0]);

G12 = parallel(G1, G2);
G123 = series(G12, G3);
G = feedback(G123, H);

# Primer 2
G1 = tf(1, [1, 1]);
G2 = tf(1, [1, 2]);
G3 = tf(1, [1, 3]);
G4 = tf(1, [1, 4]);

G23 = minreal(series(G2, G3));
G234 = minreal(feedback(G23, G4));
G1234 = minreal(series(G1, G234));
G = minreal(feedback(G1234, 1));

# Primer 3
G1 = tf(1, [1, 1]);
G2 = tf(1, [1, 2]);
G3 = tf(1, [1, 3]);
G4 = tf(1, [1, 4]);

G12 = minreal(feedback(G1, -G2));
G56 = minreal(parallel(G5, G6));
G123 = minreal(series(G12, G3));
G12356 = minreal(feedback(G123, G56));
G123456 = minreal(series(G12356), G4);
G = minreal(feedback(G123456, -1));

# Primer 4
# NEMA KOD

# Multivarijabilni - primer 1
function sistem()
	G1 = tf(10, [1, 10])
	G2 = tf([5, 2], [1, 2, 1, 0])
	G3 = tf(5)
	G4 = tf([1, 0.1], [1, 0.05])
	
	# W11 -> U1, Y
	G34 = minreal(series(G3, G4))
	G234 = minreal(feedback(G2, G34))
	W11 = minreal(parallel(-G1, G234))
	
	# W12 -> U2, Y
	G24 = minreal(series(-G2, G4))
	W12 = minreal(feedback(G24, -G3))
	
	return W11, W12
end

t = 0:0.01:5
u1 = sin.(t)
u2 = cos.(t)

W11, W12 = sistem()

y1, ~, ~ = lsim(W11, u1', t)
y2, ~, ~ = lsim(W12, u2', t)

y = y1 .+ y2
plot(t, [y', u1, u2], label=["y(t)" "u1(t)" "u2(t)"], xlabel="t", lw=2)

# Multivarijabilni - primer 2
function sistem(k1, k2)
	G1 = tf(2, [0.2, 1])
	G2 = tf([1.2, 1], [1, 2, 0.1])
	G3 = tf(4, [1, 3, 2])
	G4 = tf(1, [0.1, 1])
	K1 = tf(k1)
	K2 = tf(k2)

	# W11 -> U1, Y
	G12 = minreal(series(G1, G2))
	G32 = minreal(feedback(G3, K2))
	G324 = minreal(series(G32, G4))
	G3241 = minreal(series(K1, -G324))
	Gp = minreal(parallel(tf(1), -G3241))
	W11 = minreal(series(G12, Gp))

	# W12 -> U2, Y
	G32 = minreal(feedback(G3, K2))
	W12 = minreal(series(G32, -G4))

	return W11, W12
end

function simulacija(k1_vals, k2_vals, u1, u2, t)
	y_vals = []

	for k1 in k1_vals
		for k2 in k2_vals
			W11, W12 = sistem(k1, k2)
			
			y1, ~, ~ = lsim(W11, u1', t)
			y2, ~, ~ = lsim(W12, u2', t)
			y = y1 .+ y2
			
			push!(y_vals, y')
		end
	end

	return y_vals
end

t = 0:0.01:10
u1 = sin.(t)
u2 = cos.(t)

k1 = [0.1, 0.3, 0.7]
k2 = [0.2, 0.5]

y = simulacija(k1, k2, u1, u2, t)
plot(t, y, lw=2, xticks=0:2:10, xlabel="t")

