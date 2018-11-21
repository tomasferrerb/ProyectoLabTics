function [ signal ] = FSK( data,Fi, Df, Fs, Dt )
%FSK retorna un vector con las señales con frecuencia adecuada al simbolo
%dado por el vector de entrada y la cantidad de bits por simbolo, en este
%caso 4 bits por simbolo.
%data es un vector lineal binario, con los datos de la señal que se desea
%transmitir, F1, la frecuencia del simbolo "0000", Df la distancia en
%frecuencia entre simbolos, Fs la frecuencia de muestreo a la que sera
%transmitida la señal y Dt el tiempo que se transmitira cada simbologfv.
n=floor(length(data)/4);
np=floor(Dt/(1/Fs));
dt=(1/Fs)*np;
signal=zeros(1,n*np);
ti=(1/Fs):(1/Fs):Dt;
au=1;
for i=1:n
    in=(i-1)*4+1;
    auxb=data(in:in+3);
    auxd=bi2de(auxb);
    t=(dt*i)+ti;
    signal(au:au+np-1)=sin(2*pi*(Fi+Df*auxd)*t);
    au=au+np;
end
end

