file1 = 'O:\V-Tunnel 12-12 Wing-Prop\Data MAT\Meas1.mat';
file2 = 'O:\V-Tunnel 12-12 Wing-Prop\Data MAT\Meas2.mat';

d1 = load(file1);
d2 = load(file2);


%%
Fs = 50e3;
t = 1;
mic = 4;

selection = [d1.data(1:t*Fs,mic);d2.data(1:t*Fs,mic)];

spl1 = 20*log10(rms(d1.data(1:t*Fs,mic))/2e-5);
spl2 = 20*log10(rms(d2.data(1:t*Fs,mic))/2e-5);

fprintf('\t%.2f\n\t%.2f\n', spl1, spl2);

soundsc(selection, Fs);
% pwelch([d1.data(1:t*Fs,mic) d2.data(1:t*Fs,mic)],[],[],[],Fs);
pwelch([d1.data(1:t*Fs,mic) d2.data(1:t*Fs,mic)],5e3,2.5e3,[],Fs);
legend('1','2');
