function harmonic_analysis(x, f_values, num_harmonics)
    T = 2 * pi; 
    n = length(x); 
    A0 = (2 / n) * sum(f_values);
    
    An = zeros(1, num_harmonics);
    Bn = zeros(1, num_harmonics);
    
    for k = 1:num_harmonics
        cos_kx = cos(k * x);
        sin_kx = sin(k * x);
        
        An(k) = (2 / n) * sum(f_values .* cos_kx);
        Bn(k) = (2 / n) * sum(f_values .* sin_kx);
    end
    
    syms x_sym;
    fourier_series = A0 / 2;
    for k = 1:num_harmonics
        fourier_series = fourier_series + An(k) * cos(k * x_sym) + Bn(k) * sin(k * x_sym);
    end
    
    disp(['f(x) = ' num2str(A0 / 2)]);
    for k = 1:num_harmonics
        if An(k) ~= 0
            disp([' + ' num2str(An(k)) ' cos(' num2str(k) 'x)']);
        end
        if Bn(k) ~= 0
            disp([' + ' num2str(Bn(k)) ' sin(' num2str(k) 'x)']);
        end
    end
    
    f_series = matlabFunction(fourier_series);
    x_vals = linspace(min(x), max(x), 1000);
    y_vals_series = f_series(x_vals);
    
    figure;
    plot(x, f_values, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    hold on;
    plot(x_vals, y_vals_series, 'b', 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    title(['Fourier Series Approximation with ', num2str(num_harmonics), ' Harmonics']);
    legend('Data Points', 'Fourier Series Approximation');
    grid on;
    hold off;
end

x_sample = [0, pi/3, 2*pi/3, pi, 4*pi/3, 5*pi/3, 2*pi];
f_values_sample = [1, 1.4, 1.9, 1.7, 1.5, 1.2, 1];

harmonic_analysis(x_sample, f_values_sample, 4);
