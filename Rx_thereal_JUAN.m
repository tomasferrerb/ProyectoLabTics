close all
clear
clc

%% info imagen
settings;

%% Grabacion
tgra=110; %tiempo de grabacion
tg=0:ts:tgra-ts;   %muestras de toda la grabacion

disp('Press any key to begin reception')
pause
disp('Receiving...')

tf = 90; % duracion de la grabacion (segs)

if exist(fullfile(cd, 'recording.wav'), 'file')
    signal = audioread('recording.wav', [1,tf*fs]);
else
    recorder = audiorecorder(fs, 16, 1);
    recordblocking(recorder, tf);
    signal = recorder.getaudiodata;
    audiowrite('recording.wav', signal, fs);
end
disp('Reception complete')

%% Header

th=0:ts:Th; %muestras de tiempo de header

h1=sin(2*pi*H1*th);
h2=sin(2*pi*H2*th);
h3=sin(2*pi*H3*th);
h=[h1 h2 h3];

%% Sincronizacion (busqueda de inicio)
disp('Buscando inicio')
tiempo_obs=3; %segundos desde el inicio de la grabacon donde se buscara el header
intbusqueda = signal(1:tiempo_obs*fs);   %intervalo de tiempo donde se buscara el header
[corr, lag] = xcorr(intbusqueda, h);  %correlacion
[maxc, indice] = max(abs(corr));    %encontrar indice de max de correlacion
ini = lag(indice); %encontrar indice de inicio

Tini = abs(ini)+length(h); %tiempo de inicio de informacion
%luego se corta la señal para dejar solo la informacion

%% Decodificacion dimension imagen
frames_dim = Tim * fs;  % frames que dura la info de la dimension
body = signal(Tini:Tini + frames_dim -1); % info dimension
Z = fft(body);
Z1 = Z(1:(frames_dim/2)+1);
Z1(2:end-1) = 2*Z1(2:end-1);
Z1 = abs(Z1);
Z12 = abs(Z1);
F_ = fs*(0:(frames_dim/2))/frames_dim;
index = (size1+500 > F_) & (F_ >= size1-500); % indices filtrado
F_ = F_(index);
Z1 = Z1(index); % filtrado ;)
[~,f_i] = max(Z1);
F_(f_i);  % encuentra el tono

F_2 = fs*(0:(frames_dim/2))/frames_dim;
index2 = (size2+500> F_2) & (F_2 >= size2-500); % indices filtrado
F_2 = F_2(index2);
Z12 = Z12(index2); % filtrado ;)
[~,f_i2] = max(Z12);

alto = round((F_(f_i)-size1)/5);
ancho = round((F_2(f_i2)-size2)/5);
len=num2str(alto);
an=num2str(ancho);
pal=['dimensiones ' len 'x' an];
disp(pal);

i_time = Tini + length(body);

datos=signal(i_time:end);
%% Decodificacion
%matrices R,G,B a llenar con los valores
R=zeros(1, alto*ancho);
G=R;
B=G;
r1=R;
r2=R;

t=0:ts:T;
L=length(t);
f_val = fs*(0:L/2)/L; %intervalo para realizar fft

% frecuencias de cada canal 
iR=( (fbaseG-10>f_val) & f_val>(fbaseR-10) );
iG=( (fbaseB-10>f_val) & f_val>(fbaseG-10) );
iB=( (15600>f_val) & f_val>(fbaseB-10) );

Rf = f_val(iR);
Gf = f_val(iG);
Bf = f_val(iB);
disp('Calculando matrices :D')
for i = 1:(alto*ancho)
        muestra = datos((i-1)*L+1:i*L);
        ventana = hamming(L);
        muestra = muestra.*ventana;
        Y = fft(muestra); 
        Y1 = Y(1:round(L/2) + 1);        
        Y1 = abs(Y1);
        
        Y1r = Y1(iR);
        Y1r = abs(Y1r); 
        [frecr, indr] = max (Y1r); 
        R(i) = round((Rf(indr)-fbaseR)/df); 
        
        Y1g= Y1(iG);
        Y1g = abs(Y1g); 
        [frecg,indg] = max (Y1g); 
        G(i) = round((Gf(indg)-fbaseG)/df); 
        
        Y1b= Y1(iB); 
        Y1b = abs(Y1b); 
        [frecb,indb] = max (Y1b);
        B(i) = round((Bf(indb)-fbaseB)/df); 
end

for i = (alto*ancho)+1:2*(alto*ancho)
        muestra = datos((i-1)*L+1:i*L);
        ventana = hamming(L);
        muestra = muestra.*ventana;
        Y = fft(muestra); 
        Y1 = Y(1:round(L/2) + 1);        
        Y1 = abs(Y1);
        
        Y1r = Y1(iR);
        Y1r = abs(Y1r); 
        [frecr, indr] = max (Y1r); 
        r1(i-alto*ancho) = round((Rf(indr)-fbaseR)/df); 
        
        Y1g= Y1(iG);
        Y1g = abs(Y1g); 
        [frecg,indg] = max (Y1g); 
        r2(i-alto*ancho) = round((Gf(indg)-fbaseG)/df); 
end    

%% Correcion de errores
rojo_rs=zeros(1, alto*ancho);
verde_rs=zeros(1, alto*ancho);
azul_rs=zeros(1, alto*ancho);
for i = 1:(alto*ancho)
    px_Rx=[R(i) G(i) B(i) r1(i) r2(i)];
    px_code=gf(px_Rx,8);
    px_decode = rsdec(px_code,5,3);
    px=px_decode.x;
    rojo_rs(i)=px(1);
    verde_rs(i)=px(2);
    azul_rs(i)=px(3);
end

%% Recuperacion de imagen
red8 = uint8(reshape(R, ancho, alto)); % Matriz con valores de rojo
green8 = uint8(reshape(G, ancho, alto)); % Matriz con valores de verde
blue8 = uint8(reshape(B, ancho, alto)); % Matriz con valores de azul
imgrec = cat(3,red8,green8,blue8); % Imagen reconstruida

red8_rs = uint8(reshape(rojo_rs, ancho, alto)); % Matriz con valores de rojo
green8_rs = uint8(reshape(verde_rs, ancho, alto)); % Matriz con valores de verde
blue8_rs = uint8(reshape(azul_rs, ancho, alto)); % Matriz con valores de azul
imgrec_rs = cat(3,red8_rs,green8_rs,blue8_rs); % Imagen reconstruida

true_img = imread(img);

figure (1)
subplot(1,3,1)
imshow(imgrec)
xlabel('Recibida sin corregir')
subplot(1,3,2)
imshow(imgrec_rs)
xlabel('Recibida corregida')
subplot(1,3,3)
imshow(true_img)
xlabel('Original')





