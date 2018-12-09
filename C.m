Settings;


%%Abrir imagen para comparar errores 
imgOriginal = imread(img);
[rowC,colC,profC] = size(imgOriginal);
vectorOriginal =img2vector(imgOriginal);
matrizOriginal = vector2packet(vectorOriginal, l_paquete);
paquetes_erroneos=0; 


matriz=[];

%Recibir paquetes 
%Configurar puertos

udpC = udp(ipA,portA,'LocalPort',portC);
udpC.InputBufferSize = 1000000;
fopen(udpC);


%Recibir paquetes y ordenar en matriz
count=1;
total_datos=0;
tiempo_final=0;
while 1
    vec=fread(udpC,250,'uint8');
    if vec(1)==0%PRIMER PAQUETE
        tic;
        row=vec(2);
        col=vec(3);
        N=vec(4);
    elseif ~(vec(1)== N)    
        matriz(vec(1),:)=vec;
        if ~(matrizOriginal(vec(1),:)==vec)
            paquetes_erroneos=paquetes_erroneos+1;
        end
        count=count+1;
        total_datos=total_datos+vec(2);
    else
        tiempo_final=toc;
        break
    end
end
fclose(udpC);

%%
delay=tiempo_final;
disp(['Delay = ' num2str(delay) '[s]'])
goodput=8*total_datos/tiempo_final;
disp(['Goodput = ' num2str(goodput/1000) '[kbps]'])
PER=paquetes_erroneos/(N-1);
disp(['PER = ' num2str(PER)])


vector  = packet2vector(matriz);
image = vector2img(vector, row, col);
BER=row*col*3-sum(sum(sum(imgOriginal==image)));
disp(['BER = ' num2str(BER)])
imshow(uint8(image)); 