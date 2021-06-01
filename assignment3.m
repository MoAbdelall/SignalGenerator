clear
clc
f=input("enter sampling frequency: ");
t1=input("enter start time: ");
t2=input("enter end time: ");
n=input("enter number of break points: ");
for i=1:n
    bp(i)=input("enter break point number " +i+": ");
end
p=[t1 bp t2];
t=[];
x=[];
for j=1:length(bp)+1
    thist=[];
    thisx=[];
    disp("1=DC, 2=Ramp, 3=Polynomial, 4=Exponential, 5=Sinusoidal");
    mode=input("choose a mode for region from "+p(j)+" to "+p(j+1)+": ");
    thist=linspace(p(j),p(j+1),f*(p(j+1)-p(j)));
    %t=[t thist];
    if mode==1
        amplitude=input("enter DC amplitude: ");
        thisx=amplitude*ones(1,length(thist));
    elseif mode==2
        slope=input("enter ramp slope: ");
        intercept=input("enter ramp intercept: ");
        thisx=slope.*thist+intercept;
    elseif mode==3
        power=input("enter highest polynomial power: ");
        for k=power:-1:1
          amplitude(k)= input("enter amplitude of t^"+k+" term: ");
        end
        intercept =input("enter intercept: ");
        thisx     =intercept*ones(1,length(thist));
        for k=length(amplitude)
            thisx=thisx+amplitude(k).*thist.^k;
        end
    elseif mode==4
        amplitude =input("enter Amplitude of exponential: ");
        exponent  =input("enter Exponent: ");
        thisx     =amplitude*exp(exponent*thist);
    else
        amplitude =input("enter Amplitude of sinusoidal: ");
        frequency =input("enter Frequecny of sinusoidal: ");
        phase     =input("enter phase of sinusoidal: ");
        thisx     =amplitude*sin(2*pi*frequency*thist+phase);
    end
    t=[t thist];
    x=[x thisx];
end
subplot(2,1,1);
plot(t,x);
title("Original Plot");
editedt=t;
editedx=x;
disp("1=Amplitude scaling, 2=time reversal, 3=time shift, 4= Expanding signal, 5=compressing signal, 6=None");
operation=input("what operation would you like to perform: ");
while operation<6
    if     operation==1
        scale=input("enter scale value: ");
        editedx=editedx.*scale;
    elseif operation==2
        editedt=-editedt;
    elseif operation==3
        shift=input("enter right shift value: ");
        editedt=editedt+shift;
    elseif operation==4
        scale=input("enter expanding value: ");
        editedt=editedt*scale;
    elseif operation==5
        scale=input("enter compressing value: ");
        editedt=editedt*scale;
    end
    subplot(2,1,2);
    plot(editedt,editedx);
    title("Edited Plot");
    disp("1=Amplitude scaling, 2=time reversal, 3=time shift, 4= Expanding signal, 5=compressing signal, 6=None");
    operation=input("what next operation would you like to perform: ");
end
disp("DONE!");