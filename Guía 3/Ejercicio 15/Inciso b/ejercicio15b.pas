{A partir de un archivo de texto que contiene una secuencia de caracteres terminada en punto,
desarrollar un programa que diga cuántas palabras contienen una letra que ingresa por teclado}

Program ejercicio15b;

var
    // Variables de entrada
        letra:char;
        archivo:text;
    
    // Variables de proceso
        car:char;
        contiene:boolean;

    // Varieble de salida
        contador:byte;

begin
    // Inicializar variables
        contador:=0;
    
    // Archivo de texto
        assign(archivo,'../texto.txt');
        reset(archivo);
    
    // Entrada de datos
        // Preguntar y validar letra
            repeat
              writeLn('Ingrese una letra:');
              readLn(letra);
              letra:=upcase(letra);
            until (letra>='A') and (letra<='Z');
    
    // Leer el primer carácter del archivo
        read(archivo, car);

    // Leer el archivo hasta encontrar el punto final
        while car <> '.' do
            begin
                contiene := false;

                // Leer una palabra del archivo
                    while (car <> ' ') and (car <> '.') do
                        begin
                            car := upcase(car);
                            if car = letra then
                                contiene := true;
                            read(archivo, car); // Leer el siguiente carácter
                        end;
                // Si la palabra contiene la letra buscada, aumentar el contador
                    if contiene then
                        contador := contador + 1;

                // Leer el siguiente carácter después de un espacio en blanco
                    if car = ' ' then
                        read(archivo, car);
             end;

    // Cerrar archivo 
        close(archivo);

    // Salida de datos
        writeLn('En el archivo hay ',contador,' palabras que contienen la letra ',letra);  
end. 