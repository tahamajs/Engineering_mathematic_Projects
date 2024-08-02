x = linspace(0, 32,1000)
plot(x, sin(pi*x/4).*cos(pi*x/8))
grid on
xlim([0,32])