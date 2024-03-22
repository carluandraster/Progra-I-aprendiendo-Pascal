{Reescríbalo reemplazando la estructura Repeat, los dos If y la variable booleana Bool por
una estructura While. }

Program ejercicio14b;

var
    Sum,x:byte;

begin
    // Inicializar variables
        Sum:=0;
    
    // Leer del teclado x
        Readln( x );
    
    // x es distinto de 0?
    while (x<>0) and (sum<=100) do
        begin
            // Acumular en la suma x
                Sum := Sum + x;
            
            // Volver a leer del teclado x
                Readln( x );
        end;
            
    
    // Salida de datos
        Writeln('Resultado: ', Sum ); 
end.