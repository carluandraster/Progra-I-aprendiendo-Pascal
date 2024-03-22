{Cad1='abcd  45'; Cad2=' 80'; Cad3='.9 '; b=111; c=' '}

Program ejercicio12c;

var
    T:text;
    Cad1: string[8];
    Cad2, Cad3 : string[3];
    a,b : word;
    x: real; 
    c: char;

    //Variable de control
        i:byte;

    // Espacios
        espacio:char;
begin
    // Archivo txt
        assign(T,'../archivo.txt');
        reset(T);
    
    // Inicializar variables
        i:=1;
    
    // Lectura
        while not eof(T) do
            begin
                // Estructura selectiva
                    case i of
                        1: readLn(T,Cad1,Cad3,c,b);
                        2: readLn(T,espacio,Cad2);
                        3: readLn(T);
                    end;
                i:=i+1;
            end;
    
    // Prueba
        writeLn('Cad1: ',Cad1);
        writeLn('Cad2: ',Cad2);
        writeLn('Cad3: ',Cad3);
        writeLn('b: ',b);
        writeLn('c: ',c);
end.