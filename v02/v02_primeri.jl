using Plots

# pdf 6
t = 0:0.1:2;
y = 5 * t .* (t .< 1) + (-5 * t .+ 10) .* ((t .>= 1) .& (t .<= 2));

plot(t, y, title="Trougao")
xlabel!("t")
ylabel!("y")

# pdf 8
t = 0:0.1:4;
tp = rem.(t, 2);

y = 5 * tp .* (tp .< 1) + (-5 * tp .+ 10) .* ((tp .>= 1) .& (tp .<= 2));

plot(t, y, title="Periodicni signal 1")
xlabel!("t")
ylabel!("y")

# pdf 10
t = 0:0.1:6;

ys = abs.(sin.(pi/3 * t));
y = min.(ys, 0.75);

scatter(t, ys, markershape=:o, markerstrokecolor=:green, color=:yellow)
plot!(t, y, lw=2, xlabel="t", ylabel="|sin|", color=:blue)

# pdf 11
t = 0:0.1:6;

ys = abs.(sin.(pi/3 * t));
p = 1/6 * t;
y = min.(ys, p);

scatter(t, ys, markershape=:o, markerstrokecolor=:green, color=:yellow, label = "ys")
plot!(t, y, lw=2, xlabel="t", ylabel="|sin|", color=:blue, label = "y")

# pdf 11
t = 0:0.1:6;
tp = rem.(t, 3);

ys = abs.(sin.(pi/3 * t));
p = 1/3 * tp;
y = min.(ys, p);

scatter(t, ys, markershape=:o, markerstrokecolor=:green, color=:yellow, label = "ys")
plot!(t, y, lw=2, xlabel="t", ylabel="|sin|", color=:blue, label = "y")

# pdf 14
t = 0:0.1:4*pi;

y1 = sin.(t);
y2 = cos.(t);
y3 = tan.(t);
y4 = cot.(t);

p1 = plot(t, y1, label="sin(t)", xticks=0:4*pi);
p2 = plot(t, y2, label="cos(t)", xticks=0:4*pi);
p3 = plot(t, y3, label="tg(t)",  xticks=0:4*pi);
p4 = plot(t, y4, label="ctg(t)", xticks=0:4*pi);

plot(p1, p2, p3, p4, layout=(4, 1))


