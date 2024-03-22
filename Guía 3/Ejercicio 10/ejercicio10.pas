{ Leer desde un archivo números enteros ordenados de menor a mayor, puede haber elementos
repetidos.
Calcular y mostrar cada número con su respectiva frecuencia. }

Program ejercicio10;

var
    numero,anterior:integer;
    archivo:text;
    frecuencia,i:byte;

begin
    // Archivo txt
        assign(archivo,'numeros.txt');
        reset(archivo);
    
    // Inicializar variable de control
        i:=1;
    
    // Leer archivo
        while not eof(archivo) do
            begin
                // Leer de archivo el numero
                    read(archivo,numero);

                // Contar cuántas veces se presenta un mismo número
                    if numero=anterior then
                        frecuencia:=frecuencia+1
                    else
                        begin
                            if i <> 1 then
                                writeLn('El numero ',anterior,' tuvo una frecuencia de ',frecuencia,' veces.');
                            frecuencia:=1;
                    end;
                // Actualizar variables
                    anterior:=numero;
                    i:=i+1;
            end;
    // Ultimo numero
        writeLn('El numero ',anterior,' tuvo una frecuencia de ',frecuencia,' veces.');
end.