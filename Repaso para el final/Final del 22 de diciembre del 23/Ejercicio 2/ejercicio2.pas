Program ejercicio2;

const
    TOPE = 10;

type
    TM = array [1..TOPE,1..TOPE] of real;

procedure cargarMatriz (var A: TM; var N: byte);
var
    archivo: text;
    i,j: byte;
begin
    assign(archivo,'matriz.txt');
    reset(archivo);
    read(archivo,N);
    for i:=1 to N do
        for j:=1 to N do
            read(archivo,A[i,j]);
    close(archivo);
end;

function cumple (A: TM; i,j,N: byte): boolean;
begin
    if i>N then
        cumple:=true
    else
        if j=i then
            cumple:=cumple(A,i+1,1,N)
        else
            if A[i,j]>A[i,i] then
                cumple:=cumple(A,i,j+1,N)
            else
                cumple:=false;
end;

// Programa principal

var
    A: TM;
    N: byte;

begin
    cargarMatriz (A, N);
    if cumple (A,2,1,N) then
        writeLn('Cumple')
    else
        writeLn('No cumple');
end.