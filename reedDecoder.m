function msg_RS_dec = reedDecoder(vector)
    [~,L_paquete] = size(vector); % Las filas no se usan (omitidas, no se guardan)
    dif_msg_red = 4; % Cu�ntos bits de control hay, n�mero par arbitrario
    redundancias = L_paquete + dif_msg_red; % Para uso en Galois field (gf(x,8))
    
    gf_vector = gf(vector,8);                             % Espacio de Galois
    msg_RS_dec = rsdec(gf_vector,redundancias,L_paquete); % Codificaci�n de Reed Solomon
    msg_RS_dec = msg_RS_dec.x;
end