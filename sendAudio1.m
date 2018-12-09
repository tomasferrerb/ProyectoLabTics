
function senal = sendAudio1(vector)%recibe vector de pixeles
%envia vectores utilizando un canal
Settings;
pixel_dt = 0:1/fs:info_pixel_f; % aca, en frecs
[row prof]=size(vector);

%============================ Header del mensaje
head_dt = 0:1/fs:header_f;
header = [sin(2*pi*header1*head_dt), sin(2*pi*header2*head_dt), sin(2*pi*header3*head_dt)];
senal = header;
[row col] = size(vector); %1xn
for j=1:col
    px = vector(1,j);% sacar el pixel como un vector de doubles RGB
    px = double(px); 
    px_bi= de2bi(px,8);
%decimal a vector de binarios => vector de 24 bits
    for k=1:8
        aux(k)=Rf+double(px_bi(k))*dif+delta*(k-1); %portadoras 
        %aux(k+8)=Gf+double(px_bi(k+8))*dif+delta*(k-1); 
        %aux(k+16)=Bf+double(px_bi(k+16))*dif+delta*(k-1); 
        %aux(k+24)=Tf+double(px_bi(k+24))*dif+delta*(k-1);
     end
sampling = sin(2 * pi * aux.' * pixel_dt);
sampling = sum(sampling);
senal = [senal, sampling];%acumula espectro y fusion end
end

%============================ plot en tiempo y FFT
subplot(2,1,1)
plot(senal) %tiempo 
xlabel('tiempo (segs)') 
ylabel('Amplitud')%
subplot(2,1,2)
frames_dim = length(senal);
NFFT = 2^nextpow2(frames_dim);
Y = fft(senal, NFFT)/frames_dim; 
f = fs/2*linspace(0,1,NFFT/2+1); 
plot(f, 2*abs(Y(1:NFFT/2+1))); 
xlabel('Frecuencia (Hz)') 
ylabel('Amplitud')
%save('audio.mat','senal');
audiowrite('twitter.wav',senal,fs); 
disp('Send...')
%bytes1 = unicode2native(str1)
sound(senal, fs)

