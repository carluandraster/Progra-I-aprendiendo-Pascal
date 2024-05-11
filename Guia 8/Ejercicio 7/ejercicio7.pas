{ Crear una función recursiva que busque el elemento mínimo de una matriz
cuadrada. }


Program ejercicio7;

const
    tope = 20;

type
    TM = array [1..tope,1..tope] of byte;



// Subprogramas

procedure leerArchivo(var matriz: TM; var N: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Inicializar variable
    N:=0;

    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,N);
    for i:=1 to N do
        for j:=1 to N do
            read(archivo,matriz[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

// Buscar minimo elemento de la matriz

function minBordeInf (matriz: TM; j,N: byte): byte;
var
    minAux: byte;
begin
    if (j=1) then
        minBordeInf:=matriz[N,1]
    else
    begin
        minAux:=minBordeInf(matriz,j-1,N);
        if matriz[N,j]<minAux then
            minBordeInf:=matriz[N,j]
        else
            minBordeInf:=minAux;
    end;
        
end;

function minBordeDer (matriz: TM; i,N: byte): byte;
var
    minAux: byte;
begin
    if (i=1) then
        minBordeDer:=matriz[1,N]
    else
    begin
        minAux:=minBordeDer(matriz,i-1,N);
        if matriz[i,N]<minAux then
            minBordeDer:=matriz[i,N]
        else
            minBordeDer:=minAux;
    end;
        
end;

function minBordes (matriz: TM; N: byte): byte;
var
    minInf,minDer: byte;
begin
    // Inicializar variables
    minInf:=minBordeInf(matriz,N,N);
    minDer:=minBordeDer(matriz,N-1,N);

    // Devolver resultado
    if minInf<minDer then
        minBordes:=minInf
    else
        minBordes:=minDer;
end;

function minimo (matriz: TM; N: byte): byte;
var
    minAux,bordes: byte;
begin
    if N=1 then
        minimo:=matriz[1,1]
    else
    begin
        minAux:=minimo(matriz,N-1);
        bordes:=minBordes(matriz,N);
        if bordes<minAux then
            minimo:=bordes
        else
            minimo:=minAux;
    end;
end;



// Programa principal


var
    matriz: TM;
    N: byte;

begin
    leerArchivo(matriz,N);
    writeLn('Numero mas bajo de la matriz: ',minimo(matriz,N));
end.