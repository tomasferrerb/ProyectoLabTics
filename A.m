Settings; 
%ABRIR IMAGEN
imgR= imread(img);
[row,col,prof] = size(imgR);

%PASAR MATRIZ RGB A VECTOR
vector = img2vector(imgR);

%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO

matriz = vector2packet(vector, Npaquetes, row, col); %matriz donde cada fila contiene un paquete

%%Create UDP Object
udpT = udp(ipB,portB,'LocalPort',portA);
udpT.OutputBufferSize = 10000000000
%%Connect to UDP Object
fopen(udpT);

%ENVIAR TODOS LOS PAQUETES 

for i=1:Npaquetes
    fwrite(udpT, matriz(i,:) , 'uint8')
    %pause;
end
fclose(udpT);
