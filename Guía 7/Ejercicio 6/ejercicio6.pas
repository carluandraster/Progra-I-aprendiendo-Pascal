{ Idem ejercicio 5, leer dos matrices y calcular la matriz resultante de la suma de ambas.}

Program ejercicio6;

const
    tope = 100;

type
    TR = record
        i,j,valor: byte;
    end;

    TV = array [0..tope] of TR;

// Subprogramas

procedure ingresarMatriz1 (var matriz1: TV; var N,M,K: byte);
var
    archivo: text;
begin
    // Inicializar variables
    K:=0;
    matriz1[0].valor:=0;

    // Abrir archivo
    assign(archivo,'matriz1.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    while not eof(archivo) do
    begin
        K:=K+1;
        with matriz1[K] do
            readLn(archivo, i,j,valor);
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure ingresarMatriz2 (var matriz2: TV; var T: byte);
var
    archivo: text;
begin
    // Inicializar variables
    T:=0;
    matriz2[0].valor:=0;

    // Abrir archivo
    assign(archivo,'matriz2.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        T:=T+1;
        with matriz2[T] do
            readLn(archivo, i,j,valor);
    end;

    // Cerrar archivo
    close(archivo);
end;

// Sumar matrices, suponiendo que ambas son de igual dimensiones

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

procedure sumarMatrices (matriz1,matriz2: TV; N,M,K,T: byte);
var
    i,j,busqueda1,busqueda2: byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            busqueda1:= buscar (matriz1,K,i,j);
            busqueda2:= buscar(matriz2,T,i,j);
            write(matriz1[busqueda1].valor+matriz2[busqueda2].valor,' ');
        end;
        writeLn;
    end;    
end;



// Programa principal


var
    matriz1,matriz2: TV;
    N,M,K,T: byte;

begin
    // Ingresar matrices
    ingresarMatriz1(matriz1,N,M,K);
    ingresarMatriz2(matriz2,T);

    // Mostrar suma
    writeLn('La suma de las dos matrices es: ');
    sumarMatrices (matriz1,matriz2, N,M,K,T);
end.