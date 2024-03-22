{Analice y explique brevemente qué realiza el siguiente fragmento de código}

Program ejercicio14a;

var
    Bool:boolean;
    Sum,x:byte;

begin
    // Inicializar variables
        Bool:=false ;
        Sum:=0;
    
    // Leer del teclado x
        Readln( x );
    
    // x es distinto de 0?
    If x <>0 then
        Repeat
            // Acumular en la suma x
                Sum := Sum + x;
            
            // Si la suma supera 100, cortar
                If Sum > 100 then
                    Bool :=true;
            
            // Volver a leer del teclado x
                Readln( x );
        Until ( x=0) or Bool;
    
    // Salida de datos
        Writeln('Resultado: ', Sum ); 
end.

{Lo que hace el codigo es sumar numeros ingresados por teclado hasta que la suma supere 100
o se ingrese un 0}

{Lote1 : 0 Resultado: 0
Lote2 : 70, 40, 20 Resultado: 110
Lote3 : 70 , 0 Resultado: 70}