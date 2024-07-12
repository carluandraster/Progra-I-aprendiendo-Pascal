Program ejercicio2;

const
    TOPE = 11;

type
    TM = array [1..TOPE,1..TOPE] of real;

procedure cargarMatriz (var A: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    assign(archivo,'matriz.txt');
    reset(archivo);
    read(archivo,N,M);
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,A[i,j]);
    close(archivo);
end;

function cumple (A: TM; N,M,j: byte;condicion: boolean): boolean;
begin
    if N=0 then
        cumple:=true
    else
        if j=0 then
            cumple:=cumple(A,N-1,M,M,condicion)
        else
            if condicion then
                if A[N,j]>=0 then
                    cumple:=cumple(A,N,M,j-1,condicion)
                else
                    cumple:=false
            else
                if A[N,j]<0 then
                    cumple:=cumple(A,N,M,j-1,condicion)
                else
                    cumple:=false
end;

// Programa principal

var
    A: TM;
    N,M: byte;
    condicion: boolean;

begin
    cargarMatriz(A,N,M);

    condicion:=A[N div 2,M]>=0;
    
    if cumple(A,N div 2,M,M-1,condicion) then
        writeLn('Se cumple con la condicion pedida')
    else
        writeLn('No se cumple con la condicion pedida');
end.