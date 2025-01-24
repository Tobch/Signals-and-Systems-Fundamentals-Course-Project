# Octave 9.2.0, Tue Nov 19 00:41:25 2024 GMT <unknown@DESKTOP-56D2F7L>
# Octave 9.2.0, Tue Nov 19 00:41:37 2024 GMT <unknown@DESKTOP-56D2F7L>
% Load the signal package
pkg load signal;
% Define parameters
fs = 5000; % Sampling frequency (5 kHz)
t = 0:1/fs:1-1/fs; % Time vector (1 second duration)
f1 = 500; f2 = 1000; f3 = 1500; f4 = 2000; % Frequency components
% Step 1: Generate the signal x(t)
x_t = cos(2*pi*f1*t) + cos(2*pi*f2*t) + cos(2*pi*f3*t) + cos(2*pi*f4*t);

% Step 2: Store the signal x(t) as a .wav file
audiowrite('x_t.wav', x_t, fs);

% Step 3: Plot the signal x(t)
figure;
plot(t, x_t);
title('Signal x(t) versus time');
xlabel('Time (s)');
ylabel('Amplitude');

% Step 4: Compute the energy of the signal x(t)
energy_x_t = trapz(t, abs(x_t).^2);
disp(['Energy of x(t): ', num2str(energy_x_t)]);

% Step 5: Compute the frequency spectrum X(f)
X_f = fft(x_t);
f_range = (-fs/2):(fs/length(x_t)):(fs/2 - fs/length(x_t));
X_f_shifted = fftshift(X_f); % Shift to center zero frequency

% Step 6: Plot the magnitude of X(f)
figure;
plot(f_range, abs(X_f_shifted));
title('Magnitude of X(f)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Step 7: Verify Parseval’s theorem by calculating energy from spectrum
energy_from_spectrum = trapz(f_range, abs(X_f_shifted).^2) / fs;
disp(['Energy from frequency spectrum: ', num2str(energy_from_spectrum)]);

% Step 8: Design a Butterworth low-pass filter (order 20, cutoff 1.25 kHz)
low_cutoff = 1250; % Cutoff frequency 1.25 kHz
[b, a] = butter(20, low_cutoff/(fs/2), 'low'); % Butterworth filter design
[b, a] = butter(20, low_cutoff/(fs/2), 'low'); % Butterworth filter design

% Step 9: Plot the magnitude and phase response of the low-pass filter
[H, f] = freqz(b, a, 1024, fs);
figure;
subplot(2,1,1);
plot(f, abs(H));
title('Magnitude Response of Butterworth LPF');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2,1,2);
plot(f, angle(H));
title('Phase Response of Butterworth LPF');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

% Step 10: Apply the signal x(t) to the Butterworth LPF
y1_t = filter(b, a, x_t);

% Step 11: Store the filtered signal y1(t) as a .wav file
audiowrite('y1_t.wav', y1_t, fs);

% Step 12: Plot the filtered signal y1(t)
figure;
plot(t, y1_t);
title('Filtered Signal y1(t) versus time');
xlabel('Time (s)');
ylabel('Amplitude');

% Step 13: Compute the energy of the signal y1(t)
energy_y1_t = trapz(t, abs(y1_t).^2);
disp(['Energy of y1(t): ', num2str(energy_y1_t)]);

% Step 14: Compute the frequency spectrum Y1(f)
Y1_f = fft(y1_t);
Y1_f_shifted = fftshift(Y1_f); % Shift to center zero frequency

% Step 15: Plot the magnitude of Y1(f)
figure;
plot(f_range, abs(Y1_f_shifted));
title('Magnitude of Y1(f)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Step 16: Verify Parseval’s theorem for y1(t) from Y1(f)
energy_from_spectrum_y1 = trapz(f_range, abs(Y1_f_shifted).^2) / fs;
disp(['Energy from frequency spectrum of y1(t): ', num2str(energy_from_spectrum_y1)]);

% Step 17: Design a Butterworth high-pass filter (order 20, cutoff 1.25 kHz)
[b_hp, a_hp] = butter(20, low_cutoff/(fs/2), 'high'); % High-pass filter design

% Step 18: Plot the magnitude and phase response of the high-pass filter
[H_hp, f_hp] = freqz(b_hp, a_hp, 1024, fs);
figure;
subplot(2,1,1);
plot(f_hp, abs(H_hp));
title('Magnitude Response of Butterworth HPF');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2,1,2);
plot(f_hp, angle(H_hp));
title('Phase Response of Butterworth HPF');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

% Step 19: Apply the signal x(t) to the Butterworth HPF
y2_t = filter(b_hp, a_hp, x_t);

% Step 20: Store the filtered signal y2(t) as a .wav file
audiowrite('y2_t.wav', y2_t, fs);

% Step 21: Plot the filtered signal y2(t)
figure;
plot(t, y2_t);
title('Filtered Signal y2(t) versus time');
xlabel('Time (s)');
ylabel('Amplitude');

% Step 22: Compute the energy of the signal y2(t)
energy_y2_t = trapz(t, abs(y2_t).^2);
disp(['Energy of y2(t): ', num2str(energy_y2_t)]);

% Step 23: Compute the frequency spectrum Y2(f)
Y2_f = fft(y2_t);
Y2_f_shifted = fftshift(Y2_f); % Shift to center zero frequency

% Step 24: Plot the magnitude of Y2(f)
figure;
plot(f_range, abs(Y2_f_shifted));
title('Magnitude of Y2(f)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Step 25: Verify Parseval’s theorem for y2(t) from Y2(f)
energy_from_spectrum_y2 = trapz(f_range, abs(Y2_f_shifted).^2) / fs;
disp(['Energy from frequency spectrum of y2(t): ', num2str(energy_from_spectrum_y2)]);
