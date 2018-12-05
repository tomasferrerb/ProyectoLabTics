
Settings;
imgR= imread('ball.png');
[row,col,prof] = size(imgR);
vector= img2vector(imgR);
packet = vector2packet(vector,l_paquete);

%%%AQUI SE ENVIAN 

vector2 = packet2vector(packet);
b = vector2img(vector2,row,col);%ROW COL LLEGAN EN PRIMER PAQUETE
imshow(uint8(b));
%imshowimshow(imread('pin.png'img));
