Settings; 
%ABRIR IMAGEN
imgR= imread(img);
[row,col,prof] = size(imgR);

%PASAR MATRIZ RGB A VECTOR
vector = img2vector(imgR);

%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO

matriz = vector2packet(vector, Npaquetes); %matriz donde cada fila contiene un paquete

