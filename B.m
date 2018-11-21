Settings;

matriz=[];

%Recibir paquetes 
%Configurar puertos
%
%
%


%Recibir paquetes y ordenar en matriz
count=1;
while 1:
    fread(udpB,250,'uint8');
    if count==1
        N=vec(1);
        row= vec(3);
        col=vec(4);
    end
    matriz(vec(2),:)=vec;
    count=count+1;
    if count==N
        break
    end
end

[vector row col] = packet2vector(matriz);
image = vector2img(vector, row, col);

imshow(uint8(image)); 