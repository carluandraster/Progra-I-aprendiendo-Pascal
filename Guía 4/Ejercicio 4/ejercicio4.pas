{Desarrollar una función que calcule la potencia n-ésima de un número X}

Program ejercicio4;

function potencia(x:real;n:byte):extended;
    var
        i:byte;
        productoria:extended;
    begin
        // Inicializar variables
            productoria:=1;
        
        // Calcular potencia
        for i:=1 to n do
          begin
            productoria:=productoria*x;
          end;
        
        // Retornar la productoria total
            potencia:=productoria;
    end;

var
    x:real;
    n:byte;
    potenciaEnesima:extended;

begin
    // Ingresar datos por teclados
        write('Ingrese base de potencia: ');
        read(x);

        write('Ingrese exponente: ');
        read(n);
    
    // Calcular potencia y mostrar
        potenciaEnesima:=potencia(x,n);
        if potenciaEnesima<potencia(10,8) then
            writeLn(x:8:2,' elevado a ',n,' es: ',potenciaEnesima:8:2)
        else
            writeLn(x:8:2,' elevado a ',n,' es: ',potenciaEnesima); {Mostrar con notación científica}
end.