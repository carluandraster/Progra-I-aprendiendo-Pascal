
Program ejercicio6a;

Var 
    N,num:   integer;

Begin
    // Preguntar número N
    writeLn('Ingrese un numero entero de mas de 3 digitos');
    readLn(N);

    // Procesar num
    num := N Div 1000;

    // Comunicar el número N sin sus últimos 3 dígitos
    writeLn('El numero sin sus ultimos 3 digitos es ',num);
End.
