function matrix = vector2packet(vector, N, row, col)
lenvector=size(vector);
lenvector=lenvector(2); 

lenpacket= lenvector/N %usar n de paquetes divisores de 16*16*3

matrix=[];

for i=1:N
    matrix(i,:)= [N i row col vector((lenpacket*(i-1)+1): lenpacket*i)]; %%CABECERA CON NUMERO DE PAQUETES E INDICEDE PAQUETE
end
end