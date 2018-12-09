clc
clear
settings;

signal=[];

%% Parametros imagen

imgR = imread(img);
info=size(imgR);
alto=info(1);
ancho=info(2);
canales=info(3);

%% Header

th=0:ts:Th; %muestras de tiempo de header

h1=sin(2*pi*H1*th);
h2=sin(2*pi*H2*th);
h3=sin(2*pi*H3*th);
h=[h1 h2 h3];

signal=[signal h];

%% Codificacion de dimension de la imagen
tim = 0:ts:Tim;
header = sin(2*pi*(size1+ancho*5)*tim)+ sin(2*pi*(size2+alto*5)*tim);
signal = [signal, header];

%% Codificacion

t=0:ts:T; %muestras de tiempo de simbolo

R=uint16(reshape(imgR(:,:,1),alto*ancho,1));
G=uint16(reshape(imgR(:,:,2),alto*ancho,1));
B=uint16(reshape(imgR(:,:,3),alto*ancho,1));
r1=zeros(1,length(R));
r2=r1;
disp('Calculando redundancia')
for i=1:length(R)
    px=[R(i) G(i) B(i)];
    px_gf=gf(px,8);
    rs=5;
    px_code=rsenc(px_gf,rs,3);
    px_code_decimal = px_code.x;
    r1(i)=px_code_decimal(4);
    r2(i)=px_code_decimal(5);
end
disp('Construyendo mensaje')    
for i=1:1:length(R)
    Frecuencias=[R(i)*df+fbaseR, G(i)*df+fbaseG, B(i)*df+fbaseB];
    Frecuencias=double(Frecuencias);
    signal=[signal sin(2*pi*Frecuencias(1).*t)+sin(2*pi*Frecuencias(2).*t)+sin(2*pi*Frecuencias(3).*t)];
end

for i=1:1:length(R)
    Frecuencias=[r1(i)*df+fbaseR, r2(i)*df+fbaseG];
    Frecuencias=double(Frecuencias);
    signal=[signal sin(2*pi*Frecuencias(1).*t)+sin(2*pi*Frecuencias(2).*t)];
end


%% Transmisión
disp('Ready for Transmission. Press Any Key to Continue...')
pause
audiowrite('audiomario.wav',signal,fs);
%soundsc(signal,fs) 
