using Statistics, LinearAlgebra

# Zadatak sa vežbi
# Napisati funkciju koja kao ulazne parametre prima kvadratnu matricu A i skalar x, a kao povratne vrednosti vraća:
# - skalar c, koji predstavlja sumu svih elemenata koji se nalaze na preseku neparnih vrsta i parnih kolona matrice A i deljivi su sa ulaznim parametrom x
# - skalar p, koji govori koliko elemenata sa glavne dijagonale matrice A ima vrednost manju od najvećeg elementa iznad glavne dijagonale
# - poziciju (redni broj) kolone u matrici A u kojoj se element čija je vrednost jednaka ulaznom parametru x pojavljuje najviše puta
function primer(A, x)
	# skalar c
	presek = A[1:2:end, 2:2:end]
	el_deljivi_sa_x = presek[rem.(presek, x) .== 0]
	c = sum(el_deljivi_sa_x)

	# skalar p
	dijagonala = diag(A)
	jedinice = ones(size(A))
	maska = triu(jedinice, 1)
	maska_2 = convert.(Bool, maska)
	el_iznad_gd = A[maska_2]
	najveci_iznad_gd = maximum(el_iznad_gd)
	elementi_manji_od_najveceg = dijagonala[dijagonala .< najveci_iznad_gd]
	p = length(elementi_manji_od_najveceg)

	# pozicija
	maska_x = A .== x
	zbir_po_kolonama = sum(maska_x, dims = 1)
	pozicija = findmax(zbir_po_kolonama)

	return c, p, pozicija
end

# Poziv funkcije
broj = 4
A = [1 4 -2 9 6; -1 0 0 3 7; 99 3 -3 4 7; 5 -6 0 -8 3; 1 2 3 4 5]
a, b, c = primer(A, broj)



# Zadatak sa konsultacija
# Napisati funkciju koja kao ulazni parametar prima kvadratnu matricu A i skalar s, a kao povratne vrednosti vraća:
# - skalar s, koji predstavlja srednju vrednost svih pozitivnih elemenata matrice A koji su deljivi sa skalarom s
# - vektor p, koji se sastoji od elemenata sa glavne dijagonale matrice A koji su veću od zbira svih elemenata iz neparnih vrsta te matrice
function zadatak1(A, s)
	pozitivni = A[A .> 0]
	deljivi = pozitivni[rem.(pozitivni, s) .== 0]
	c = mean(dejlivi)

	suma = sum(A[1:2:end, :])
	dijagonala = diag(A)
	p = dijagonala[dijagonala .> suma]

	return c, p
end

# Poziv funkcije
B = [3 1 4 9 6; -1 4623 23 3 7; 99 3 -3 4 7; 5 -6 0 -8 3; 1 2 3 4 5]
broj = 4
skalar, vektor = zadatak1(B, broj)

