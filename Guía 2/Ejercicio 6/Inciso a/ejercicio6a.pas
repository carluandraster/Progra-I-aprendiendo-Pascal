// Dadas tres letras mostrarlas ordenadas en forma ascendente con Alternativas secuenciales

Program ejercicio6a;

var
    letra1,letra2,letra3,auxiliar:char;

begin
    // Entrada de letras
        writeLn('Ingrese 3 letras');
        readLn(letra1);
        readLn(letra2);
        readLn(letra3);

    // Ordenar las letras en orden alfabético
        // Si letra1 va después de letra2, las intercambio
        if letra1>letra2 then
          begin
            auxiliar:=letra2;
            letra2:=letra1;
            letra1:=auxiliar;
          end;

        // Si letra2 va después de letra 3, las intercambio
        if letra2>letra3 then
            begin
                auxiliar:=letra3;
                letra3:=letra2;
                letra2:=auxiliar;
                // Si letra1 va después del nuevo letra2, las intercambio
                    if letra1>letra2 then
                        begin
                            auxiliar:=letra2;
                            letra2:=letra1;
                            letra1:=auxiliar;
                        end;
            end;
        
       //Salida
       writeLn('El orden alfabetico de las letras ingresadas son ',letra1,', ',letra2,' y ',letra3);
end.