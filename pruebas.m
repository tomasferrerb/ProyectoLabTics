% a=[1 2 3];
% b=vector2bits(a);
% c=sendAudio(b);a
Settings;
imgR= imread(img);
[row,col,prof] = size(imgR);
vector= img2vector(imgR);
packet = vector2packet(vector, Npaquetes);
vector2 = packet2vector(packet);
b = vector2img(vector2,row,col);
imshow(uint8(b));
%imshowimshow(imread('pin.png'img));