{Dado un arreglo A de N elementos reales, desarrollar subprogramas para:
a) Calcular la suma de sus elementos.
b) Mostrar los elementos que se encuentran en posiciones pares.
c) Calcular el máximo y el mínimo elemento.
d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ).
Escribir el programa principal con las invocaciones a cada uno de los subprogramas, mostrando los
resultados correspondientes. }

Program ejercicio1;

type
    TV=array[1..100] of real;

// Subprogramas

// Inciso a
function suma(N:byte; A:TV):real;
var
    sum:real;
    i:byte;

begin
    sum:=0;
    for i:=1 to N do
        sum:=sum+A[i];
    suma:=sum;
end;

// Inciso b
Procedure posicionesPares(N:byte; A:TV);
var
    i:byte;

begin
    i:=2;
    while i<=N do
    begin
        writeLn(A[i]:0:2);
        i:=i+2;
    end;
end;

// Inciso c

function maximo(N:byte;A:TV):real;
var
    max:real;
    i:byte;
begin
    max:=-32000;
    for i:=1 to N do
        if A[i]>max then
          max:=A[i];
    maximo:=max;
end;

function minimo(N:byte;A:TV):real;
var
    min:real;
    i:byte;
begin
    min:=32000;
    for i:=1 to N do
        if A[i]<min then
            min:=A[i];
    minimo:=min;
end;

// Inciso d
Procedure permutar(N:byte;var A,B:TV);
var
    i,j:byte;

begin
    j:=0;
    for i:=N downto 1 do
    begin
        j:=j+1;
        B[j]:=A[i];
    end;
end;

// Programa principal

var
    A,B:TV;
    sum,max,min:real;
    i,N:byte;

begin
    // Ingresar datos por teclado
    repeat
        writeLn('Cuantos elementos ingresara?');
        readLn(N);
    until N<=100;
        
    for i:=1 to N do
    begin
        writeLn('Ingrese termino ',i);
        readLn(A[i]);
    end;

    // a) Calcular la suma de sus elementos
    sum:=suma(N,A);
    writeLn('La suma de los numeros ingresados es ',sum:0:2);

    // b) Mostrar los elementos que se encuentran en posiciones pares
    writeLn('Los elementos de posiciones pares son: ');
    posicionesPares(N,A);

    // c) Calcular el máximo y el mínimo elemento. 

    max:=maximo(N,A);
    writeLn('El numero maximo es ',max:0:2);

    min:=minimo(N,A);
    writeLn('El numero minimo es ',min:0:2);

    // d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ). 
    permutar(N,A,B);
    writeLn('Los elementos de B son: ');
    for i:=1 to N do
        writeLn(B[i]:0:2);
end.