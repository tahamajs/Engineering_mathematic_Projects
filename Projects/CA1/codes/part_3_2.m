function plot_fourier_series_comparison()
    T = 2 * pi;
    f = @(x) x.^2;
    num_terms_list = [10, 50, 100];
    colors = ['r', 'g', 'b'];
    x_vals = linspace(-pi, pi, 1000);
    y_vals_original = f(x_vals);

    for i = 1:length(num_terms_list)
        num_terms = num_terms_list(i);
        [A0, An, Bn] = compute_fourier_series(f, T, num_terms);
        
        syms x;
        fourier_series = A0 / 2;
        for k = 1:num_terms
            fourier_series = fourier_series + An(k) * cos(2 * pi * k * x / T) + Bn(k) * sin(2 * pi * k * x / T);
        end

        f_series = matlabFunction(fourier_series);
        y_vals_series = f_series(x_vals);
        
        figure;
        plot(x_vals, y_vals_original, 'k', 'LineWidth', 1.5);
        hold on;
        plot(x_vals, y_vals_series, '--', 'LineWidth', 1.5, 'Color', colors(i));
        xlabel('x');
        ylabel('f(x)');
        title(['Fourier Series Approximation with ', num2str(num_terms), ' Terms']);
        legend('Original Function', ['Fourier Series (', num2str(num_terms), ' terms)']);
        grid on;
        hold off;
    end
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
