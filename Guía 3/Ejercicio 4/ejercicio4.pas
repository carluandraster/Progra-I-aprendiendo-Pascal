{ Ingresar N números enteros (ordenados en forma descendente), informar cual es la máxima
diferencia entre dos números consecutivos y qué posición ocupa ese par de números dentro de
la secuencia.}

Program ejercicio4;

var
    N,i,posicion:byte;
    num,anterior,diferencia,diferenciaMaxima:integer;

begin
    // Inicializar variables
        diferenciaMaxima:=-1;

    // Preguntar y validar por N
        repeat
            writeLn('Cuantos numeros va a ingresar? (Minimo: 2)');
            readLn(N);
        until N>=2;
         
    // Ciclo for
        for i:=1 to N do
            begin
                if i<>1 then
                    begin
                        // Preguntar y validar numero
                            repeat
                                writeLn('Ingrese un numero entero. RESPETAR ORDEN DESCENDENTE');
                                readLn(num);
                            until num<anterior;
                        
                        // Sacar diferencia con el anterior
                            diferencia:=anterior-num;
                        
                        // Es la mayor diferencia?
                            if diferencia>diferenciaMaxima then
                                begin
                                  diferenciaMaxima:=diferencia;
                                  posicion:=i-1;
                                end;
                    end
                else {Primera iteración}
                    begin
                        writeLn('Ingrese un numero entero. RESPETAR ORDEN DESCENDENTE');
                        readLn(num);
                    end;

                // Actualizar numero anterior
                    anterior:=num;
            end;
    
    // Salida de datos
        writeLn('La maxima diferencia entre dos numeros consecutivos fue de ',diferenciaMaxima,' y se da en el par ',posicion);
end.