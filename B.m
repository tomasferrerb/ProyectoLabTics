Settings;

matriz=[];

%Recibir paquetes 
%Configurar puertos

udpB = udp(ipA,portA,'LocalPort',portB);
udpB.InputBufferSize = 1000000;
fopen(udpB);

%Recibir paquetes y ordenar en matriz
count=1;
total_datos=0;
while 1
    vec=fread(udpB,250,'uint8')
    if vec(1)==0%PRIMER PAQUETE
        row=vec(2);
        col=vec(3);
        N=vec(4);
        sendAudio1(vec.');
        pause(head_dt(end)+pixel_dt(end)*4+1.5);
        %pause(5);
    elseif ~(vec(1)== N)    
        matriz(vec(1),:)=vec;
        count=count+1;
        total_datos=total_datos+vec(2);
        sendAudio1(vec.');
        pause(head_dt(end)+pixel_dt(end)*vec(2)+1.5);
        %pause(5);
    else
        break
    end
    
end
fclose(udpB);

vector  = packet2vector(matriz);
image = vector2img(vector, row, col);

imshow(uint8(image));