# Matrica A
A = [1 4 -2 9 6; -1 0 0 3 7; 99 3 -3 4 7; 5 -6 0 -8 3; 1 2 3 4 5]

# Primer 1
# Iz zadate matrice A selektovati element 99 upotrebom jednodimenzionog indeksiranja. Rezultat smestiti u promenljivu p.
p = A[3]

# Primer 2
# Iz zadate matrice A selektovati element 99 upotrebom dvodimenzionog indeksiranja. Rezultat smestiti u promenljivu p.
p = A[3, 1]

# Primer 3
# Iz zadate matrice A selektovati element 99 upotrebom logičkog indeksiranja. Rezultat smestiti u promenljivu p.
M = [0 0 0 0 0;
	0 0 0 0 0;
	1 0 0 0 0;
	0 0 0 0 0;
	0 0 0 0 0]
M_logical = convert.(Bool, M)
p = A[M_logical]

# Primer 4
# Iz zadate matrice A selektovati prvu vrstu.
vrsta = A[1, :]

# Primer 5
# Iz zadate matrice A selektovati poslednju kolonu.
kolona = A[:, end]

# Primer 6
# Iz zadate matrice A selektovati sve neparne vrste.
nep_vrste = A[1:2:end, :]

# Primer 7
# Iz zadate matrice A selektovati sve pozitivne elemente.2
pozitivni = A[A .> 0]

# Primer 8
# Iz zadate matrice A selektovati sve elemente koji se nalaze na opsegu [-5, 5)
el_opseg = A[(A .>= -5) .& (A .< 5)]

# Primer 9
# Odrediti maksimalni element matrice A.
max_el = maximum(A)

# Primer 10
# Iz zadate matrice A izdvojiti sporednu dijagonalu.
using LinearAlgebra 	# za funkciju diag()

A_rev = reverse(A, dims = 2)
sd = diag(A_rev)

# Primer 11
# Iz zadate matrice A izdvojiti sve parne elemente.
parni = A[rem.(A, 2) .== 0]

# Primer 12
# U zadatoj matrici A pronaći vrstu sa maksimalnom sumom. Uzeti u obzir situaciju da više vrsta ima istu sumu i da je ona maksimalna.
suma_svake_vrste = sum(A, dims = 2)
max_el = maximum(suma_svake_vrste)
vrste = findall(suma_svake_vrste .== max_el)

