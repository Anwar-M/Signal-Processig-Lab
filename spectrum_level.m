function spectrum_level(x, Fs, t_block, overlap, df)

N_total_samples = length(x);
t_signal = N_total_samples/Fs;

fprintf('\tSignal time: %.2f s, Sample frequency: %d Hz,\n\t%d samples\n', t_signal, Fs, N_total_samples);

if nargin < 8
    t_start = 0;
    t_end = t_signal;
end
if (t_start < 0) || (t_end > t_signal) || (t_block>(t_end-t_start))
    error('Time-boundaries out of bounds!');
end

fprintf('\tBlock-size %.2f s with %.2f%% overlap.\n', t_block, overlap*100);

start_sample = floor(t_start*Fs) + 1;
block_samples = ceil(t_block*Fs);
end_sample = ceil(t_end*Fs);
offset_sample = block_samples * (1 - overlap) + 1 - 1;
N_blocks = floor( (end_sample - block_samples - start_sample + 1) / ...
                  offset_sample ) + 1;
              
x_fr = Fs / block_samples * (0:floor(block_samples/2)-1);
psdx = zeros(floor(block_samples/2),1);
reverseStr = '';
for B = 1:N_blocks
    msg = sprintf('\tEvaluating fft at block %d/%d...\n', B, N_blocks);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
    
    N_start = start_sample + (B-1) * offset_sample;
    N_end = N_start + block_samples - 1;
    
    xdft = fft(x(N_start:N_end));
    psdx = psdx + (1/(Fs*block_samples)) * abs(xdft(1:floor(block_samples/2))).^2;
    
    
end
psdx(2:end-1) = 2*psdx(2:end-1);
psdx = psdx/N_blocks;
fprintf('\t%.2f\n', sum(psdx));
fprintf('\tCalculating spectrum Level...\n');

points = df/(Fs/block_samples);
for I = 1:(block_samples/2/points)
    dBlevel(I) = 20*log10(sqrt(sum(psdx((I-1)*points+1:points*I)*Fs/block_samples))/2e-5);
%     dBlevel(I) = 10*log10(sqrt(sum(xpsdo((I-1)*points+1:points*I)))/2e-5);
    % To have same as psd, you need to remove 2e-5, Fs/N and not use sqrt
end
fprintf('\tSPL_totfrombands = %.2f dB\n', 10*log10(sum(10.^(dBlevel/10))));
figure; plot(df/2:df:x_fr(end)-0*df/2, dBlevel);

xlabel('f (Hz)');
ylabel('Spectrum Level [dB]');
axis([0 25e3 50 100]);
fprintf('\tDone.\n');