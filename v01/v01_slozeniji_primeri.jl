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

# Složeniji primer 2
# Napisati funkciju koja određuje maksimalni element matrice A i njegovu poziciju (vrstu i kolonu) u matrici A, bez upotrebe ugrađenih funkcija.
function maksimalni(A)
	n, m = size(A)
	max_el = A[1,1]
	vrsta = 1;
	kolona = 1;

	for i = 1:n
		for j = 1:m
			if A[i, j] > max_el
				max_el = A[i, j];
				vrsta = i;
				kolona = j;
			end
		end
	end

	return max_el, vrsta, kolona
end

# Poziv funkcije
A = round.(20 * randn(5, 5))
max_el, vrsta, kolona = maksimalni(A)

# Složeniji primer 3
# Napisati funkciju koja određuje kumulativnu sumu vektora. 
function cum_sum(v)
	ret_val = zeros(Int64, length(v))
	ret_val[1] = v[1]

	for i = 2:length(v)
		ret_val[i] = sum(v[1:i])
	end

	return (ret_val)
end

# Poziv funkcije
v = [1, 2, 3, 4, 5]
c = cum_sum(v)

# Složeniji primer 4
# Data je tabela T koja sadrži podatke o osobama. Napisati kod koji:
# - određuje osobu sa najvećom težinom (ili osobe ako ih je više). Ispisati poruku na terminal koja prikazuje imena osobe(a) i maksimalnu težinu.
# - određuje prosečnu visinu i težinu.
T = ["Ime" "Pol" "Starost" "Tezina" "Visina";
	"Ana" "z" 20 46 160;
	"Bojan" "m" 24 52 165;
	"Vlada" "m" 24 95 195;
	"Gordana" "z" 30 57 160;
	"Dejan" "m" 36 84 185;
	"Zoran" "m" 22 80 180]

# osoba sa najvecom tezinom i njena tezina (paziti ukoliko ima vise osoba sa istom tezinom. U tom slucaju prikazati sve osobe)
podaci = T[2:end, 3:end]

maks_tezina = maximum(podaci[:, 2])
poz = findall(podaci[:, 2] .== maks_tezina)
if length(poz) == 1
	ime = T[poz .+ 1, 1][1]
	println("Osoba sa najvecom tezinom je ", ime, " (", maks_tezina, "kg)")
else
	imena = T[poz .+ 1, 1]
	println("Osobe sa tezinom ", maks_tezina, "kg su: ")
	[println(ime) for ime in imena]
end

# prosecna visina i tezina
prosecna_visina = mean(podaci[:, end])
prosecna_tezina = mean(podaci[:, end-1])

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


