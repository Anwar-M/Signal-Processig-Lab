clear all; clc; close all;
figure;

RAN = round(rand(480,640)*255);
RAN2 = round((rand(480,640)-0.5)*255);
subplot(2,2,1); imshow(uint8(RAN));
subplot(2,2,2); imshow(uint8(RAN2-min(RAN2)));

F1 = fftshift(fft2(RAN));
F2 = fftshift(fft2(RAN2));

F1a = abs(F1)/(480*640);
F2a = abs(F2)/(480*640);
subplot(2,2,3); imshow(F1a,[min(F1a(:)) max(F1a(:))]);
subplot(2,2,4); imshow(F2a,[min(F2a(:)) max(F2a(:))]);

%%
[X,Y] = meshgrid(1:640, 1:480);

RAN = RAN + 50*sin(15*2*pi*(X/640-0.5*Y/480));

% RAN = RAN + 50*ones(480,1)*sin(15*2*pi*(1:640)/640);
% RAN = RAN + 50*sin(25*2*pi*(1:480).'/480+pi/6)*ones(1,640);
RAN = 255*RAN/max(RAN(:));
figure; imshow(uint8(RAN));

%%

[b,a]=butter(2, [.01,.02]);   
for I = 1:480
    RAN2b(I,:) = filter(b,a, RAN2(I,:));
end
figure; imshow(RAN2b);