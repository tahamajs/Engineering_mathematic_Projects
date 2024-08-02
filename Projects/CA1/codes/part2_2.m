function plot_fourier_series()
    alpha = 1; 
    beta = 2;  
    T = 2 * pi; 
    num_terms = 10; 
    Nshow = 5; 

    f = @(x) x.^beta .* log(alpha .* x);

    [A0, An, Bn] = compute_fourier_series(f, T, num_terms);

    fprintf('A0 = %.4f\n', A0);
    fprintf('An coefficients:\n');
    disp(An(1:Nshow));
    fprintf('Bn coefficients:\n');
    disp(Bn(1:Nshow));

    syms x;
    fourier_series = A0 / 2;
    for k = 1:num_terms
        fourier_series = fourier_series + An(k) * cos(2 * pi * k * x / T) + Bn(k) * sin(2 * pi * k * x / T);
    end

    f_series = matlabFunction(fourier_series);

    x_vals = linspace(-pi, pi, 1000);
    y_vals_original = f(x_vals);
    y_vals_series = f_series(x_vals);

    figure;
    plot(x_vals, y_vals_original, 'r', 'LineWidth', 1.5);
    hold on;
    plot(x_vals, y_vals_series, 'b--', 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    title('Original Function and Fourier Series Approximation');
    legend('Original Function', 'Fourier Series Approximation');
    grid on;
    hold off;
end

function [A0, An, Bn] = compute_fourier_series(f, T, num_terms)
    syms x;
    f_sym = f(x);
    A0 = (2/T) * int(f_sym, x, -T/2, T/2);
    A0 = double(A0);
    An = zeros(1, num_terms);
    Bn = zeros(1, num_terms);
    for k = 1:num_terms
        An(k) = (2/T) * int(f_sym * cos(2 * pi * k * x / T), x, -T/2, T/2);
        An(k) = double(An(k));
        Bn(k) = (2/T) * int(f_sym * sin(2 * pi * k * x / T), x, -T/2, T/2);
        Bn(k) = double(Bn(k));
    end
end

plot_fourier_series();
