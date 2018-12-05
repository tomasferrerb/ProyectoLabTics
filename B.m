Settings;

matriz=[];

Settings; 
%%Create UDP Object
udpB = udp(ipA,portA,'LocalPort',portB);
udpB.InputBufferSize = 10000000;
%%Connect to UDP Object
fopen(udpB);
pause; 
tic
rx = fread(udpB, 255 , 'uint8').';
Ns = rx(1);
N = rx(1);
rows = rx(3);
cols = rx(4);


%Recibir paquetes y ordenar en matriz
count=1;
while count < N
    new = fread(udpB,255,'uint8').';
    N = new(1);
    row = new(3);
    col = new(4);
    Ns = cat(2,Ns,N);
    rows = cat(2,rows,row);
    cols = cat(2,cols,col);
    rx = cat(1, rx, new);
    N = mode(Ns);
    row = mode(rows);
    col = mode(cols);
    count = new(2);
end
fclose(udpB);
disp('Tiempo de transmisión')
toc

[vector row col] = packet2vector(rx);
image = vector2img(vector, row, col);

imshow(uint8(image)); 