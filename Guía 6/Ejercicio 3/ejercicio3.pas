{En un archivo se almacenaron Y números enteros en cada línea. Cada línea se cargará en
una fila de la matriz si cumple que el primero es divisor del último (el Y-ésimo). 
Mostrar la matriz generada. La dimensión será N x Y (N se debe calcular) }

Program ejercicio3;

const
    tope = 100;

type
    TM = array[1..tope,1..tope] of integer;

// Subprogramas

procedure leerArchivo (var N,Y: byte; var matriz: TM);
var
    archivo:text;
    j: byte;
begin
    // Inicializar variables
    N:=0;

    // Reconocer archivo de texto
    assign(archivo,'numeros.txt');
    reset(archivo);

    // Leer archivo y cargar matriz
    read(archivo,Y);
    while not eof(archivo) do
    begin
        readLn(archivo);
        N:=N+1;
        for j:=1 to Y do
            read(archivo,matriz[N,j]);
        if matriz[N,Y] mod matriz[N,1]<>0 then
            N:=N-1;
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure mostrarMatriz (N,Y: byte; matriz: TM);
var
    i,j:byte;
begin
    writeLn('La matriz generada es:');
    for i:=1 to N do
    begin
        for j:=1 to Y do
            write(matriz[i,j],' ');
        writeLn();
    end;
end;

// Programa principal

var
    N,Y: byte;
    matriz: TM;

begin
    leerArchivo(N,Y,matriz);
    mostrarMatriz(N,Y,matriz);
end.