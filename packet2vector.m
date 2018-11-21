function [vector row col] = packet2vector(matrix)

vector = [];
N=size(matrix);
N=N(1);
for n=1:N
    aux=matrix(n,:);
    vector=[vector aux(5:end)];
    
end
row=aux(3);
col=aux(4);
end