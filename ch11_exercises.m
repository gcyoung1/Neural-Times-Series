load ../../sampleEEGdata
eeg = squeeze(EEG.data(47,:,1));
N = length(eeg);

#I didn't flip the gaussian before doing the convolution bc it's symmetric anyway right?
#Well not the two convolutions are flipped and the zero padding is for some reason
#on both sides of the convolution when it was only on the right half of the original
#signals. Weird.

time = -1:1/EEG.srate:1;
s = 5/(2*pi*30);
gaussian = exp((-time.^2)/(2*s^2))/30;
padding = zeros(1,length(gaussian)-1);
pad_eeg = [padding eeg padding];

#gaussian = flip(gaussian)
man_conv = [];
middle = (length(gaussian)-1)/2;
for i = middle:length(eeg)+middle-1
  man_conv(length(man_conv)+1) = dot(pad_eeg(i:i+length(gaussian)-1), gaussian);
end

#gaussian = flip(gaussian)
disc_pad_eeg = [eeg padding];
disc_pad_gaussian = [gaussian zeros(1,length(eeg)-1)];
N=length(disc_pad_eeg);
disc_time = (0:N-1)/N;
disc_conv = zeros(1, N);
for fi = 1:N
  complex_sin = exp(-1i*2*pi*(fi-1).*disc_time);
  temp = ((dot(disc_pad_eeg, complex_sin)*dot(disc_pad_gaussian, complex_sin)).*complex_sin);
  disc_conv = disc_conv .+ temp;
end
disp(length(disc_conv))
figure(1)
subplot(331)
plot(EEG.times, eeg)
subplot(332)
plot(EEG.times, eeg)
subplot(333)
plot(EEG.times, eeg)
subplot(334)
plot(time, gaussian)
subplot(335)
plot(time, gaussian)
subplot(336)
plot(time, gaussian)

subplot(337)
plot(EEG.times, man_conv)
subplot(338)
plot(1:length(disc_conv), disc_conv)
#plot(EEG.times, disc_conv(1:length(EEG.times)))
subplot(339)
plot(EEG.times, mat_conv)