{ Cad1     Cad2  Cad3 a  b  x    c
´bbbbb111´ ´abc´. -   80 - 45.9 ´d´ }

Program ejercicio12a;

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
        espacio1,espacio2:string[2];

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
                        1: readLn(T,Cad2,c,espacio1,x);
                        2: readLn(T,espacio2,a);
                        3: readLn(T,Cad1);
                    end;
                i:=i+1;
            end;
    
    // Prueba
        writeLn('Cad1: ',Cad1);
        writeLn('Cad2: ',Cad2);
        writeLn('a: ',a);
        writeLn('x: ',x:4:1);
        writeLn('c: ',c);
end.