{Sea un conjunto A de enteros y una relación R, se pide
a) Generar la matriz booleana MatR que representa una relación R.
b) Determinar si R es:
 Reflexiva
 Simétrica }

Program ejercicio8;

const
    tope = 100;

type
    TV = array [1..tope] of integer;
    TM = array [1..tope,1..tope] of byte;

// Subprogramas

// Ingresar por archivo el conjunto A
procedure leerArchivo (var A: TV; var N: byte);
var
    archivo: text;
begin
    // Inicializar variables
    N:=0;

    // Abrir archivo
    assign(archivo,'enteros.txt');
    reset(archivo);

    // Cargar arreglo
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N]);
    end;

    // Cerrar archivo
    close(archivo);
end;

// Ingresar por teclado la relacion R
procedure ingresarR (var R: byte);
begin
    repeat
        writeLn('Ingrese una relacion: ');
        writeLn('1 - Relacion de divisibilidad');
        writeLn('2 - Relacion de suma par');
        writeLn('3 - Relacion de modulo');

        readLn(R);
    until (R=1) or (R=2) or (R=3);
end;

// a) Generar la matriz booleana MatR que representa una relación R

// aRb sii a divide a b; es decir, b mod a = 0
procedure relDivisibilidad (var MatR: TM; A: TV; N: byte);
var
    i,j: byte;
begin
    for i:=1 to N do
        for j:=1 to N do
            if A[j] mod A[i] = 0 then
                MatR[i,j]:=1
            else
                MatR[i,j]:=0;
end;

// aRb sii existe un número entero k tal que a+b=2k (a+b no es impar)
procedure relSumaPar (var MatR: TM; A: TV; N: byte);
var
    i,j: byte;
begin
    for i:=1 to N do
        for j:=1 to N do
            if odd(A[i]+A[j]) then
                MatR[i,j]:=0
            else
                MatR[i,j]:=1;
end;

// aRb sii |a|=|b|
procedure relModulo (var MatR: TM; A: TV; N: byte);
var
    i,j: byte;
begin
    for i:=1 to N do
        for j:=1 to N do
            if abs(A[i])=abs(A[j]) then
                MatR[i,j]:=1
            else
                MatR[i,j]:=0;
end;

procedure generarMatriz (var MatR: TM; A: TV; N,R: byte);
begin
    case R of
        1: relDivisibilidad(MatR,A,N);
        2: relSumaPar(MatR,A,N);
        3: relModulo(MatR,A,N);
    end;
end;

procedure mostrarMatriz(MatR: TM; N: byte);
var
    i,j: byte;
begin
    for i:=1 to N do
        begin
          for j:=1 to N do
            write(MatR[i,j],' ');
          writeLn;
        end;
end;

// b) Determinar si R es Reflexiva o Simétrica

{Se puede demostrar formalmente que las relaciones del menu son reflexivas, independientemente
del vector A. Por lo tanto, ni me molesto en hacer una función booleana que diga si la relación
es reflexiva porque siempre me devolvería verdadero}

function esSimetrica(A: TV; N,R: byte):boolean;
var
    i:byte;
begin
    case R of
        1:
        begin
            // La relación de divisibilidad es simétrica sii los elementos del vector A son todos iguales
            i:=2;
            while (i<=N) and (A[1]=A[i]) do
                i:=i+1;
            esSimetrica:=i>N;
        end;
        2: esSimetrica:=true; // Por propiedad conmutativa de la suma (x+y=2k -> y+x=2k)
        3: esSimetrica:=true; // Por simetría de la igualdad (|A|=|B| -> |B|=|A|)
    end;
end;

// Programa principal

var
    A: TV;
    N,R: byte;
    MatR: TM;

begin
    leerArchivo(A,N);
    ingresarR(R);

    // Inciso a
    generarMatriz(MatR, A, N, R);
    writeLn('Matriz booleana de la relacion: ');
    mostrarMatriz(MatR, N);

    // Inciso b
    writeLn('La relacion es reflexiva.');
    if esSimetrica(A,N,R) then
        writeLn('La relacion es simetrica.')
    else
        writeLn('La relacion no es simetrica.');
end.