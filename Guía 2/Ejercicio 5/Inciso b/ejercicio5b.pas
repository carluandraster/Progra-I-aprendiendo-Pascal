// Dados tres números enteros mostrar el mayor de ellos con alternativas anidadas con expresiones lógicas compuestas

Program ejercicio5b;

var
    // Los 3 números enteros
        n1,n2,n3:integer;
    
    // El mayor de ellos
        maximo:integer;

begin
    // Preguntar por los 3 números
        writeLn('Ingrese 3 numeros enteros');
        readLn(n1,n2,n3);

    // Evaluar cuál número es más grande
        if (n1>n2) and (n1>n3) then
            maximo:=n1   {Si n1 es más grande que n2 y n3, n1 es el más grande}       
        else {De lo contrario, n2 o n3 es el número más grande}
            if n2>n3 then {Si n2 es más grande que n3, n2 es el más grande}
                maximo:=n2
            else
                maximo:=n3; {Si n1 no es el más grande ni n2 es el más grande, entonces el número más grande es n3}
    
    // Salida
        writeLn('El numero mas grande es ',maximo);
end.