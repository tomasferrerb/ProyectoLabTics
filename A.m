Settings; 
%ABRIR IMAGEN
imgR= imread(img);
[row,col,prof] = size(imgR);

%PASAR MATRIZ RGB A VECTOR
vector = img2vector(imgR);

%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO

matriz = vector2packet(vector, Npaquetes, row, col); %matriz donde cada fila contiene un paquete

%%Create UDP Object
udpA = udp(ipB,portB,'LocalPort',portA);
udpA.OutputBufferSize = 10000000000
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 

for i=1:Npaquetes
    fwrite(udpA, matriz(i,:) , 'uint8')
    %pause;
end
fclose(udpA);

%%Create UDP Object
udpA = udp(ipC,portC,'LocalPort',portA);
udpA.OutputBufferSize = 10000000000
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 

for i=1:Npaquetes
    fwrite(udpA, matriz(i,:) , 'uint8')
    %pause;
end
fclose(udpA);
