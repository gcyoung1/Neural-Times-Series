function out = topoplot(data, EEG)
  [elocsX,elocsY] = pol2cart(pi/180*[EEG.chanlocs.theta],[EEG.chanlocs.radius]);
  interp_detail = 100;
  interpX = linspace(min(elocsX)-.2,max(elocsX)+.25,interp_detail);
  interpY = linspace(min(elocsY),max(elocsY),interp_detail);
  [gridX,gridY] = meshgrid(interpX,interpY);
  topodata = griddata(elocsY', elocsX', data,gridX,gridY);
##  contourf(interpY,interpX,topodata,100,'linecolor','none');
##  axis square;
##  set(gca,'xlim',[-.5 .5],'ylim',[-1 .8]);
##  title('Interpolated data using ''contourf''');

  % surface
  subplot(222)
  surf(interpY,interpX,topodata);
  xlabel('left-right of scalp'), ylabel('anterior-posterior of scalp'), zlabel('\muV')
  shading interp, axis square
  set(gca,'xlim',[-.5 .5],'ylim',[-1 .8])
  rotate3d on, view(0,90)
  title('Interpolated data using ''surf''')
  
  return;
endfunction
