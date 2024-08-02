function [A0, An, Bn] = compute_fourier_series(f, T, num_terms)
    syms x;
    f_sym = f(x);
    A0 = (2/T) * int(f_sym, x, -T/2, T/2);
    A0 = double(A0);
    An = zeros(1, num_terms);
    Bn = zeros(1, num_terms);
    for k = 1:num_terms
        An(k) = (2/T) * int(f_sym * cos(k*x), x, -T/2, T/2);
        An(k) = double(An(k));
        Bn(k) = (2/T) * int(f_sym * sin(k*x), x, -T/2, T/2);
        Bn(k) = double(Bn(k));
    end
end


f = @(x) x;

T = 2 * pi;
num_terms = 10;

[A0, An, Bn] = compute_fourier_series(f, T, num_terms);

f_fourier = @(x) A0/2;
for k = 1:num_terms
    f_fourier = @(x) f_fourier(x) + An(k) * cos(k * x) + Bn(k) * sin(k * x);
end

x_values = linspace(-pi, pi, 1000);
f_values = arrayfun(f, x_values);
f_fourier_values = arrayfun(f_fourier, x_values);

figure;
plot(x_values, f_values, 'b', 'LineWidth', 2);
hold on;
plot(x_values, f_fourier_values, 'r--', 'LineWidth', 2);
legend('Original Function', 'Fourier Series Approximation');
xlabel('x');
ylabel('f(x)');
title('Comparison of Original Function and Fourier Series Approximation');
grid on;
hold off;