{Verificar si una matriz A de NxN de números enteros cumple que para cada fila el elemento
respectivo de la diagonal principal es mayor a la suma del resto de los elementos de la fila.}

Program ejercicio12;

const
    tope = 10;

type
    TM = array [1..tope,1..tope] of integer;

// Subprogramas

procedure leerArchivo (var A: TM; var N: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,N);
    for i:=1 to N do
        for j:=1 to N do
            read(archivo,A[i,j]);
        
    // Cerrar archivo
    close(archivo);
end;

// Sumar toda una fila excepto la diagonal (fila constante)
function sumarSi (A: TM; fila,N: byte):integer;
begin
    if N>1 then
        if N=fila then
            sumarSi:=sumarSi(A,fila,N-1)
        else
            sumarSi:=A[fila,N]+sumarSi(A,fila,N-1)
    else
        if N<>fila then
            sumarSi:=A[fila,N];
end;

// Verifica que se cumpla la condición del problema (N constante)
function verifica (A: TM;fila,N: byte):boolean;
begin
    if A[fila,fila]>sumarSi(A,fila,N) then
        if fila=1 then
            verifica:=true
        else
            verifica:=verifica(A,fila-1,N)
    else
        verifica:=false;
end;



// Programa principal

var
    A: TM;
    N: byte;

begin
    leerArchivo(A,N);

    if verifica(A,N,N) then
        writeln('Se cumple la condicion.')
    else
        writeln('No se cumple la condicion.');
end.