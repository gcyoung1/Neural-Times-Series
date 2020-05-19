load sampleEEGdata.mat;
##for i = 1:64
##  hold on
##  plot(EEG.times, mean(EEG.data(i,:,:), 3))
##  disp(i)
##end
##legend(EEG.chanlocs.labels)

for i = 0:100:400
    figure((i/100)+1)
    startIndex = dsearchn(EEG.times',i-20);
    endIndex = dsearchn(EEG.times',i+20);
    timepoint = [];
    for j = 1:64
        temp = 0;
        for k=startIndex:endIndex
           temp = temp + mean(EEG.data(j,k,:));
          end
          temp = temp/k;
          timepoint(length(timepoint)+1) = temp;
    end
    topoplot(timepoint, EEG);
    title(["EEG data at time " i "smoothed by 20ms in each direction"])
end

figure(2)
startIndex = dsearchn(EEG.times',100);
endIndex = dsearchn(EEG.times',400);
maxTimes = [];
for i = 1:64
  [a,b]=max(mean(EEG.data(i, startIndex:endIndex, :)));
  maxTimes(length(maxTimes)+1)=EEG.times(startIndex+b);
end
topoplot(maxTimes, EEG)
%2. find the peak time of the ERP between 100 and 400 ms. Store these peak times in a separate variable and then make a topographical plot of the peak times (that is, the topographical map will illustrate times in milliseconds, not activity at peak times). Include a color bar in the figure and make sure to show times in milliseconds from time 0 (not, for example, time in milliseconds since 100 ms or indices instead of mil-liseconds). What areas of the scalp show the earliest and the latest peak responses to the stimulus within this window?


