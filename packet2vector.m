function vector = packet2vector(matrix)

vector = [];
N=size(matrix);
N=N(1); %numero de filas o paquetes
payload=0;
for n=1:N
    aux=matrix(n,:);
    vector=[vector aux(3:end)];
    payload=payload+aux(2);
end
end