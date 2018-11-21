function image = matrix2img(matrix)
Settings;
vR=[];
vG=[];
vB=[]; 
[row col prof] = size(matrix);
rowI=matrix(3,1,4);
colI=matrix(4,1,4);

for j=1:col
    vR=[vR matrix(:, j, 1)];
    vG=[vG matrix(:, j, 2)];
    vB=[vB matrix(:, j, 3)];
end

mR=reshape(vR,[rowI,colI]);
mG=reshape(vG,[rowI,colI]);
mB=reshape(vB,[rowI,colI]);

image=[mR mG mB];
end