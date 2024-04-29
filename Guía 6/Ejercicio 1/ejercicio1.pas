{Leer desde un archivo una matriz de NxM elementos enteros, (N y M se encuentran en la
primera línea del archivo y luego en las restantes N líneas vienen los M elementos). 
Se pide:
a) Generar un arreglo con el máximo de cada fila y mostrarlo.
b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento
si la columna no tiene impares.
c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos. }

Program ejercicio1;

const
    tope = 10;

type
    TipoMatriz = array [1..tope,1..tope] of integer;
    TV = array [1..tope] of integer;

// Subprogramas

procedure cargarMatriz (var A:TipoMatriz; var N,M:byte);
var
    archivo:text;
    i,j:byte;
begin
    // Inicializar archivo de texto
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    for i:=1 to N do {filas}
        for j:=1 to M do {columnas}
            read(archivo,A[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

// a) Generar un arreglo con el máximo de cada fila y mostrarlo.

function maxFila (A:TipoMatriz;i,M:byte):integer;
var
    j:byte;
    maximo:integer;
begin
    maximo:=A[i,1];
    for j:=2 to M do
        if A[i,j]>maximo then
            maximo:=A[i,j];
    maxFila:=maximo;
end;

procedure generarArrMax(A:TipoMatriz; var maximos:TV; N,M:byte);
var
    i:byte;
begin
    for i:=1 to N do
        maximos[i]:=maxFila(A,i,M);
end;

procedure mostrar (maximos:TV;N:byte;texto:string);
var
    i:byte;
begin
    write(texto);
    for i:=1 to N do
        write(maximos[i],' ');
    writeLn();
end;

{b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento
si la columna no tiene impares.}

procedure sumaImpar (A: TipoMatriz; j,N:byte; var sumImpar:integer; var tieneImpar:boolean);
var
    i:byte;
begin
    tieneImpar:=false;
    sumImpar:=0;
    for i:=1 to N do
        if odd(A[i,j]) then
        begin
            tieneImpar:=true;
            sumImpar:=sumImpar+A[i,j];
        end;
end;

procedure generarArrSumImp (A:TipoMatriz; N,M:byte; var SumImp:TV; var K:byte);
var
    j:byte;
    tieneImpar:boolean;
    sumImpar:integer;
begin
    // Inicializar variables
    K:=0;

    // Recorrer columnas
    for j:=1 to M do
    begin
        sumaImpar (A,j,N,sumImpar,tieneImpar);
        if tieneImpar then
        begin
            K:=K+1;
            SumImp[K]:=sumImpar;
        end;
    end;
end;

// c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos

function promedio (x,N: byte; A: TipoMatriz): real;
var
    i,acumulador: byte;
begin
    acumulador:=0;
    for i:=1 to N do
        acumulador:=acumulador+A[i,x];
    promedio:=acumulador/N;
end;

procedure entradaSalida (A: TipoMatriz; N,M: byte);
var
    x:byte;
begin
    repeat
        writeLn('Ingrese el indice de una columna: ');
        readLn(x);
    until (x>0) and (x<=M);

    writeLn('Promedio: ',promedio(x,N,A):4:2);
end;

// Programa principal

var
    A: TipoMatriz;
    N,M,K: byte;
    maximos,SumImp:TV;
begin
    cargarMatriz(A,N,M);

    // Inciso a
    generarArrMax(A,maximos,N,M);
    mostrar(maximos,N,'Los maximos de cada fila son: ');

    // Inciso b
    generarArrSumImp (A, N, M, SumImp, K);
    mostrar(SumImp,K,'Las sumatorias de numeros impares son: ');

    // Inciso c
    entradaSalida(A,N,M);
end.