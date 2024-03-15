
Program ejercicio7;

Var 
    // Información sobre la carta 1
    palo1:   char;
    color1:   string;
    numero1:   byte;

    // Información sobre la carta 2
    palo2:   char;
    color2:   string;
    numero2:   byte;
Begin
    // Incisos a y b
    // Preguntar y almacenar palo
    writeLn('Ingrese el palo de su carta (O,C,E,B)');
    readLn(palo1);
    palo1 := upcase(palo1);
    // Preguntar y almacenar color
    writeLn('Ingrese el color de su carta (rojo o azul)');
    readLn(color1);
    color1 := upcase(color1);
    // Preguntar y almacenar número
    writeLn('Ingrese el numero de su carta');
    readLn(numero1);

    // Resultados
    writeLn('Carta AS de copa de cualquier mazo: ',numero1=1);
    writeLn('Carta figura del mazo rojo, cualquier palo: ',(numero1=10) or (

                                                                         numero1
                                                                            =11)
    or (numero1=12));

    // Resto de los incisos
    // Preguntar y almacenar el palo de la otra carta
    writeLn('Ingrese el palo de su otra carta (O,C,E,B)');
    readLn(palo2);
    palo2 := upcase(palo2);
    // Preguntar y almacenar color de la otra carta
    writeLn('Ingrese el color de su otra carta (rojo o azul)');
    readLn(color2);
    color2 := upcase(color2);
    // Preguntar y almacenar número de la otra carta
    writeLn('Ingrese el numero de su otra carta');
    readLn(numero2);

    // Resultados
    writeLn('Dos cartas iguales de diferente mazo: ',(palo1=palo2) and (color1=
                                                                        color2))
    ;
    writeLn('Dos cartas consecutivas del mismo palo sin importar el mazo: ',(abs
            (numero1-numero2) =   1) and (palo1=palo2));
    writeLn('Dos cartas suman doce, de distinto palo y mazo: ',(numero1+numero2=
            12) and (palo1<>palo2) and (color1<>color2));
    writeLn('Dos cartas de igual número, en el mismo mazo o del mismo palo: ',(
            numero1=numero2) and ((color1=color2) or (palo1=palo2)));
    writeLn('Dos cartas de distinto número en el mismo mazo y palo: ',(numero1
            <>numero2) and (color1=color2) and (palo1=palo2));
    writeLn('La primera carta mayor que la segunda: ',
            // el mazo rojo tiene más peso que el azul
            (color1='ROJO') and (color2='AZUL') or


// cuando coinciden en el mazo, el palo determina supremacía en el orden en que se describieron
    // Combinaciones en las que el palo1='O'
    (palo1='O') and (palo2='C') or (palo1='O') and (palo2='E') or (palo1='O')
    and (palo2='B') or
    // Combinaciones en las que el palo1='C'
    (palo1='C') and (palo2='E') or (palo1='C') and (palo2='B') or
    // Combinación palo1='E' y palo2='B'
    (palo1='E') and (palo2='B') or
    // por último define el número
    (numero1>numero2));
End.
