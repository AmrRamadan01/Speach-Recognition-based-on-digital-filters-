

Fs=4000; %Hz
Fnaq=Fs/2; % Nyquist

%-- Initializing coefficients --

fc_0 = 50;
f6 = 300;
f1 = 250;

%-- Calculating coefficients --
[b, a]=cheby2 (2, 20, fc_0 / Fnaq); % LPF
##[B1, A1]=cheby2 (2, 20, [f0 f1]); % BPF
##[B6, A6]=cheby2 (2,20, f6, 'high'); % HPF

cast(b,"double");
printf("%d ", b)'
