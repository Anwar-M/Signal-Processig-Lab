clear all; clc; %close all;
addpath('O:\MATLAB Signal Processing Files');

signal_time = 30/10;
Fs = 50e3;
N = signal_time*Fs;

Y = wgn(N,1,10); % impedance is 1, i.e. rho*c = 1 for acoustics, add +10*log10(2) for double power
disp(10*log10(rms(Y)^2));
fprintf('\tInitial signal:\n');
fprintf('\tSPL_tot = %.2f dB\n', 20*log10(rms(Y)/2e-5));
% spectrum_level(Y,Fs,3,0,10)

%% Butter worth it?
figure('Position', [350 350 0.75*1680 420]);

df = Fs/N;
freq = (0:floor(N/2)-1)*df;
xdfto = fft(Y);
fc_1000  = [4e3  6e3];
selection = boolean((freq>=fc_1000(1)).*(freq<=fc_1000(2)));

xpsdo = (1/(Fs*N)) * abs(xdfto(1:floor(N/2))).^2;
xpsdo(2:end-1) = 2*xpsdo(2:end-1);

% points = 3/(Fs/N);
% for I = 1:(N/2/points)
%     dBlevel(I) = 20*log10(sqrt(sum(xpsdo((I-1)*points+1:points*I)*Fs/N))/2e-5);
% %     dBlevel(I) = 10*log10(sqrt(sum(xpsdo((I-1)*points+1:points*I)))/2e-5);
%     % To have same as psd, you need to remove 2e-5, Fs/N and not use sqrt
% end
% fprintf('\tSPL_totfrombands = %.2f dB\n', 10*log10(sum(10.^(dBlevel/10))));
% figure; plot(3/2:3:(freq(end)-3/2), dBlevel);
% 
% xlabel('f (Hz)');
% ylabel('Spectrum Level [dB]');
% axis([0 25e3 50 100]);
% 
% keyboard;

subplot(1,3,1);
% figure;
plot(freq,10*log10(xpsdo));axis([0 25e3 -90 -10]);
fprintf('\tSPL_totfrompsd = %.2f dB\n\n', 20*log10(sqrt(sum(xpsdo*Fs/N))/2e-5));
% figure; periodogram(Y,rectwin(length(Y)),length(Y),Fs);

fprintf('\tButterworth filtering:\n');
N_order = 4;
fN = Fs/2;
[b,a] = butter(N_order,fc_1000/fN);
Y_filt = filtfilt(b,a,Y);
fprintf('\tSPL_band = %.2f\n', 20*log10(rms(Y_filt)/2e-5));
hold on;
xdft = fft(Y_filt);
xpsd = (1/(Fs*N)) * abs(xdft(1:floor(N/2))).^2;
xpsd(2:end-1) = 2*xpsd(2:end-1);
fprintf('\tSPL_bandfrompsd = %.2f\n', 20*log10(sqrt(sum(xpsd(selection)*Fs/N))/2e-5));
plot(freq,10*log10(xpsd),'r');
axis([0 25e3 -90 -10]);
plot_settings(gca, '$f$ [Hz]', 'PSD [dB/Hz]', ['Band pass'], [0 25e3], ...
               [-100 -10], 0:5e3:25e3, -100:10:-10, 'on', 'on', 0, 0, 0, []);
hold off


subplot(1,3,2);
plot(freq,10*log10(xpsdo));axis([0 25e3 -90 -10]);
[b,a] = butter(N_order,fc_1000(1)/fN,'high');
Y_filt = filtfilt(b,a,Y);
fprintf('\tSPL_high = %.2f\n', 20*log10(rms(Y_filt)/2e-5));
hold on;
xdft = fft(Y_filt);
xpsd = (1/(Fs*N)) * abs(xdft(1:floor(N/2))).^2;
xpsd(2:end-1) = 2*xpsd(2:end-1);
plot(freq,10*log10(xpsd),'r');
plot_settings(gca, '$f$ [Hz]', 'PSD [dB/Hz]', ['High pass'], [0 25e3], ...
               [-100 -10], 0:5e3:25e3, -100:10:-10, 'on', 'on', 0, 0, 0, []);
hold off

