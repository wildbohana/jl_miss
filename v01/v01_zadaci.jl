using Statistics, LinearAlgebra

# Matrice A i B
A = [1 4 -2 9 6; -1 2 1 3 7; 9 3 -3 4 7; 5 -6 12 -8 3; 1 2 3 4 5]
B = round.(20 * randn(5, 5))
v = [1, 2, 3, 2, 1, 2, 5, 7, 8, 2, 5, 4]

# Zadatak 1
# Za proizvoljnu kvadratnu matricu A, izdvojiti sve parne kolone.
parne_kolone = A[:, 2:2:end]
println("Parne kolone matrice A: ")
println(parne_kolone)
println()

# Zadatak 2
# Za proizvoljnu kvadratnu matricu A, izdvojiti sve elemente koji su deljivi sa 9.
deljivi = A[rem.(A, 9) .== 0]
println("Brojevi deljivi sa 9: ")
println(deljivi)
println()

# Zadatak 3
# Za proizvoljnu kvadratnu matricu A, izdvojiti elemente koji se nalaze na preseku parnih vrsta i parnih kolona.
presek_parnih_vr_i_kol = A[2:2:end, 2:2:end]
println("Presek parnih vrsta i kolona: ")
println(presek_parnih_vr_i_kol)
println()

# Zadatak 4 
# Napisati funkciju koja određuje zbir svih elemenata matrice A (neke sume) gde je m broj vrsta, a n broj kolona, 
# koji imaju osobinu da je zbir indeksa (i + j) paran broj (A11 + A13 + ...)
function zbir_mn(matrica)
	zbir = 0
	m, n = size(matrica)

	for i in 1:m
		for j in 1:n
			if (i + j) % 2 == 0
				zbir += matrica[i, j]
			end
		end
	end

	return zbir
end

# Primer poziva funkcije
println("Zbir A11 + A13 + ... je: ")
println(zbir_mn(A))
println()

# Zadatak 5
#= 
Napisati funkciju koja za zadatu kvadratnu matricu A, određuje:
 - vektor m koji se formira od elemenata sa glavne dijagonale matrice A.
 - skalar s koji predstavlja srednju vrednost elemenata iznad glavne dijagonale matrice A. 
   (može se koristiti funkcija mean() iz programskog paketa Statistics)
=#
function zadatak5(A)
	m = diag(A)

	maska = ones(size(A))
	maska = triu(maska, 1)
	maska_logicki = convert.(Bool, maska)
	el_iznad_gd = A[maska_logicki]
	s = mean(el_iznad_gd)

	return m, s
end

# Primer poziva funkcije
a, b = zadatak5(A)
println("Zadatak 5:")
println(a)
println(b)
println()

# Zadatak 6
#= 
Napisati funkciju koja za zadate kvadratne matrice A i B istih dimenzija određuje:
 - vektor m koji se sastoji od elemenata ispod glavne dijagonale matrice A koji su pozitivni celi brojevi deljivi sa 3
 - skalar s koji predstavlja srednju vrednost elemenata sa sporedne dijagonale matrice B 
   koji su veći od srednje vrednosti elemenata sa glavne dijagonale matrice A.
=#
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

# Primer poziva funkcije
vektor, skalar = zadatak6(A, B)
println("Zadatak 6")
println(vektor)
println(skalar)
println()

# Zadatak 7
#= 
Za podatke iz tabele T (Primer 4 - Složeni primeri) napisati kod koji određuje:
 - koliko je ženskih, a koliko muških osoba (poželjno je prikazati i njihova imena),
 - prosečnu visinu i težinu ženskih osoba,
 - prosečnu visinu i težinu muških osoba,
 - najstariju i najmlađu osobu,
 - standardnu devijaciju za visinu.
=#
T = ["Ime" "Pol" "Starost" "Tezina" "Visina";
	"Ana" 		"z" 20 46 160;
	"Bojan" 	"m" 24 52 165;
	"Vlada" 	"m" 24 95 195;
	"Gordana" 	"z" 30 57 160;
	"Dejan" 	"m" 36 84 185;
	"Zoran" 	"m" 22 80 180]

T = T[2:end, :]

# broj muskih i zenskih
broj_m = findall(T[:, 2] .== "m")
broj_z = findall(T[:, 2] .== "z")
muskih = T[broj_m, 1]
zenskih = T[broj_z, 1]

println("Muske osobe: ", muskih)
println("Broj muskih osoba: " , size(muskih, 1) , "\n")
println("Zenske osobe: ", zenskih)
println("Broj zenskih osoba: " , size(zenskih, 1) , "\n")

# prosecne tezine i visine
avg_tezina_m = mean(T[broj_m, 4])
avg_visina_m = mean(T[broj_m, 5])
avg_tezina_z = mean(T[broj_z, 4])
avg_visina_z = mean(T[broj_z, 5])

ispis = ["Pol" "Tezina" "Visina"]
ispis = [ispis; ["M" avg_tezina_m avg_visina_m]]
ispis = [ispis; ["Z" avg_tezina_z avg_visina_z]]

#display(ispis)

# najstarija i najmladja osoba
najstariji = maximum(T[:, 3])
najmladji = minimum(T[:, 3])

ind_najstariji = findall(T[:, 3] .== najstariji)
ind_najmladji = findall(T[:, 3] .== najmladji)

println("Najstarije osobe su: ", T[ind_najstariji, 1])
println("Najmladje osobe su: ", T[ind_najmladji, 1])

# standardna devijacija
visine = T[:, 5]
m = mean(visine)
N = size(T, 2)
((visine .- m) .^ 2) ./ N
sigma = sqrt(sum(visine))

println("Standardna divijacija: ", sigma)
println()

# Zadatak 8
# Napisati funkciju koja određuje poziciju nenultih elemenata proizvoljne matrice. 
# Zadatak rešiti bez korišćenja funkcije findall.
function nadjisve(matrica)
	ind = []

	for i in 1:size(matrica, 1)
		for j in 1:size(matrica, 2)
			if matrica[i, j] != 0
				push!(ind, (i, j))
			end
		end
	end

	return ind
end

# Primer poziva funkcije
ind = nadjisve(A)
println("Pozicije nenultih elemenata matrice: ")
println(ind)
println()

# Zadatak 9
# Napisati funkciju, po uzoru na funkciju prod, koja određuje proizvod svih elemenata vektora.
function pomnozi(vec)
	p = 1

	for elem in vec
		p *= elem
	end

	return p
end

# Primer poziva funkcije
println("Proizvod elemenata iz vektora: ")
println(pomnozi(v))
println()

# Zadatak 10
# Napisati funkciju, po uzoru na funkciju sum, koja određuje sumu elemenata proizvoljne matrice. 
# Implementirati opcioni ili imenovani parametar funkcije na osnovu koga će se računati suma elemenata po vrstama ili po kolonama matrice.
function saberi(matrica)
	suma = 0

	for i in 1:size(matrica, 1)
		for j in 1:size(matrica, 2)
			suma += matrica[i, j]
		end
	end

	return suma
end

# Primer poziva funkcije
println("Zbir elemenata iz matrice: ")
println(saberi(A))
println()

