using Plots

# Zadatak 1
# Napisati kod koji generiše periodični signal prikazan na slici 16.
t = 0:0.01:10
tp = rem.(t, 5)

y1 = (2 * tp) .* ((tp .>= 0) .& (tp .< 2))
y2 = (2) .* ((tp .>= 2) .& (tp .< 4))
y3 = (10 .- 2 * tp) .* ((tp .>= 4) .& (tp .<= 5))
y = y1 + y2 + y3

plot(t, y)

# Zadatak 2
# Napisati kod koji generiše periodični signal prikazan na slici 17.

t = 0:0.01:2*pi
tp = rem.(t, pi/3)

y0 = sin.(t)
y = y0 .* (tp .< pi/6)

plt = plot(t, y0, 
	xlabel="t", ylabel="y", 
	label="sin(t)", 
	linestyle=:dash, color=:red)

plot!(plt, t, y, 
	label="y(t)", 
	xtick=0:pi:2*pi, color=:blue)

# Zadatak 3
# Napisati kod koji generiše periodični signal prikazan na slici 18.
t = 0:0.01:10
tp = rem.(t, 2)

p = 4/10 * t
y1 = 4 * (tp .<= 1)
y = min.(p, y1) .* (tp .<= 1)

plt = plot(t, y1, 
	xticks=0:10, 
	linestyle=:dash, color=:red)

plot!(plt, t, y, 
	label="y",	color=:blue)

# Zadatak 4
# Napisati kod koji generiše periodični signal prikazan na slici 19.
t = 0:0.5:9

s = 2 * sin.(pi/3 * t)
y = min.(s, 1) .* (s .> 0) .+ 
    max.(s, -1) .* (s .<= 0)

plt = scatter(t, s, 
	label="sin", 
	xlabel="t", ylabel="y", 
	xticks=0:9)
	
plot!(plt, t, y, label="y", color=:red)

# Zadatak 5
# Napisati kod koji generiše signal prikazan na slici 20.
t = -3:0.1:3
y1 = x^2 - 1
y2 = -x^2 + 1

plt = plot(t, y1, xlabel="t", ylabel="y", label="x^2-1")
plot!(plt, t, y2, label="-x^2+1")

# Zadatak 6
# Napisati kod koji generiše periodični signal prikazan na slici 21.
t = 0:0.01:15
tp = rem.(t, 3)

y = 3*tp .* (tp .< 1) .+ 
    3 .* ((tp .>= 1) .& (tp .< 2)) .+ 
    (-3*tp .+ 9) .* ((tp .>= 2) .& (tp .< 3))

plot(t, y, 
	xlabel="t", ylabel="y", 
	xticks=0:15, label="y1")

# Zadatak 7
# Napisati kod koji generiše signal prikazan na slici 22.
t = 0:0.01:2
y = sqrt(1-(x-1)^2)

plot(t, y, 
	label="kruznica", 
	xlabel="t", ylabel="y", 
	xticks=0:2, yticks=0:1)

# Zadatak 8
# Napisati kod koji generiše periodični signal prikazan na slici 23.
t = 0:0.01:4

function trougao(t)
	tp = rem(t, 2)
	y = 2*tp * (tp < 1) + (-2*tp+4) * ((tp >= 1) & (tp < 2))
end

function kruznica(t)
	tp = rem(t, 2)
	y = sqrt(1 - (tp-1) ^ 2)
end

tr = trougao.(t)
kr = kruznica.(t)
y = min.(tr, kr)

plt = plot(t, tr,
	xlabel="t",
	ylabel="y",
	xlims=(0,4),
	ylims=(0,2),
	label="trougao",
	linestyle=:dash, color=:red)

plot!(plt, t, kr,
	label="kruznica",
	linestyle=:dash, color=:blue)

plot!(plt, t, y,
	label="y",
	linewidth=2,
	color=:green)

