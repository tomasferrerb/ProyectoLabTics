function vector = packet2vector(matrix)

vector = [];
N=size(matrix);
N=N(1);
for n=1:N
    aux=matrix(n,:);
    vector=[vector aux(3:end)];
end
end