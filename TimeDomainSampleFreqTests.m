% This code illustrates the effect of the required sampling frequency for
% the DAQ when using a time domain BF method. This is done as a function of
% source and microphone distances under the assumption of a mic-array
% perpendicular to the source.

z = 1:0.1:5;
x = 0.01:0.1:1;
c = 343;

r = zeros(length(z), length(x));
t = r;
dt = r;
for I = 1:length(z)
    for J = 1:length(x)
        r(I, J) = sqrt(x(J)^2 + z(I)^2);
    end
    dt(I,:) = - z(I)/c + r(I,:)/c;
end
C{1:10} = num2str(x);
t = r./c;

%%

plot(z,dt.*1e3);

for I = 1:length(x)
    C{I} = strcat(num2str(x(I)), ' m');
end
axis tight
xlabel('Source distance to microphone array (m)');
ylabel('Minimum sampling time (ms)');
title('T_s for various distances between mics as function of source distance');
legend(C);