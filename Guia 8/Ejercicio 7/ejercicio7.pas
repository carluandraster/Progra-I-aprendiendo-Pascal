{ Crear una función recursiva que busque el elemento mínimo de una matriz
cuadrada. }


Program ejercicio7;

const
    tope = 20;

type
    TM = array [1..tope] of byte;



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

function minBorde (matriz: TM; i,j,N: byte): byte;
begin
    if (i=1) and (j=N) then
        minBorde:=matriz[i,j]
    else
        if matriz[N,1]<minBorde(matriz)
end;

function minimo (matriz: TM; N: byte): byte;
begin
    if N=1 then
        minimo:=matriz[1,1]
    else

end;