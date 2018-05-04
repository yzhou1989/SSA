% 合成信号生成

% synSig

% t=0:30;
% stat1=sin((t)*2*pi/20);
% stat2=sin((t-5)*2*pi/20);
% plot(t,stat1,'r',t,stat2,'b');

%%
vel=3;
len=500;
sig=zeros(9,len);
timeDelay=50;
% 生成信号
t=0:9;
for i=1:size(station,1)
    for j=1:size(epicenter,1)
        tem=zeros(1,len);
        tsf=delti(dist(station{i,2},station{i,3},...
            epicenter{j,2},epicenter{j,3}),vel);
        tsfInt=ceil(tsf)+timeDelay;
        tsfDec=mod(tsf,1);
        tem(1,tsfInt:tsfInt+length(t)-1)=sin((t-tsfDec+1)*2*pi/20);
        c=1;
        if j==2
            c=0.75;
        end
        sig(i,:)=sig(i,:)+c*tem;
    end
    sig(i,:)=sig(i,:)/max(sig(i,:)); % 归一化
end

%%
figure;
for i=1:size(station,1)
    subplot(9,1,i);
    plot(sig(i,:));
    ylabel(num2str(i));
end