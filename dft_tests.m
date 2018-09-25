function dft_tests

close all;

% fs = 10e3;
% f = 1e3;
% a = 1;
% 
% t = 0:1/fs:4*1e-3;
% y = a*sin(2*pi*f*t)+a*sin(1.5*2*pi*f*t)+a*sin(3.5*2*pi*f*t);
% 
% y2 = wgn(10001,1,10); t2 = (0:length(y2)-1)/fs; % 1 sec
% figure; plot(t2,y2);
% [Ya2, Yph2, freqs2] = dft(y2, fs);
% N = length(y2);
% subplot(3,1,1); plot(t2,y2); xlabel('t (s)'); ylabel('a');
% subplot(3,1,2); plot(freqs2,abs(fftshift(Ya2))/N); xlabel('f (Hz)'); ylabel('|Y|');
% subplot(3,1,3); plot(freqs2,fftshift(Yph2)); xlabel('f (Hz)'); ylabel('Angle(Y) (rad)');

fs = 5*200;
t = 0:1/fs:(1-0/fs);
y = 2*sin(2*pi*25*t);

[Ya, Yph, freqs] = dft(y, fs);

figure; plot(t,y);
N = length(y);
subplot(3,3,1); plot(t,y); xlabel('t (s)'); ylabel('y(t)'); title(num2str(rms(y)));
subplot(3,3,2); plot(freqs,abs(fftshift(Ya))/N); xlabel('f (Hz)'); ylabel('|Y|');
title(num2str( sqrt(sum((abs(fftshift(Ya))/N).^2) )));
% subplot(3,3,3); plot(freqs,fftshift(Yph)); xlabel('f (Hz)'); ylabel('Angle(Y) (rad)');

[YaH, YphH, freqsH] = dft(hann(length(y)).*y.', fs);
subplot(3,3,4); plot(t,hann(length(y)).*y.'); xlabel('t (s)'); ylabel('y(t)'); title(num2str(rms(hann(length(y)).*y.')));
subplot(3,3,5); plot(freqs,abs(fftshift(YaH))/N); xlabel('f (Hz)'); ylabel('|Y|');
axis([-500 500 0 1]); title(num2str( sqrt(sum((abs(fftshift(YaH))/N).^2) )));
% subplot(3,3,6); plot(freqs,fftshift(YphH)); xlabel('f (Hz)'); ylabel('Angle(Y) (rad)');

[YaH2, YphH2, freqsH2] = dft(hann(length(y)).*y.', fs);
subplot(3,3,7); plot(t,hann(length(y)).*y.'); xlabel('t (s)'); ylabel('y(t)'); title(num2str(rms(hann(length(y)).*y.')));
subplot(3,3,8); plot(freqs,abs(fftshift(YaH2))/N); xlabel('f (Hz)'); ylabel('|Y|');
title(num2str( sqrt(sum((abs(fftshift(YaH2))/N).^2) )));
% subplot(3,3,9); plot(freqs,fftshift(YphH2)); xlabel('f (Hz)'); ylabel('Angle(Y) (rad)');

% PSD's
N = length(y);
xdft = fft(y);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/N:fs/2;
subplot(3,3,3); plot(freq,psdx); title(num2str(sqrt(sum(psdx*fs/N))));

xdft = fft(hann(N).*y.');
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/N:fs/2;
subplot(3,3,6); plot(freq,psdx); title(num2str(sqrt(sum(psdx*fs/N))));

xdft = fft(hann(N).*y.');
xdft = xdft(1:N/2+1);
psdx = 2*(1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/N:fs/2;
subplot(3,3,9); plot(freq,psdx); title(num2str(sqrt(sum(psdx*fs/N))));


% zero padding
% windowing
% frequency resolution, time windows, etc.
% sine, 'continuous' cut-off and 'dis-continuous' cut-off (comparison)
% aliasing
% general signals

end

function [Y_abs, Y_ang, freqs] = dft(y, fs)

N = length(y);
Y = fft(y);

Y_abs = abs(Y);
Y_ang = angle(Y);
freqs = (-floor(N/2):floor(N/2))*fs/N;

% figure; plot((0:floor(N/2)-1)*fs/N, 2*Y_abs(1:floor(N/2))/N); xlabel('f (Hz)'); ylabel('|Y|');
% figure; plot((0:floor(N/2)-1)*fs/N, 20*log10(2*Y_abs(1:floor(N/2))/N/sqrt(2)/2e-5)); xlabel('f (Hz)'); ylabel('20log(|Y|/sqrt(2)/2e-5)');

end