subplot(1,3,3);
plot(freq,10*log10(xpsdo));axis([0 25e3 -90 -10]);
[b,a] = butter(N_order,fc_1000(1)/fN,'low');
Y_filt = filtfilt(b,a,Y);
fprintf('\tSPL_low = %.2f\n', 20*log10(rms(Y_filt)/2e-5));
hold on;
xdft = fft(Y_filt);
xpsd = (1/(Fs*N)) * abs(xdft(1:floor(N/2))).^2;
xpsd(2:end-1) = 2*xpsd(2:end-1);
plot(freq,10*log10(xpsd),'r');
plot_settings(gca, '$f$ [Hz]', 'PSD [dB/Hz]', ['Low pass'], [0 25e3], ...
               [-100 -10], 0:5e3:25e3, -100:10:-10, 'on', 'on', 0, 0, 0, []);
hold off

% figure; periodogram(Y_filt,rectwin(length(Y_filt)),length(Y_filt),Fs);

%% Spectrum level check
fprintf('\n\tSpectrum Level:\n');
clear dBlevel
fprintf('\tSPL_totfrompsd = %.2f dB\n\n', 20*log10(sqrt(sum(xpsdo*Fs/N))/2e-5));
points = 30;
sum(xpsdo)
for I = 1:(N/2/points)
    dBlevel(I) = 20*log10(sqrt(sum(xpsdo((I-1)*points+1:points*I)*Fs/N))/2e-5);
%     dBlevel(I) = 10*log10(sqrt(sum(xpsdo((I-1)*points+1:points*I)))/2e-5);
    % To have same as psd, you need to remove 2e-5, Fs/N and not use sqrt
end
fprintf('\tSPL_totfrombands = %.2f dB\n\n', 10*log10(sum(10.^(dBlevel/10))));
figure; plot(freq(1:points:end), dBlevel);
mini = round(min(dBlevel)/10)*10-20;
maxi = round(max(dBlevel)/10)*10+20;
plot_settings(gca, '$f$ [Hz]', 'Spectrum Level [dB]', [], [0 25e3], ...
               [mini maxi], 0:5e3:25e3, mini:10:maxi, 'on', 'on', 0, 0, 0, []);


%% Effect of using more blocks
t = signal_time;
t_b = 0.1/2; % sec
N_b = t_b*Fs;
n_blocks = 2*floor(t/t_b)-1; % amount of blocks, 50 % overlap
fprintf('\tUsing %d blocks\n', n_blocks);
df = Fs/N_b;

psdx = zeros(floor(N_b/2),1);
freq = (0:floor(N_b/2)-1)*df;
figure;
plot_settings(gca, '$f$ [Hz]', 'PSD [dB/Hz]', [], [0 25e3], ...
               [-100 -10], 0:5e3:25e3, -100:10:-10, 'on', 'on', 0, 0, 0, []);
for B = 1:n_blocks
    
    % fft with hanning window to all microphones, index according to 50% overlap
    xdft = fft(Y( (B-1)*N_b/2 + 1 : (B+1)*N_b/2) .* ...
        hann(N_b));
    
    psdx = psdx + (1/(Fs*N_b)) * abs(xdft(1:floor(N_b/2))).^2;
    plot(freq(2:end-1)/1000,10*log10(2*4*psdx(2:end-1)/B));
    msg = sprintf('White noise. Block %d of %d.', B, n_blocks);
    xlabel('f (kHz)');
    ylabel('PSD (dB/Hz)');
    title(msg);
    axis([0 25 -90 -20]);
    if (B<5)
        pause(0.975);
    elseif (B<15)
        pause(0.125);
    end
    pause(0.025);
end
xdft_all = fft(Y);
psdx_all = (1/(Fs*N)) * abs(xdft_all(1:floor(N/2))).^2;
freq_all = (0:floor(N/2)-1)*(Fs/N); figure;
plot(freq_all(2:end-1)/1000,10*log10(2*psdx_all(2:end-1)));
title('White noise, whole signal');
xlabel('f (kHz)');
ylabel('PSD (dB/Hz)');
axis([0 25 -90 -20]);

% psdx = 4*psdx/n_blocks; % Hanning AMPLITUDE CORRECTION factor
% psdx(2:end-1) = 2*psdx(2:end-1); % Single-side
% figure; plot(freq/1000,10*log10(psdx)); title('end');

