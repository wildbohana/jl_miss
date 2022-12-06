using Statistics, LinearAlgebra

# Složeniji primer 1
# Napisati funkciju primer1 koja kao ulazni parametar sadrži kvadratnu matricu A, a kao izlazne vraća:
# - skalar s koji predstavlja srednju vrednost elemenata u poslednjoj vrsti matrice A.
# - vektor v koji sadrži sve pozitivne elemente sa glavne dijagonale matrice A.
function primer1(A)
	s = mean(A[end, :])
	gd = diag(A)
	v = gd[gd .> 0]

	return s, v
end

# Poziv funkcije
A = round.(20 * randn(10, 10))
sk, vek = primer1(A)


# Složeniji primer 5
# Napisati funkciju primer5 koja određuje srednju vrednost elemenata iznad sporedne dijagonale zadate matrice. Napisati primer poziva funkcije.
function primer5(A)
	M = ones(size(A))
	M = triu(M, 1)

	M_rev = reverse(M, dims = 2)
	M_logicko = convert.(Bool, M_rev)

	el_iznad_sporedne = A[M_logicko]
	sred_vred = mean(el_iznad_sporedne)
end

# Poziv funkcije
K = [1 4 -2 9 6; -1 0 0 3 7; 99 3 -3 4 7; 5 -6 0 -8 3; 1 2 3 4 5]
s_v = primer5(K)


# Zadatak 5
# Napisati funkciju koja za zadatu kvadratnu matricu A, određuje:
# - vektor m koji se formira od elemenata sa glavne dijagonale matrice A.
# - skalar s koji predstavlja srednju vrednost elemenata iznad glavne dijagonale matrice A. (može se koristiti funkcija mean() iz programskog paketa Statistics)


# Zadatak 6
# Napisati funkciju koja za zadate kvadratne matrice A i B istih dimenzija određuje:
# - vektor m koji se sastoji od elemenata ispod glavne dijagonale matrice A koji su pozitivni celi brojevi deljivi sa 3
# - skalar s koji predstavlja srednju vrednost elemenata sa sporedne dijagonale matrice B koji su veći od srednje vrednosti elemenata sa glavne dijagonale matrice A.
