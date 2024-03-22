{Cad2='d  '; Cad3='abc'; a=111; x=80.0}

Program ejercicio12b;

var
    T:text;
    Cad1: string[8];
    Cad2, Cad3 : string[3];
    a,b : word;
    x: real; 
    c: char;

    //Variable de control
        i:byte;

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
                        1: readLn(T,Cad3,Cad2);
                        2: readLn(T,x);
                        3: readLn(T,a);
                    end;
                i:=i+1;
            end;
    
    // Prueba
        writeLn('Cad2: ',Cad2);
        writeLn('Cad3: ',Cad3);
        writeLn('a: ',a);
        writeLn('x: ',x:4:1);
end.