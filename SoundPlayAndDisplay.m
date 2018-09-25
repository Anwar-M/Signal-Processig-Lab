% Als voorbeeld witte ruis met een sample freq van 50 kHz
Fs = 50e3;
t = 10;
y = wgn(Fs*t,1,1);
dt = 0.1;

steps = floor(t/dt);
plot(0:1/Fs:(t-1/Fs),y);
xlim = get(gca, 'XLim');
ylim = get(gca, 'YLim');
soundsc(y,Fs);
for I = 1:steps
    lijn = line(dt*(I-1)*[1 1],[ylim(1) ylim(2)], 'color', 'r', ...
        'LineWidth', 1.5, 'LineStyle', '--');
    pause(dt);
    delete(lijn);
end