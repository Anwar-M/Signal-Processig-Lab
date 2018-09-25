Fs = 51200;
t_signal = 2;
%% Pulse-like signals
fc = 0.5e3;
bw = 1e-2;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('500 Hz pulse, press key...')
sound(yi, Fs);
pause

%%
fc = 1e3;
bw = 1e-2;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('1000 Hz pulse, press key...')
sound(yi, Fs);
pause

%%
fc = 5e3;
bw = 5e-3;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('5000 Hz pulse, press key...')
sound(yi, Fs);
pause

%%
fc = 10e3;
bw = 1e-3;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('10000 Hz pulse, press key...')
sound(yi, Fs);
pause

%% Pulse train 10 secs, larger bandwidth -> 'sharper' pulses
t_signal = 1;
fc = 0.5e3;
bw = 1e-1;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('500 Hz pulses, press key...')
sound(repmat(yi,1,10), Fs);
pause

%%

t_signal = 1;
fc = 1e3;
bw = 1e-1;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('1000 Hz pulses, press key...')
sound(repmat(yi,1,10), Fs);
pause

%%
t_signal = 1;
fc = 5e3;
bw = 1e-1;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('5000 Hz pulses, press key...')
sound(repmat(yi,1,10), Fs);
pause

%%
t_signal = 1;
fc = 10e3;
bw = 1e-1;
t = -t_signal/2:1/Fs:t_signal/2;
yi = gauspuls(t,fc,bw);
disp('10000 Hz pulses, press key...')
sound(repmat(yi,1,10), Fs);
pause