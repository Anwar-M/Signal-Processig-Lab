Fs = 51200;
t_signal = 4;
%% White noise
y = wgn(1, Fs*t_signal, 1);
sound(y,Fs);
pause;

%% White noise gaussian windowed 
y = wgn(1, Fs*t_signal.*gausswin(length(t_signal),4), 1);
sound(y,Fs);
pause;