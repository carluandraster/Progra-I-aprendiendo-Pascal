// Dadas tres letras mostrarlas ordenadas en forma ascendente con Alternativas anidadas con expresiones lógicas compuestas

Program ejercicio6b;

var
    letra1,letra2,letra3:char;

begin
    // Entrada de letras
        writeLn('Ingrese 3 letras');
        readLn(letra1);
        readLn(letra2);
        readLn(letra3);

    // Escribir las letras en orden alfabético (total de combinaciones posibles: 3!=6)
        if (letra1<letra2) and (letra2<letra3) then {Primera combinación: letra1-letra2-letra3}
            writeLn('El orden alfabetico de las letras ingresadas son ',letra1,', ',letra2,' y ',letra3)
        else
            if (letra1<letra3) and (letra3<letra2) then {Segunda combinación: letra1-letra3-letra2}
               writeLn('El orden alfabetico de las letras ingresadas son ',letra1,', ',letra3,' y ',letra2)
            else
                if (letra2<letra1) and (letra1<letra3) then {Tercera combinación: letra2-letra1-letra3}
                    writeLn('El orden alfabetico de las letras ingresadas son ',letra2,', ',letra1,' y ',letra3)
                else
                    if (letra2<letra3) and (letra3<letra1) then {Cuarta combinación: letra2-letra3-letra1}
                        writeLn('El orden alfabetico de las letras ingresadas son ',letra2,', ',letra3,' y ',letra1)
                    else
                        if (letra3<letra1) and (letra1<letra2) then {Quinta combinación: letra3-letra1-letra2}
                            writeLn('El orden alfabetico de las letras ingresadas son ',letra3,', ',letra1,' y ',letra2)
                        else {Sexta y última combinación: letra3-letra2-letra1}
                            writeLn('El orden alfabetico de las letras ingresadas son ',letra3,', ',letra2,' y ',letra1);
end.