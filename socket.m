function socket(ipT,ipR, portT, portR, vector)
%%Define computer-specific variables
    %%Create UDP Object
    udpT = udp(ipR,portR,'LocalPort',portT);
    %%Connect to UDP Object
    fopen(udpT)

    % fprintf(udpA,'This is test message number one.')
    % fprintf(udpA,'This is test message number two.')
    % fprintf(udpA,'doremifasolatido')

    fwrite(udpT, vector , 'int32')
    udpT.OutputBufferSize = 1000
