{Leer un conjunto de números enteros, la presencia de ceros intermedios indica fin de un
subconjunto y comienzo del siguiente, dos ceros consecutivos es fin de datos. Se pide calcular e informar
el máximo en cada subconjunto y el orden del subconjunto más numeroso}

Program ejercicio21;

var
    num,max,anterior:integer;
    cantidad,cantidadMaxima,orden,ordenNumeroso:byte;

begin
    // Inicializar variables
        max:=-32768;
        anterior:=1;
        cantidad:=0;
        cantidadMaxima:=0;
        orden:=1;
    
    // Ingresar por teclado los numeros enteros
        writeLn('Ingrese un numero: ');
        readLn(num);
        repeat
          cantidad:=cantidad+1;
          if num>max then
            max:=num;
          if (num=0) and (anterior<>0) then
            begin
              writeLn('Maximo: ',max);
              if cantidad>cantidadMaxima then
                begin
                  cantidadMaxima:=cantidad;
                  ordenNumeroso:=orden;
                end;
              max:=-32768;
              orden:=orden+1;
              cantidad:=0;
            end;
              anterior:=num;
              writeLn('Ingrese un numero: ');
              readLn(num);
            
        until (num=0) and (anterior=0);
    
    // Salida de datos
        writeLn('El subconjunto con mas elementos es: ',ordenNumeroso);
end.