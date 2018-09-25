Fs = 51200;
t_signal = 4;
%% Simple sine
t = 0:1/Fs:t_signal;

f = 1000;
y = sin(2*pi*f*t);
sound(y,Fs);
pause;

f = 500;
y = sin(2*pi*f*t);
sound(y,Fs);
pause;


f = 5000;
y = sin(2*pi*f*t);
sound(y,Fs);
pause;

f = 10000;
y = sin(2*pi*f*t);
sound(y,Fs);
pause;



