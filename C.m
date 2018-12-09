Settings;

matriz=[];

%Recibir paquetes 
%Configurar puertos

udpC = udp(ipA,portA,'LocalPort',portC);
udpC.InputBufferSize = 1000000;
fopen(udpC);


%Recibir paquetes y ordenar en matriz
count=1;
total_datos=0;
while 1
    vec=fread(udpC,250,'uint8');
    if vec(1)==0%PRIMER PAQUETE
        row=vec(2);
        col=vec(3);
        N=vec(4);
    elseif ~(vec(1)== N)    
        matriz(vec(1),:)=vec;
        count=count+1;
        total_datos=total_datos+vec(2);
    else
        break
    end
end
fclose(udpC);

vector  = packet2vector(matriz);
image = vector2img(vector, row, col);

imshow(uint8(image)); 