
Settings;
imgR= imread('ball.png');
[row,col,prof] = size(imgR);
vector= img2vector(imgR);
packet = vector2packet(vector, Npaquetes,row,col);

%%%AQUI SE ENVIAN 

[vector2 row1 col1]= packet2vector(packet);
b = vector2img(vector2,row1,col1);
imshow(uint8(b));
%imshowimshow(imread('pin.png'img));
