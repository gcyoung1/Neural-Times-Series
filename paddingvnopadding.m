srate = 71;

frex = [ 3   10   5   15   35 ];

amplit = [ 5   15   10   5   7 ];

phases = [  pi/7  pi/8  pi  pi/2  -pi/4 ];

time = -1:1/srate:1;

sine_waves = zeros(length(frex),length(time));
for fi=1:length(frex)
    sine_waves(fi,:) = amplit(fi) * sin(2*pi*time*frex(fi) + phases(fi));
end

signal  = sum(sine_waves,1); % sum to simplify
N       = length(signal);    % length of sequence
fourierTime = ((1:N)-1)/N;   % "time" used for sine waves

padsignal = sum(sine_waves,1);
for i = 1:N
  padsignal(length(padsignal)+1)=0;
end
padN = length(padsignal);
padtime = ((1:padN)-1)/padN;

nyquist = srate/2;       

fourierCoefs = zeros(size(padsignal)); 
padfourierCoefs = zeros(size(padsignal)); 
randfourierCoefs = zeros(size(padsignal)); 

pred1= zeros(size(padN)); 
pred2 = zeros(size(padN)); 
pred3 = zeros(size(padN)); 


frequencies = linspace(0,nyquist,floor(N/2)+1);
padfrequencies = linspace(0,nyquist,floor(padN/2)+1);

for fi=1:padN
    
    % create sine wave for this frequency
    padfourierSine = exp( -1i*2*pi*(fi-1).*padtime );
    fourierSine = exp( -1i*2*pi*(fi-1).*padtime(1:N) );
    temp = rand*(padN-1)
    disp(fi-1)
    randSine = exp( -1i*2*pi*temp.*padtime );
    
    % compute dot product as sum of point-wise elements
    fourierCoefs(fi) = dot(fourierSine, signal);
    padfourierCoefs(fi) = dot(padfourierSine, padsignal);
    randfourierCoefs(fi) = dot(randSine, padsignal);

    
    % note: this can also be expressed as a vector-vector product
    % fourier(fi) = fourierSine*signal';
   
    pred1 = pred1 + padfourierSine*padfourierCoefs(fi);
    pred2 = pred2+fourierSine*fourierCoefs(fi);
    pred3 = pred3+randSine*randfourierCoefs(fi);
end


figure(1)
subplot(311)
plot(padtime, pred1)
subplot(312)
plot(time, pred2)
subplot(313)
plot(padtime, pred3)

padfourierCoefs = padfourierCoefs / padN;
fourierCoefs = fourierCoefs / padN;

disp(padfrequencies)

figure(2), clf
subplot(421)
plot(real(exp( -2*pi*1i*(10).*fourierTime )))
xlabel('time (a.u.)'), ylabel('Amplitude')
title('Sine wave')

subplot(423)
plot(signal)
title('Data')

figure(3)
plot(padfrequencies,abs(padfourierCoefs(1:length(padfrequencies)))*2,'*-')
xlabel('Frequency (Hz)')
ylabel('Power (\muV)')
title('Padded power spectrum derived from discrete Fourier transform')

figure(4)
plot(padfrequencies,abs(fourierCoefs(1:length(padfrequencies)))*2,'*-')
xlabel('Frequency (Hz)')
ylabel('Power (\muV)')
title('Non-padded Power spectrum derived from discrete Fourier transform')


