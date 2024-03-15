// Dadas tres letras mostrarlas ordenadas en forma ascendente con Alternativas anidadas con expresiones lógicas simples

Program ejercicio6c;

var
    letra1,letra2,letra3:char;

begin
    // Entrada de letras
        writeLn('Ingrese 3 letras');
        readLn(letra1);
        readLn(letra2);
        readLn(letra3);

    // Escribir las letras en orden alfabético
        if letra1<letra2 then
            if letra2<letra3 then {Primera combinación: letra1-letra2-letra3}
                writeLn('El orden alfabetico de las letras ingresadas son ',letra1,', ',letra2,' y ',letra3)
            else {Quinta combinación: letra3-letra1-letra2}
                writeLn('El orden alfabetico de las letras ingresadas son ',letra3,', ',letra1,' y ',letra2)
        else
            if letra1<letra3 then
                if letra3<letra2 then {Segunda combinación: letra1-letra3-letra2}
                    writeLn('El orden alfabetico de las letras ingresadas son ',letra1,', ',letra3,' y ',letra2)
                else {Tercera combinación: letra2-letra1-letra3}
                     writeLn('El orden alfabetico de las letras ingresadas son ',letra2,', ',letra1,' y ',letra3)
            else
                if letra3<letra1 then
                    if letra2<letra3 then {Cuarta combinación: letra2-letra3-letra1}
                        writeLn('El orden alfabetico de las letras ingresadas son ',letra2,', ',letra3,' y ',letra1)
                    else {Sexta y última combinación: letra3-letra2-letra1}
                        writeLn('El orden alfabetico de las letras ingresadas son ',letra3,', ',letra2,' y ',letra1);
end.