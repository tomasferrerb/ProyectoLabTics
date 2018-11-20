function vectorBits = vector2bits(vectorInt)

l=size(vectorInt);
l=l(2);
vectorBits=[];
for i=1:l
    vectorBits=[vectorBits, de2bi(vectorInt(i),8)];
 end
end
