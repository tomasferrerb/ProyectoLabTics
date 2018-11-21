%Sonido a enviar
function transmision(data,Fi,Df,Fs,Dt)
s=FSK(data,Fi,Df,Fs,Dt);
sound(s,Fs)
end