function vector = img2vector(img)
[row,col,prof]=size(img);
vector=reshape(img,[1,row*col*prof]);
