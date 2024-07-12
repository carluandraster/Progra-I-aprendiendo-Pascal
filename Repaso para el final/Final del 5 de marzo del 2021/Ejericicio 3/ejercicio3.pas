Program ejercicio3;

const
    MAXELEM = 20;

type
    TM = array[1..MAXELEM,1..MAXELEM] of integer;

procedure cargarMatriz (var A: TM; var N: byte);
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


function noNulo (A: TM; N,j: byte): boolean;
begin
    if N=1 then
        noNulo:=true
    else
        if j=0 then
            noNulo:=noNulo(A,N-1,N-2)
        else
            if A[N,j]=0 then
                noNulo:=false
            else
                noNulo:=noNulo(A,N,j-1);
end;

// Programa principal

var
    A: TM;
    N: byte;

begin
    cargarMatriz(A,N);

    if noNulo(A,N,N-1) then
        writeLn('Ningun elem bajo la diagonal es nulo')
    else
        writeLn('Hay elementos nulos');
end.