function plot_fourier_series_comparison()
    T = 2 * pi;
    f = @(x) x.^2;
    num_terms = 100;
    x_val = pi;

    [A0, An, Bn] = compute_fourier_series(f, T, num_terms);
    
    syms x;
    fourier_series = A0 / 2;
    for k = 1:num_terms
        fourier_series = fourier_series + An(k) * cos(2 * pi * k * x / T) + Bn(k) * sin(2 * pi * k * x / T);
    end

    f_series = matlabFunction(fourier_series);
    y_val_series = f_series(x_val);
    y_val_series = y_val_series/6

    manual_series = (pi^2 / 3 + 4 * sum(((-1).^(1:num_terms)) ./ (1:num_terms).^2 .* cos((1:num_terms) * x_val)))/6;
    
    fprintf('Computed Fourier Series Value at x = %f: %f\n', x_val, y_val_series);
    fprintf('Manual Fourier Series Value at x = %f: %f\n', x_val, manual_series);
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

plot_fourier_series_comparison();
