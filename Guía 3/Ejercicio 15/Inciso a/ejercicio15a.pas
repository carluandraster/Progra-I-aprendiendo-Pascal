{A partir de un archivo de texto que contiene una secuencia de caracteres terminada en
punto, desarrollar un programa que diga cuántas palabras comienzan con una letra que
ingresa por teclado. }

Program ejercicio15a;

var
    // Variables de entrada
        letra:char;
    
    // Variables de proceso
        archivo:text;
        car1,car2:char;

    // Variables de salida
        contador:byte;

begin
    // Inicializar variables
        car1:=' ';
        car2:='a';
        contador:=0;
    
    // Archivo txt
        assign(archivo,'../texto.txt');
        reset(archivo);
    
    // Preguntar y validar caracter
        repeat
          writeLn('Ingrese una letra');
          readLn(letra);
          letra:=upcase(letra);
        until (letra>='A') and (letra<='Z');
    
    // Leer archivo
        while car2<>'.' do
            begin
                read(archivo,Car2);
                Car2:=upcase(Car2);
                if (car1=' ') and (car2=letra) then
                    contador:=contador+1;
                Car1:=Car2;
            end;
            
    
    // Cerrar archivo
        close(archivo);
    
    // Salida de datos
        writeLn('En el archivo hay ',contador,' palabras que empiezan con la letra ',letra);
end.