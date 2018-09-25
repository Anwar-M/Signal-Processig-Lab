close all; clear all;
Fs = 1000;   
t = 0:1/Fs:.296;
% t = 0:1/Fs:(1-0/Fs);
x = cos(2*pi*t*200)+randn(size(t));
N = length(x);
%%
pwelch(x,[],[],[],Fs,'onesided');
figure;
pwelch(x, ones(1,N),0, N, Fs);

%% Only fourier
df = Fs/N;
freq = (0:floor(N/2)-1)*df;
xdft = fft(x);
figure; plot(freq, 2*abs(xdft(1:floor(N/2)))/N); close;

%% PSD whole signal
xpsd = (1/(Fs*N)) * abs(xdft(1:floor(N/2))).^2;
xpsd(2:end-1) = 2*xpsd(2:end-1);
figure; plot(freq,10*log10(xpsd));
axis([0 500 -80 -10]);
figure; periodogram(x,rectwin(length(x)),length(x),Fs);

%% Replicate pwelch standard
n_blocks = 7;
N_b = floor(N/ceil(n_blocks/2));
xdft = zeros(N_b, 1);
psdx = zeros(floor(N_b/2), 1);
df = Fs/N_b;
freq = (0:floor(N_b/2)-1)*df;
for B = 1:n_blocks
    % fft with window, index according to 50% overlap
    xdft = fft(x( (B-1)*N_b/2 + 1 : (B+1)*N_b/2 ).' .* ...
        hann(N_b));
    psdx = psdx + (1/(Fs*N_b)) * abs(xdft(1:floor(N_b/2))).^2;

end
psdx = 4*psdx/n_blocks; % Hanning AMPLITUDE CORRECTION factor
psdx(2:end-1,:) = 2*psdx(2:end-1,:);
figure; plot(freq,10*log10(psdx));

%%
n_blocks = 7;
N_b = floor(N/ceil(n_blocks/2));
psdx = zeros(floor(256/2), 1);
df = Fs/256;
freq = (0:floor(256/2)-1)*df;
for B = 1:n_blocks
    % fft with window, index according to 50% overlap
    xdft = fft(x( (B-1)*N_b/2 + 1 : (B+1)*N_b/2 ).' .* ...
        hamming(N_b), 256);
    psdx = psdx + (1/(Fs*N_b)) * abs(xdft(1:floor(256/2))).^2;

end
psdx = 4*psdx/n_blocks; % Hanning AMPLITUDE CORRECTION factor
psdx(2:end-1,:) = 2*psdx(2:end-1,:);
figure; plot(freq,10*log10(psdx));
