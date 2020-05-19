ukernel = [-20 -10 0 -10 -20];
dkernel = [0 -5 -10 -15 -20];

dataslice = [0 0 EEG.data(1,1:50,1) 0 0];
uconv = [];
dconv=[];
for i = 3:52
  uconv(length(uconv)+1) = dot(dataslice(i-2:i+2), ukernel);
  dconv(length(dconv)+1) = dot(dataslice(i-2:i+2), dkernel);
endfor


figure(1);
subplot(311);
plot(1:50, dataslice(3:52));
subplot(312);
plot(1:50, uconv);
subplot(313);
plot(1:50, dconv);