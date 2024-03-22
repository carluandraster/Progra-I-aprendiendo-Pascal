{A partir de un archivo de texto que contiene una secuencia de caracteres terminada en
punto, desarrollar un programa que diga cuántas palabras comienzan con una letra que
ingresa por teclado. }

Program ejercicio15a;

var
    // Variables de entrada
        car:char;
    
    // Variables de proceso
        archivo:text;
        car1,car2:char;

    // Variables de salida
        contador:byte;

begin
    // Inicializar variables
        car1:=' ';
    
    // Archivo txt
        assign(archivo,'../texto.txt');
        reset(archivo);
    
    // Preguntar y validar caracter
        repeat
          writeLn('Ingrese una letra');
          readLn(letra);
          letra:=upcase(letra);
        until letra in [A..Z]
        
end.