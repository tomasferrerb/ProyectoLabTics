function vector = RXsocket(ipT,ipR, portT, portR)

    udpR = udp(ipT,portT,'LocalPort',portR);
    udpR.InputBufferSize = 1000;

    %%Connect to UDP Object
    fopen(udpR);
    % fclose(udpB)