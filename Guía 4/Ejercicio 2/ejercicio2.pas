{Desarrollar una función para calcular el factorial de un número}

Program ejercicio2;

function factorial(numero:byte):extended;
    begin
        if numero=0 then
            factorial:=1
        else
            factorial:=numero*factorial(numero-1);
    end;

var
    numero:byte;

begin
    // Ingresar numero
        writeLn('Ingrese un numero para conocer su factorial: ');
        read(numero);
    
    // Mostrar factorial
        if (numero<=12) then
            writeLn(factorial(numero):9:0) {Mostrar sin notación científica}
        else
            writeLn(factorial(numero)); {Como el numero es tan grande, mostrar con notación científica}
end.