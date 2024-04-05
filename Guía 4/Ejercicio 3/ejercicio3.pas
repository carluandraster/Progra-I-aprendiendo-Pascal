{Dado un número natural N, calcular y mostrar la suma de los N primeros números naturales}

Program ejercicio3;

function suma(x:word):longint;
    begin
        suma:=round((x+1)*x/2); {Metodo de Gauss para la sumatoria de números de a 1}
    end;

var
    N:word;

begin
    // Ingresar numero natural N
        write('Ingrese un numero natural: ');
        read(N);
    
    // Mostrar sumatoria de 1 a N
        writeLn(suma(N));
end.