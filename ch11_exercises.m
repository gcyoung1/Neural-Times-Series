##load ../../sampleEEGdata
##eeg = squeeze(EEG.data(47,:,1));
##N = length(eeg);
##
###I didn't flip the gaussian before doing the convolution bc it's symmetric anyway right?
###Well not the two convolutions are flipped and the zero padding is for some reason
###on both sides of the convolution when it was only on the right half of the original
###signals. Weird.
##
##time = -1:1/EEG.srate:1;
##s = 5/(2*pi*30);
##gaussian = exp((-time.^2)/(2*s^2))/30;
##padding = zeros(1,length(gaussian)-1);
##pad_eeg = [padding eeg padding];
##
##tic
##for i = 1:1000
##  man_conv = [];
##  middle = (length(gaussian)-1)/2;
##  for i = middle:length(eeg)+middle-1
##    man_conv(length(man_conv)+1) = dot(pad_eeg(i:i+length(gaussian)-1), gaussian);
##  end
##end
##man = toc
##
##tic
##for i = 1:1000
##  disc_pad_eeg = [eeg padding];
##  disc_pad_gaussian = [gaussian zeros(1,length(eeg)-1)];
##  N=length(disc_pad_eeg);
##  disc_time = (0:N-1)/N;
##  disc_conv = zeros(1, N);
##  for fi = 1:N
##    complex_sin = exp(1i*2*pi*(fi-1).*disc_time);
##    temp = ((dot(disc_pad_eeg, complex_sin)*dot(disc_pad_gaussian, complex_sin)).*complex_sin);
##    disc_conv = disc_conv .+ temp;
##    #before_ifft(fi) = (dot(disc_pad_eeg, complex_sin)*dot(disc_pad_gaussian, complex_sin));
##  end
##end
##disc=toc
##
##
##tic
##for i = 1:1000
##  #disc_conv = ifft(before_ifft)
##  mat_conv = ifft(fft(gaussian, length(gaussian)+length(eeg)-1).* fft(eeg, length(gaussian)+length(eeg)-1));
##end
##mat=toc
##
##plot([man, disc, toc])

##
##figure(1)
##subplot(331)
##plot(EEG.times, eeg)
##subplot(332)
##plot(EEG.times, eeg)
##subplot(333)
##plot(EEG.times, eeg)
##subplot(334)
##plot(time, gaussian)
##subplot(335)
##plot(time, gaussian)
##subplot(336)
##plot(time, gaussian)
##
##subplot(337)
##plot(EEG.times, man_conv)
##subplot(338)
##plot(EEG.times, disc_conv(middle+1:length(mat_conv)-middle))
###plot(EEG.times, disc_conv(1:length(EEG.times)))
##subplot(339)
##plot(EEG.times, mat_conv(middle+1:length(mat_conv)-middle))

srate = 100
time = -1:1/srate:1;
signal = 5*sin(2*pi*5.*time) .+ 20*sin(2*pi*2.*time) .+ 10*sin(2*pi*10.*time);
little_noise_signal = signal .+ rand(1,length(time))*10;
lotta_noise_signal = signal .+ rand(1,length(time))*200;

figure(1)
subplot(321)
plot(time, signal)
subplot(322)
plot(1:length(time)/2,fft(signal)(1:length(time)/2))
subplot(323)
plot(time, little_noise_signal)
subplot(324)
plot(1:length(time)/2,abs(fft(little_noise_signal))(1:length(time)/2))
subplot(325)
plot(time, lotta_noise_signal)
subplot(326)
plot(1:length(time)/2,abs(fft(lotta_noise_signal))(1:length(time)/2))