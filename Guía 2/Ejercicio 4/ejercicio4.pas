

// Dadas dos fechas (dia, mes y año) indicar cuál es la más antigua y a qué trimestre pertenece

Program ejercicio4;

Var 
    // Información sobre día 1
    dia1,mes1:   byte;
    anio1:   word;

    // Información sobre día 2
    dia2,mes2:   byte;
    anio2:   word;

    // Mes de la fecha más antigua
    mes:byte;

Begin
    // Entrada fecha 1
    writeLn('Ingrese una fecha');
    readLn(dia1,mes1,anio1);

    // Entrada fecha 2
    writeLn('Ingrese otra fecha');
    readLn(dia2,mes2,anio2);

    // Calcular qué fecha es más antigua
    If (anio1<>anio2) Then {Criterio del año}
        If (anio1>anio2) Then
            Begin
                writeLn('La fecha mas antigua es ',dia2,'/',mes2,'/',anio2);
                mes:=mes2;
            End
        Else
            Begin
                writeLn('La fecha mas antigua es ',dia1,'/',mes1,'/',anio1);
                mes := mes1;
            End
    Else
        If (mes1<>mes2) Then {Si los años son iguales, criterio del mes}
            If (mes1>mes2) Then 
                Begin
                    writeLn('La fecha mas antigua es ',dia2,'/',mes2,'/',anio2);
                    mes := mes2;
                End
            Else     
                Begin
                    writeLn('La fecha mas antigua es ',dia1,'/',mes1,'/',anio1);
                    mes := mes1;
                End
        Else
            If (dia1<>dia2) Then {Si los meses y años son iguales, criterio del día}
                If (dia1>dia2) Then
                    Begin
                        writeLn('La fecha mas antigua es ',dia2,'/',mes2,'/',anio2);
                        mes := mes2;
                    End
                Else
                    Begin
                        writeLn('La fecha mas antigua es ',dia1,'/',mes1,'/',anio1);
                        mes := mes1;
                    End
            Else
                Begin
                    writeLn('Ambas fechas son iguales');
                    mes:=mes1;
                End;
    
    // De la fecha más antigua, identificar a qué trimestre pertenece
    Case mes of
        1..3: writeLn('Pertenece al primer trimestre');
        4..6: writeLn('Pertenece al segundo trimestre');
        7..9: writeLn('Pertenece al tercer trimestre');
        10..12: writeLn('Pertenece al cuarto trimestre');
    End;
End.
