{Cad1='  80 xzy'; x=111.0}

Program ejercicio12d;

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
                        1: readLn(T);
                        2: readLn(T,Cad1);
                        3: readLn(T,x);
                    end;
                i:=i+1;
            end;
    
    // Prueba
        writeLn('Cad1: ',Cad1);
        writeLn('x: ',x:5:1);
end.