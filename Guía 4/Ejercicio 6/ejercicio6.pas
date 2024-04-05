{Desarrollar una función que devuelva un número aleatorio en un rango [A, B] con A<B ingresados
por teclado. Nota: usar la función Random y Randomize. }

Program ejercicio6;

function aleatorio(A:byte;B:byte):byte;
    begin
      Randomize;
      aleatorio:=round(A+Random()*(B-A));
    end;

var
    A,B:byte;

begin
    // Ingreso de datos
        write('Ingrese un numero: ');
        read(A);

        repeat
            write('Ingrese un numero mas grande: ');
            read(B);
        until B>A;
    
    // Comunicar numero aleatorio entre A y B
        writeLn('Un numero aleatorio entre ',A,' y ',B,' es: ',aleatorio(A,B));
end.