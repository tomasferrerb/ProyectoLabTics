% a=[1 2 3];
% b=vector2bits(a);
% c=sendAudio(b);a
Settings;
imgR= imread(img);
[row,col,prof] = size(imgR);
a= img2vector(imgR);
b = vector2img(a,row,col);
imshow(uint8(b));
%imshowimshow(imread('pin.png'img));