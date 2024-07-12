{Sea A un vector de N elementos reales (N par) desarrollar una función recursiva
que verifique si A cumple que la primera mitad tiene todos sus elementos negativos y
la segunda mitad todos positivos. 
Si A contiene algún cero, no verifica la condición solicitada.}

Program ejercicio1;

const
    MAXELEM = 254;

type
    TV = array [1..MAXELEM] of real;

procedure cargarArreglo (var A: TV; var N: byte);
var
    archivo: text;
begin
    assign(archivo,'vector.txt');
    reset(archivo);
    N:=0;
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N]);
    end;
    close(archivo);
end;

function cumple (A: TV; i,N: byte): boolean;
begin
    if i=0 then
        cumple:=true
    else
        if ((i <= N div 2) and (A[i]<0)) or ((i > N div 2) and (A[i]>0)) then
            cumple:=cumple(A,i-1,N)
        else
            cumple:=false;
end;

var
    A: TV;
    N: byte;

begin
    cargarArreglo(A,N);
    if cumple(A,N,N) then
        writeLn('Cumple con la condicion')
    else
        writeLn('No cumple con la condicion');
end.