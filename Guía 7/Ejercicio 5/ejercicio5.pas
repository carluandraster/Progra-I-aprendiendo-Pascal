{Ingresar N y M y luego los elementos no nulos de una matriz rala por filas (i, j, valor) y
almacenar en un arreglo de registros.
a) Mostrar en formato matricial completando los ceros faltantes.
b) Si es cuadrada, modificarla para obtener la traspuesta. }

Program ejercicio5;

const
    tope = 100;

type
    TR = record
        i,j,valor: byte;
    end;

    TV = array [1..tope] of TR;

// Subprogramas

procedure leerArchivo (var ELEMENTOS: TV; var N,M,K: byte);
var
    archivo: text;
begin
    // Inicializar variables
    K:=0;

    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    while not eof(archivo) do
    begin
        K:=K+1;
        with ELEMENTOS[K] do
            readLn(archivo,i,j,valor);
    end;
end;

// a) Mostrar en formato matricial completando los ceros faltantes.

function buscar (ELEMENTOS: TV; K,i,j: byte):byte;
var
    t: byte;
begin
    // Inicializar variables
    t:=1;

    // Buscar
    while (t<=K) and ((ELEMENTOS[t].i<>i) or (ELEMENTOS[t].j<>j)) do
        t:=t+1;
    
    // Devolver resultado
    if t<=K then
        buscar:=t
    else
        buscar:=0;
end;

procedure imprimirMatriz (ELEMENTOS: TV; var N,M,K: byte);
var
    i,j,busqueda: byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            busqueda:=buscar(ELEMENTOS, K, i, j);
            if busqueda=0 then
                write(0,' ')
            else
                write(ELEMENTOS[busqueda].valor,' ');
        end;
        writeLn;
    end; 
end;

// b) Si es cuadrada, modificarla para obtener la traspuesta

procedure trasponerMatriz (ELEMENTOS: TV; var N,M,K: byte);
var
    i,j,busqueda: byte;
begin
    if N=M then
        begin
            writeLn('Matriz traspuesta: ');
            for i:=1 to N do
            begin
                for j:=1 to M do
                begin
                    busqueda:=buscar(ELEMENTOS, K, j, i);
                    if busqueda=0 then
                        write(0,' ')
                    else
                        write(ELEMENTOS[busqueda].valor,' ');
                end;
                writeLn;
            end;
        end
    else
        writeLn('La matriz no es cuadrada.');
end;



// Programa principal


var
    ELEMENTOS: TV; 
    N,M,K: byte;

begin
    leerArchivo(ELEMENTOS,N,M,K);

    // Inciso a
    writeLn('Matriz leida de archivo: ');
    imprimirMatriz (ELEMENTOS, N,M,K);

    // Inciso b
    trasponerMatriz (ELEMENTOS, N,M,K);
end.