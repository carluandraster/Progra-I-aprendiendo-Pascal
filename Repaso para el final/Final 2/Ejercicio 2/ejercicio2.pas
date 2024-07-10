Program ejercicio2;

const
    TOPE = 255;

type
    TV = array [1..TOPE] of char;

// Subprogramas

procedure cargarPalabras (var A,B: TV; var N,M: byte);
var
    archivo: text;
    blanco: char;
begin
    // Abrir archivo
    assign(archivo,'palabras.txt');
    reset(archivo);

    // Inicializar variables
    N:=0;
    M:=0;

    // Cargar A
    while not eoln(archivo) do
    begin
        N:=N+1;
        read(archivo,A[N],blanco);
    end;
    readLn(archivo);
    // Cargar B
    while not eoln(archivo) do
    begin
        M:=M+1;
        read(archivo,B[M],blanco);
    end;

    // Cerrar archivo
    close(archivo);
end;

function AcontieneaB (A,B: TV; N,M,j: byte): boolean;
begin
    if j=0 then
        AcontieneaB:= true
    else
        if N=0 then
            AcontieneaB:=false
        else
            if A[N]=B[j] then
                AcontieneaB:=AcontieneaB(A,B,N-1,M,j-1)
            else
                if A[N]=B[M] then
                    AcontieneaB:=AcontieneaB(A,B,N,M,M)
                else
                    AcontieneaB:=AcontieneaB(A,B,N-1,M,M);
end;

// Programa principal

var
    A,B: TV;
    N,M: byte;

begin
    cargarPalabras(A,B,N,M);
    writeLn(AcontieneaB(A,B,N,M,M));
end.