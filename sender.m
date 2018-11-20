close all
clear
clc
Settings; 


%abrir PNG y obtener dimensiones
imgR = imread(img);
[row, col ,prof]= size(imgR);

%PNG a vector
vector=reshape(imgR,[1,row*col*prof]);


%Dividir vector en N (o N+1) paquetes
%L largo de cada paquete
%r largo ultimo paquete
%N*L+r= largoVector
N=16; 
largoVector=size(vector);
largoVector=largoVector(2);
L=floor(largoVector/N);

%Crear paquetes y poner cabecera de secuencia [paquetesTotales
%secuenciaPaquete datos]
paquetes=[]%matriz donde cada fila es un paquete
p=1;
for n=1:N
    paquetes(n,:)=[N n vector(p:p+L-1)];
    p=p+L;
end

%enviar los paquetes por sockets y añadirles la direccion
for n=1:N
    socket(paquetes(n,:), direccion);
end 

