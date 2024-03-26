{Leer desde archivo un conjunto de números, con elementos negativos no consecutivos que
delimitan subconjuntos. Obtener e informar el valor máximo de cada subconjunto (el máximo
entre dos negativos). }

Program ejercicio19;

var
    max,num:integer;
    archivo:text;
    i:byte;

begin
    // Inicializar variables
        i:=1;
        max:=-32768;

    // Archivo txt
        assign(archivo,'numeros.txt');
        reset(archivo);
    
    // Leer archivo
        while not eof(archivo) do
            begin
               read(archivo,num);
               if num>max then
                 max:=num;
               if num<0 then {Si hay un numero negativo, hacer un corte}
                    begin
                        if (i<>1) and (max>=0) then {Si es el primer numero negativo, hacemos una salvedad y no mostramos max}
                            writeLn(max);
                        // Reiniciar variables
                        max:=-32768;
                        i:=i+1;
                    end;
            end;
    
    // Cerrar archivo
        close(archivo);
end.