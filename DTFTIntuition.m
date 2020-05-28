x=0:0.5:5
sins = {}
legend=[]
hold on
for i = 1:10
  plot(x,sin(2*pi*0.1*i*x))
  legend(length(legend)+1)=(i+1)*0.1
endfor
legends(legend)
