{Se tiene en un archivo los elementos de una matriz “rala” (se dice que una matriz es rala
cuando la mayoría de sus elementos son cero). En cada línea del archivo viene:
 fila, columna, dato (distinto de cero)
Se pide:
a) Armar la matriz original y mostrarla en forma matricial.
(Obtener N y M, sabiendo que hay al menos un valor no nulo en la última fila de alguna 
columna y en la última columna de alguna fila ).
b) Si es cuadrada (N=M) determinar si es triangular inferior. }

Program ejercicio4;

const
    tope = 100;

type
    TM = array [1..tope,1..tope] of byte;

// Subprogramas

procedure limpiar(var matriz: TM);
var
    i,j:byte;
begin
    for i:=1 to tope do
        for j:=1 to tope do
            matriz[i,j]:=0;
end;

// a) Armar la matriz original y mostrarla en forma matricial.

procedure leerArchivo(var matriz: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Inicializar variables
    limpiar(matriz);
    N:=0;
    M:=0;

    // Reconocer archivo de texto
    assign(archivo,'numeros.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,i,j,matriz[i,j]);
        if i>N then
            N:=i;
        if j>M then
            M:=j;
    end;

    // Cerrar archivo de texto
    close(archivo);
end;

procedure mostrarMatriz (matriz: TM; N,M: byte);
var
    i,j:byte;
begin
    writeLn('La matriz es:');
    for i:=1 to N do
    begin
        for j:=1 to M do
            write(matriz[i,j],' ');
        writeLn();
    end;
end;

// b) Si es cuadrada (N=M) determinar si es triangular inferior.

function triangularInf (matriz: TM; N: byte):boolean;
var
    i,j:byte;
begin
    i:=0;
    repeat
        i:=i+1;
        j:=i+1;
        while (j<=N) and (matriz[i,j]=0) do
            j:=j+1;
    until (i>N) or (matriz[i,j]<>0);
    triangularInf:=i>N;
end;

procedure entradaSalida (matriz: TM; N,M:byte);
begin
    if N=M then
        if triangularInf(matriz,N) then
            writeLn('La matriz es triangular inferior.')
        else
            writeLn('La matriz no es trianguilar inferior.')
    else
        writeLn('La matriz no es cuadrada.');
end;

// Programa principal

var
    matriz: TM;
    N,M: byte;

begin
    leerArchivo(matriz,N,M);

    // Inciso a
    mostrarMatriz(matriz,N,M);

    // Inciso b
    entradaSalida(matriz,N,M);
end.