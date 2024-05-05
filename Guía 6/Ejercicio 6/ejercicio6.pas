{Un cuadrado mágico de orden N (impar), es una matriz cuadrada de NxN que contiene números
naturales de 1 a N², tal que la suma de cualquier columna, fila o diagonal coincide. 
Se construye de la siguiente manera:
 El número 1 se coloca en la casilla central de la primera fila.
 Cada número siguiente se coloca en la casilla correspondiente a
la fila anterior y columna posterior.
 Si el número es el que sigue a un múltiplo de N, se coloca en la
casilla de la fila posterior en la misma columna.
 Se considera fila anterior a la primera, la última.
 Se considera columna posterior a la última, la primera
Se pide:
a) Escribir un procedimiento que, dados una matriz Mat y N, genere el cuadrado mágico.
b) Escribir una función booleana que verifique si la matriz Mat es un cuadrado mágico.}

Program ejercicio6;

const
    tope = 100;

type
    TM = array [1..tope,1..tope] of word;

// Subprogramas

// a) Escribir un procedimiento que, dados una matriz Mat y N, genere el cuadrado mágico.

procedure generarCuadrado (var Mat: TM; N:byte);
var
    i,j: byte;
    numero:word;
begin
    // Inicializar variables
    i:=1;
    j:= N div 2+1;

    Mat[i,j]:=1;

    // Completar cuadrado
    for numero:=2 to sqr(N) do
    begin
        if (numero-1) mod N = 0 then
        begin
            i:=i+1;
            if i=N+1 then
                i:=1;
        end  
        else
        begin
            i:=i-1;
            if i=0 then
                i:=i+N;
            j:=j+1;
            if j=N+1 then
                j:=1;
        end;

        Mat[i,j]:=numero;
    end;
end;

procedure imprimirMatriz (Mat: TM; N:byte);
var
    i,j:byte;
begin
    for i:=1 to N do
        begin
            for j:=1 to N do
                write(Mat[i,j],' ');
            writeLn;
        end;
end;

// b) Escribir una función booleana que verifique si la matriz Mat es un cuadrado mágico.

function sumar (Mat: TM; N: byte; tipo: char; indice:byte): word;
var
    i:byte;
    sumAux: word;
begin
    sumAux:=0;
    case tipo of
        'F':
            for i:=1 to N do
                sumAux:=sumAux+Mat[indice,i];
        'C':
            for i:=1 to N do
                sumAux:=sumAux+Mat[i,indice];
        'D':
            if indice = 1 then
                for i:=1 to N do
                    sumAux:=sumAux+Mat[i,i]
            else
                for i:=1 to N do
                    sumAux:=sumAux+Mat[N-i+1,i];
    end;
    sumar:=sumAux;
end;

function esMagico(Mat: TM; N: byte):boolean;
var
    i:byte;
    suma:word;
begin
    esMagico:=false;

    // Analizar filas
    i:=2;
    suma:=sumar (Mat, N, 'F', 1);
    while (i<=N) and (sumar (Mat, N, 'F', i)=suma) do
        i:=i+1;
    
    // Analizar columnas
    if i>N then
    begin
        i:=1;
        while (i<=N) and (sumar (Mat, N, 'C', i)=suma) do
            i:=i+1;
        // Analizar diagonales
        if (i>N) and (sumar (Mat, N, 'D', 1)=suma) and (sumar (Mat, N, 'D', 0)=suma) then
            esMagico:=true;
    end; 
end;

// Programa principal

var
    Mat: TM;
    N:byte;

begin
    repeat
        writeLn('Ingrese dimension del cuadrado magico: ');
        readLn(N);
    until odd(N) and (N<=tope);

    generarCuadrado (Mat, N);
    imprimirMatriz (Mat, N);

    if esMagico(Mat,N) then
        writeLn('La matriz es un cuadrado magico.')
    else
        writeLn('La matriz no es un cuadrado magico.');
end.