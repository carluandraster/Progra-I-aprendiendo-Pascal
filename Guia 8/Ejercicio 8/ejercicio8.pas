{Desarrollar un procedimiento recursivo que devuelva en un arreglo los máximos de cada fila de 
una matriz de MxN. }

Program ejercicio8;

const
    tope = 10;

type
    TM = array [1..tope,1..tope] of byte;
    TV = array [1..tope] of byte;


// Subprogramas

procedure leerArchivo (var matriz: TM; var N,M: byte);
var
    archivo: text;
    i: byte;
begin
    // Inicializar variables
    M:=1;
    N:=0;

    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo

    while not eoln(archivo) do
    begin
        N:=N+1;
        read(archivo,matriz[M,N]);
    end;

    while not eof(archivo) do
    begin
        M:=M+1;
        for i:=1 to N do
            read(archivo,matriz[M,i]);
    end;

    // Cerrar archivo
    close(archivo);
end;

function maximo (matriz: TM; M,N: byte): byte;
var
    maxAux: byte;
begin
    // Recorrer fila
    if N=1 then
        maximo:=matriz[M,1]
    else
    begin
        maxAux:=maximo(matriz,M,N-1);
        if matriz[M,N]>maxAux then
            maximo:=matriz[M,N]
        else
            maximo:=maxAux;
    end;
end;

procedure maxCadaFila (var maximos: TV; matriz: TM; M,N: byte);
begin
    maximos[M]:=maximo(matriz,M,N);

    // Columna anterior
    if M>1 then
        maxCadaFila(maximos,matriz,M-1,N);
end;

procedure imprimirArreglo (maximos: TV; M: byte);
begin
    if M>1 then
    begin
        imprimirArreglo(maximos,M-1);
        writeLn(maximos[M]);
    end
    else
        writeLn(maximos[M]);
end;



// Programa principal

var
    matriz: TM;
    N,M: byte;
    maximos: TV;

begin
    leerArchivo(matriz,N,M);

    maxCadaFila(maximos,matriz,M,N);

    writeLn('Maximos de cada fila: ');
    imprimirArreglo(maximos,M);
end.