Settings; 
%ABRIR IMAGEN
imgR= imread(img);
[row,col,prof] = size(imgR);

%PASAR MATRIZ RGB A VECTOR
vector = img2vector(imgR);

%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO

matriz = vector2packet(vector, Npaquetes); %matriz donde cada fila contiene un paquete


%ENVIAR TODOS LOS PAQUETES 

for i=1:Npaquetes
    socket(ipA,ipB,portA,portB,matriz(i,:));
    socket(ipA,ipC,portA,portC,matriz(i,:));
end

