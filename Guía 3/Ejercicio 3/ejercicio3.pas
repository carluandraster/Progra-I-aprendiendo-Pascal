{Ingresar N números enteros, informar cuántas veces un número supera al anterior.}

Program ejercicio3;

var
    N,contador,i:byte;
    num,anterior:integer;

begin
    // Inicializacion de variables
        contador:=0;
        anterior:=32767;

    // Preguntar por N
        writeLn('Cuantos numeros va a ingresar?');
        readLn(N);
    
    // Ciclo for
        for i:=1 to N do
          begin
            // Preguntar número
                writeLn('Ingrese un numero entero');
                readLn(num);
            
            // Supera el anterior?
                if num>anterior then
                  contador:=contador+1;
            
            // Actualizar numero anterior para la siguiente iteración
                anterior:=num;
          end;
    
    // Salida de datos
        writeLn('Fueron ',contador,' las veces que un numero supero al anterior');
end.