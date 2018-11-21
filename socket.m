%%Define computer-specific variables
ipA = '192.168.100.24';   portA = 9090;   % Modify these values to be those of your first computer.
ipB = '192.168.100.22';  portB = 9091;  % Modify these values to be those of your second computer.
%%Create UDP Object
udpA = udp(ipB,portB,'LocalPort',portA);
%%Connect to UDP Object
fopen(udpA)

% fprintf(udpA,'This is test message number one.')
% fprintf(udpA,'This is test message number two.')
% fprintf(udpA,'doremifasolatido')

fwrite(udpA, 1:250 , 'int32')
udpA.OutputBufferSize = 1000
