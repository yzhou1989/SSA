% waveHighFreq

[c,l]=wavedec(data,6,'db4');
c1=c;
c1(1:l(1))=0;
data1=waverec(c1,l,'db4');
figure;plot(data1);