Program ejercicio2;

const
    TOPE = 100;

type
    TM = array [1..tope,1..tope] of byte;

procedure cargarMatriz(var MATRIZ: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    assign(archivo,'matriz.txt');
    reset(archivo);
    read(archivo,N,M);
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,MATRIZ[i,j]);
    close(archivo);
end;

function suma (i,columna: byte; MATRIZ: TM):byte;
begin
    if i=0 then
        suma:=0
    else
        suma:=MATRIZ[i,columna]+suma(i-1,columna,MATRIZ);
end;

function contar (x,j,N: byte; MATRIZ: TM):byte;
begin
    if j=0 then
        contar:=0
    else
        if suma(N,j,MATRIZ)>=x then
            contar:=1+contar(x,j-1,N,MATRIZ)
        else
            contar:=contar(x,j-1,N,MATRIZ);
end;

// Programa principal

var
    N,M,X: byte;
    MATRIZ: TM;
begin
    cargarMatriz(MATRIZ,N,M);
    writeLn('Ingrese una cantidad de empleados: ');
    readLn(X);
    writeLn('Hay ',contar(X,M,N,MATRIZ),' sucursales que tienen al menos ',X,' empleados.');
end.