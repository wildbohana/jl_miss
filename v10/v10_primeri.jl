using ControlSystems

# Redna veza
G1 = tf(1, [1, 1]);
G2 = tf(1, [1, 2]);
Gek = series(G1, G2)

# Paralelna veza
G1 = tf(1, [1, 1]);
G2 = tf(1, [1, 2]);
Gek = parallel(G1, G2)

# Povratna (negativna) sprega
G = tf(1, [1, 1]);
H = tf(1, [1, 2]);
Gek = feedback(G, H)

# Povratna (pozitivna) sprega
G = tf(1, [1, 1]);
H = tf(1, [1, 2]);
Gek = feedback(G, -H)
