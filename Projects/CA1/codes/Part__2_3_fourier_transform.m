fs = 1000; 
T = 2; 
t = 0:1/fs:2*T; 

f_cos = cos(pi * t); 

figure;
plot(t, f_cos);
xlabel('Time (s)');
ylabel('cos(\pi t)');
title('Time Domain of cos(\pi t)');
grid on;

N = length(f_cos);
f_cos_fft = fft(f_cos);
f_cos_fft_shifted = fftshift(f_cos_fft);
f = (-N/2:N/2-1)*(fs/N); 

figure;
plot(f, abs(f_cos_fft_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain of cos(\pi t) using FFT');
grid on;




f_const = ones(size(t)); 

figure;
plot(t, f_const);
xlabel('Time (s)');
ylabel('f(x) = 1');
title('Time Domain of f(x) = 1');
grid on;

f_const_fft = fft(f_const);
f_const_fft_shifted = fftshift(f_const_fft);

figure;
plot(f, abs(f_const_fft_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain of f(x) = 1 using FFT');
grid on;









% تابع f(x) = δ(x)
f_delta = @(t) dirac(t); % تعریف تابع

delta_samples = f_delta(t);

figure;
stem(t, delta_samples, 'filled');
xlabel('Time (s)');
ylabel('f(x) = \delta(x)');
title('Time Domain of f(x) = \delta(x)');
grid on;

delta_samples_fft = fft(delta_samples);
delta_samples_fft_shifted = fftshift(delta_samples_fft);

figure;
plot(f, abs(delta_samples_fft_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain of f(x) = \delta(x) using FFT');
grid on;
