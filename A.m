Settings; 
%%%%%%%%%%%%%ABRIR IMAGEN%%%%%%%%%%%%
imgR= imread(img);
[row,col,prof] = size(imgR);

%%%%%%%%%%%%PASAR MATRIZ RGB A VECTOR%%%%%%%%%%%%%%
vector = img2vector(imgR);

%%%%%%%%%%%%%CANTIDAD DE PAQUETES%%%%%%%%%%%%%%%%
l = size(vector);
l = l(2);
Npaquetes = floor(l / l_paquete);
if (Npaquetes*l_paquete<l)
    Npaquetes=Npaquetes+1;
end


%%%%ANTES Y DESPUES DE LOS ENVIAR PAQUETES DE DATOS, SE ENVIA UN PAQUETE
%%%%ESPECIAL CON: 
%%%%    DIMENSIONES DE LA IMAGEN
%%%%    CANTIDAD DE PAQUETES

%%%%%% #paquete dimensiones_imagen tiempo
paquete_ini=[0 row col Npaquetes];

%%%%%%%%%%%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO%%%%%%%%%%%%%%%%%%
%%%%        HEADER                          %%%%PAYLOAD%%%%%%%%%%%%%%
%%%%CANTIDAD DE DATOS%%NUMERO DE PAQUETE%%%%
matriz = vector2packet(vector, l_paquete); %matriz donde cada fila contiene un paquete


%%Create UDP Object
tic;
udpA = udp(ipB,portB,'LocalPort',portA);
udpA.OutputBufferSize = 10000000000;
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 
fwrite(udpA,paquete_ini,'uint8')
for i=1:Npaquetes
    fwrite(udpA, matriz(i,:) , 'uint8')
    %pause;
end
time=floor(1000*toc); %%%AFINAR TIEMPO
paquete_end=[0 row col time];
fwrite(udpA,paquete_end,'uint8')
fclose(udpA);





%%Create UDP Object
udpA = udp(ipC,portC,'LocalPort',portA);
udpA.OutputBufferSize = 10000000000
%%Connect to UDP Object
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 
fwrite(udpA,paquete_ini,'uint8')
for i=1:Npaquetes
    fwrite(udpA, matriz(i,:) , 'uint8')
    %pause;
end
time=floor(1000*toc); %%%AFINAR TIEMPO
paquete_end=[row col];
fwrite(udpA,paquete_end,'uint8')
fclose(udpA);
%TIEMPO INICIAL EN PRIMER PAQUETE
