function fourier_series = calculate_fourier_series(Num, P, alpha, Nshow)
    x = linspace(0, P, 1000);  
    
    fourier_series = zeros(size(x));

    for n = 1:Num
        term = (2*(-1)^(n+1)*P^(alpha+1))/(n^alpha*pi^(alpha+1)) * sin(n*pi*x/P);
        fourier_series = fourier_series + term;
    end

    plot(x, fourier_series);
    xlabel('x');
    ylabel(['f(x) = x^', num2str(alpha)]);
    title(['Fourier Series for f(x) = x^', num2str(alpha)]);

    if Nshow < Num
        legend(['N = ', num2str(Nshow)], 'Location', 'best');
    else
        legend('Fourier Series', 'Location', 'best');
    end
end


syms x;
f = @(x) x^beta * log(alpha * x);
T = 2 * pi; % Assuming period is 2*pi
num_terms = 10;
[A0, An, Bn] = compute_fourier_series(f, T, num_terms);


% Define the original function
f = @(x) x^2;
T = 2 * pi;
num_terms = 10;
[A0, An, Bn] = compute_fourier_series(f, T, num_terms);

% Define the Fourier series function
f_fourier = @(x) A0/2;
for k = 1:num_terms
    f_fourier = @(x) f_fourier(x) + An(k) * cos(k * x) + Bn(k) * sin(k * x);
end

% Plot the original function and the Fourier series approximation
x_values = linspace(-pi, pi, 1000);
f_values = arrayfun(f, x_values);
f_fourier_values = arrayfun(f_fourier, x_values);

plot(x_values, f_values, 'b', 'LineWidth', 2);
hold on;
plot(x_values, f_fourier_values, 'r--', 'LineWidth', 2);
legend('Original Function', 'Fourier Series Approximation');
xlabel('x');
ylabel('f(x)');
title('Comparison of Original Function and Fourier Series Approximation');
grid on;
hold off;


function harmonics = harmonic_analysis(f, T, num_harmonics, x_points)
    syms x;
    f_sym = f(x);
    A0 = (2/T) * int(f_sym, x, -T/2, T/2);
    A0 = double(A0);
    harmonics = A0/2;
    for k = 1:num_harmonics
        An = (2/T) * int(f_sym * cos(k*x), x, -T/2, T/2);
        An = double(An);
        Bn = (2/T) * int(f_sym * sin(k*x), x, -T/2, T/2);
        Bn = double(Bn);
        harmonics = harmonics + An * cos(k * x_points) + Bn * sin(k * x_points);
    end
end
