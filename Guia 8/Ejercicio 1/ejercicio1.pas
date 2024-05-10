{La siguiente función calcula la potencia n-ésima de un número X ( X^n) en forma iterativa,
siendo n y X enteros. Se pide:
a) Desarrollarla en forma recursiva.
b) Considerar n negativo.
function potencia(X,n: integer): integer; (* X elevado a n *)
var
    i: integer;
    mult: integer;
begin
    mult := 1; (* inicialización *)
    for i := 1 to n do
        mult := mult * X; (* hacemos "n" veces "X*X" *)
    potencia := mult;
end;}

Program ejercicio1;

// Subprogramas

function potencia(X,n: integer): real;
begin
    if n<0 then
        potencia:=1/potencia(x,-n)
    else
        if n>0 then
            potencia:=x*potencia(x,n-1)
        else
            potencia:=1
end;

// Programa principal

var
    x,n: integer;

begin
    // Ingresar datos por teclado
    repeat
        writeLn('Ingrese base: ');
        read(x);

        writeLn('Ingrese exponente: ');
        read(n);
    until (x<>0) or (n>0);


    writeLn(x,'^',n,' = ',potencia(x,n):4:2);
end.