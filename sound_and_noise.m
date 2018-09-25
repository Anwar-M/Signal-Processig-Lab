load gong.mat;
Fs = 8192;
yw = wgn(length(y),2,1);
soundsc(y+yw(:,1));