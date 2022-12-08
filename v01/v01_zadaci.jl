using Statistics, LinearAlgebra

# Složeniji primer 1
# Napisati funkciju primer1 koja kao ulazni parametar sadrži kvadratnu matricu A, a kao izlazne vraća:
# - skalar s koji predstavlja srednju vrednost elemenata u poslednjoj vrsti matrice A.
# - vektor v koji sadrži sve pozitivne elemente sa glavne dijagonale matrice A.
function primer1(A)
	# skalar s
	s = mean(A[end, :])

	# vektor v
	gd = diag(A)
	v = gd[gd .> 0]

	return s, v
end

# Poziv funkcije
A = round.(20 * randn(5, 5))
sk, vek = primer1(A)



# Složeniji primer 5
# Napisati funkciju primer5 koja određuje srednju vrednost elemenata iznad sporedne dijagonale zadate matrice. Napisati primer poziva funkcije.
function primer5(A)
	maska = ones(size(A))
	maska = triu(M, 1)
	maska_rev = reverse(M, dims = 2)
	maska_logicko = convert.(Bool, maska_rev)
	el_iznad_sporedne = A[maska_logicko]
	sred_vred = mean(el_iznad_sporedne)
end

# Poziv funkcije
K = [1 4 -2 9 6; -1 0 0 3 7; 99 3 -3 4 7; 5 -6 0 -8 3; 1 2 3 4 5]
s_v = primer5(K)



# Zadatak 5
# Napisati funkciju koja za zadatu kvadratnu matricu A, određuje:
# - vektor m koji se formira od elemenata sa glavne dijagonale matrice A.
# - skalar s koji predstavlja srednju vrednost elemenata iznad glavne dijagonale matrice A. (može se koristiti funkcija mean() iz programskog paketa Statistics)
function zadatak5(A)
	# vektor m
	m = diag(A)

	# skalar s
	maska = ones(size(A))
	maska = triu(maska, 1)
	maska_logicki = convert.(Bool, maska)
	el_iznad_gd = A[maska_logicki]
	s = mean(el_iznad_gd)

	return m, s
end

# Poziv funkcije
vektor, skalar = zadatak5(K)



# Zadatak 6
# Napisati funkciju koja za zadate kvadratne matrice A i B istih dimenzija određuje:
# - vektor m koji se sastoji od elemenata ispod glavne dijagonale matrice A koji su pozitivni celi brojevi deljivi sa 3
# - skalar s koji predstavlja srednju vrednost elemenata sa sporedne dijagonale matrice B koji su veći od srednje vrednosti elemenata sa glavne dijagonale matrice A.
function zadatak6(A, B)
	# vektor m
	maska_m = ones(size(A))
	maska_m = tril(maska_m, -1)
	maska_m_logicki = convert.(Bool, maska_m)
	el_ispod_gd = A[maska_m_logicki]
	m = el_ispod_gd[rem.(el_ispod_gd, 3) .== 0]

	# skalar s 
	gl_dijag_a = diag(A)
	sr_vr = mean(gl_dijag_a)
	b_rev = reverse(B, dims = 2)
	spor_dijag_b = diag(b_rev)
	spor_dijag_veci = spor_dijag_b[spor_dijag_b .> sr_vr]
	s = mean(spor_dijag_veci)

	return m, s
end

# Poziv funkcije
ve, sk = zadatak6(A, K)

