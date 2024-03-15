
Program ejercicio6b;

Var 
    resto,num:   integer;
    N:   longint;

Begin
    // Preguntar número N
    writeLn('Ingrese un numero entero de mas de 3 digitos');
    readLn(N);

    // Sacar el resto de dividir por 1000
    resto := N Mod 1000;

    // Quitar sus 2 últimos dígitos para obtener el dígito de las decenas
    num := resto Div 100;

    // Comunicar el dígito en posición de las centenas
    writeLn('El digito que esta en la posicion de las centenas es ',num);
End.
