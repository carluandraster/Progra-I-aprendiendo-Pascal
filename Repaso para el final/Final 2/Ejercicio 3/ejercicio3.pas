Program ejercicio3;

const
    TOPE = 10;

type
    TM = array [1..TOPE,1..TOPE] of byte;

// Subprogramas

procedure cargarMatriz(var MATRIZ: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,N,M);
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,MATRIZ[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

procedure buscar (x,N,M: byte; MATRIZ: TM; var i,j: byte);
begin
    if M=0 then
        i:=0
    else
    begin
        while (i<=N) and (MATRIZ[i,M]<>x) do
            i:=i+1;
        if i>N then
            buscar(x,N,M-1,MATRIZ,i,j)
        else
            j:=M;
    end;
end;

function minimo (MATRIZ: TM; N,M: byte): byte;
var
    i,j,min: byte;
begin
    min:=255;
    for i:=1 to N do
        for j:=1 to M do
            if MATRIZ[i,j]<min then
                min:=MATRIZ[i,j];
    minimo:=min;
end;

// Programa principal

var
    MATRIZ: TM;
    N,M,X,i,j: byte;

begin
    cargarMatriz(MATRIZ,N,M);

    writeLn('Ingrese un numero: ');
    readLn(X);

    buscar(x,N,M,MATRIZ,i,j);
    if i=0 then
        writeLn('No se encontro el numero')
    else
        writeLn('El numero esta en la fila ',i,' columna ',j);
    
    writeLn('El minimo de la matriz es ',minimo(MATRIZ,N,M));
end.