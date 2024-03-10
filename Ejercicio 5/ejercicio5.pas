
Program ejercicio5;

Const 
    superficie_total =   300;
    superficie_de_baldosa =   0.0625;

Var 
    N,M,porcentaje:   real;
    cantidad_de_balsosas:   integer;
Begin
    // Entrada
    writeLn('Ingrese la superficie N x M que quiere embaldosar');
    read(N,M);

    // Proceso

    // Inciso a
    porcentaje := n*m/superficie_total*100;

    //Inciso b
    cantidad_de_balsosas := round(n*m/superficie_de_baldosa);

    //Salida
    writeLn('La superficie que quiere embaldosar representa un ',porcentaje:5:2,
            '% del total.');
    writeLn('Necesita de ', cantidad_de_balsosas,' baldosas.');
End.
