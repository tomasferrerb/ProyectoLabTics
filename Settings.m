fs=40e3; % sampleo
Npaquetes=16;
header_f = 0.3; % delta tiempo de duracion del header 
info_size_f = 0.15; % delta tiempo por pixel 
info_pixel_f = 0.175; % 0.35
Rf = 4000; %fbase del rojo
Gf = 8000; %fbase del verde
Bf = 12000;% fbase del azul
Tf = 14000; % fbase del texto
header1=2000;% las tres frecs del header 
header2=1500;
header3=1000;
ancho=3000;
alto=1500;
len= 500;
delta=200;
dif = 100; % diferencia entre cada valor del pixel 
img='pin.png';
p2f = @(px, b, d) px*d + b;
f2p = @(f, bf, d) round((f-bf)/d);
ttl1 = 3100;
ttl2 = 3400;
ttl3 = 3700;
ttl4 = 4100;
s1=4250;
s2=4500;
s3=4750;
s4=5000;

ipA=
ipB=
ipC=
portA=
portB=
portC=