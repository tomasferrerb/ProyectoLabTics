function matrix = vector2packet(vector,l_paquete)
%N numero de paquetes
%l_paquetes es el largo maximo de los paquetes
l = size(vector);
l = l(2);
N = floor(l / l_paquete);
resto=l_paquete;
if (N*l_paquete<l)
    resto=l-N*l_paquete;
    N = N+1;
end
vector=[vector zeros(1,l_paquete)];

matrix=[];
aux_ini=1;
for i=1:N
    if i==N
        matrix(i,:)= [i resto vector(aux_ini: aux_ini+l_paquete-1)];
    else 
        matrix(i,:)= [i l_paquete vector(aux_ini: aux_ini+l_paquete-1)]; %%CABECERA  INDICE DE PAQUETE y payload
        aux_ini=aux_ini+l_paquete;
    end
end
end