% Define computer-specific variables
% Modify these values to be those of your first computer:
ipA = '192.168.100.24';   portA = 9090;   
% Modify these values to be those of your second computer:
ipB = '192.168.100.22';  portB = 9091;  
%%Create UDP Object

udpB = udp(ipA,portA,'LocalPort',portB);
udpB.InputBufferSize = 1000;

%%Connect to UDP Object
fopen(udpB);
% fclose(udpB)