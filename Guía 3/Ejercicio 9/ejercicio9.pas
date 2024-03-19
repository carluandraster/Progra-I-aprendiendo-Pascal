{Dado un conjunto de números leídos desde un archivo, informar si están ordenados en forma
ascendente.}

Program ejercicio9;

var
    archivo:text;
    numero,anterior:real;

begin
    // Almacenar archivo a una variable y prepararlo para la lectura
        assign(archivo,'numeros.txt');
        reset(archivo);
    
    // Inicializar variables
        anterior:=-32768;
        numero:=-32768;
    
    // Leer archivos
        while not (eof(archivo)) and (numero=anterior) do
            begin
              read(archivo,numero);
              if numero>=anterior then
                anterior:=numero;
            end;
    
    // Analizar si existe un número que sea menor que el anterior
        if numero<anterior then
            writeLn('Los numeros no estan ordenados en forma ascendente')
        else
            writeLn('Los numeros estan ordenados en forma ascendente');
end.