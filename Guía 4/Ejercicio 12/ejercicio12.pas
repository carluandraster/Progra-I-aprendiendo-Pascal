{Los dos primeros términos de la sucesión de Fibonacci valen 1, y los demás se hallan sumando los
dos anteriores: 1, 1, 2, 3, 5, 8,13, 21…
Desarrolle un programa que lea N cotas enteras positivas, y para cada una de ellas genere y muestre los
términos de la sucesión hasta superar la cota dada.}

Program ejercicio12;

// Procedimiento de impresion de numeros de Fibonacci
Procedure Fibonacci(n:word);
var
    n1,n2,n3:word;
begin
    // Inicializar variables
    n1:=1;
    n2:=1;

    // Imprimir terminos hasta N
    while n1<=n do
    begin
      writeLn(n1);
      n3:=n1+n2;
      n1:=n2;
      n2:=n3;
    end;
end;

//Programa principal

var
    n:word;

begin
    // Ingreso de datos
    write('Ingrese un numero: ');
    read(n);

    // Imprimir numeros de Fibonacci hasta N
    writeLn('Los numeros de la sucesion de Fibonacci menores o iguales a ',n,' son: ');
    Fibonacci(n);
end.