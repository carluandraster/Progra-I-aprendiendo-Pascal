// Dados tres números enteros mostrar el mayor de ellos con alternativas anidadas con expresiones lógicas simples (sin conectores lógicos)

Program ejercicio5c;

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
        if n1>n2 then
            if n1>n3 then
                maximo:=n1 {Si n1 es mayor a n2 y n3, n1 es el número más grande}
            else {n3 es mayor o igual a n1}
                maximo:=n3 {Si n1 es mayor que n2 y n3 es mayor o igual a n1, el máximo es n3}
        else {n2 es mayor o igual a n1}
            if n2>n3 then 
                maximo:=n2 {Si n2 es más grande que n3 y mayor o igual que n1, n2 es el más grande}
            else {n3 es mayor o igual a n2}
                maximo:=n3; {Si n3 es mayor o igual que n2 y n2 es mayor o igual a n1, entonces el número más grande es n3}

    // Salida
        writeLn('El numero mas grande es ',maximo);
end.