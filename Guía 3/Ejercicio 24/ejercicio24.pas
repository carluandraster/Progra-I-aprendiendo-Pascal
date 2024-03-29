{En un archivo se han grabado palabras, separadas por uno o más blancos en una misma línea,
finalizando con un punto. Cada palabra está conformada por letras y dígitos (3ab4c3Hd).
Se pide, a partir del archivo descripto generar otro cambiando las parejas “LetraminusculaDigito” por las
repeticiones de la Letra según indique el digito. }

Program ejercicio24;

var
    anterior,caracter:char;
    i,num:byte;
    archivoE,archivoS:text;

begin
    // Inicializar variables
        anterior:=' ';

    // Archivos txt
        assign(archivoE,'entrada.txt');
        assign(archivoS,'salida.txt');
        reset(archivoE);
        rewrite(archivoS);
    
    // Lectura del archivo de entrada
        while not eof(archivoE) do
          begin
            read(archivoE,caracter);
            if (anterior in ['a'..'z']) and (caracter in ['0'..'9']) then
                begin
                  val(caracter,num);
                  for i:=1 to num do
                    write(archivoS,anterior);
                  read(archivoE,caracter);
                end
            else
                write(archivoS,anterior);
            anterior:=caracter;
          end;
    
    // Cerrar archivos
        close(archivoE);
        close(archivoS);
end.