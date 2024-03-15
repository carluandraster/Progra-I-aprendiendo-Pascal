// Dados tres números enteros mostrar el mayor de ellos con alternativas secuenciales

Program ejercicio5a;

var
    // Los tres números enteros
        n1,n2,n3:integer;
    
    // El mayor de los 3
        maximo:integer;

begin
    // Preguntar los 3 números
        writeLn('Ingrese 3 numeros enteros');
        readLn(n1,n2,n3);

    // Evaluar cuál número es más grande
        
        maximo:=n1; {Inicialmente el número más grande será n1 hasta que se demuestre lo contrario}

        if n2>maximo then maximo:=n2; {¿n2 es mayor que n1? De ser así, el número más grande será n2 hasta que se demuestre lo contrario}

        if n3>maximo then maximo:=n3; {¿n3 es más grande que el más grande entre n1 y n2? De ser así, n3 es el número más grande}
    
    // Salida
        writeLn('El numero mas grande es ',maximo);
end.