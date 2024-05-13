program ejercicio2;

const
    tope = 10;

type
    TV = array [1..tope] of byte;
    TM = array [1..tope,1..tope] of byte;


// Subprogramas

procedure cargarMatriz (var Mat: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,Mat[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

procedure cargarVector (var Vec: TV; N: byte);
var
    archivo: text;
    i: byte;
begin
    // Abrir archivo
    assign(archivo,'vector.txt');
    reset(archivo);

    // Leer archivo
    for i:=1 to N do
        read(archivo,Vec[i]);
    
    // Cerrar archivo
    close(archivo);
end;

// Dada una fila i, determinar si sus elementos son múltiplos de Vec[i]

function sonMultiplo (Mat: TM; Vec: TV; N,M,i,j: byte): boolean;
begin
    if Mat[i,j] mod Vec[i] = 0 then
        if j=1 then
            sonMultiplo:=true
        else
            sonMultiplo:=sonMultiplo(Mat,Vec,N,M,i,j-1)
    else
        sonMultiplo:=false;
end;

// Contar filas tales que la función anterior sea verdadera

function ContarSi (Mat: TM; Vec: TV; N,M,i: byte): byte;
begin
    if i>0 then
        if sonMultiplo(Mat,Vec,N,M,i,M) then
            ContarSi:=1+ContarSi(Mat,Vec,N,M,i-1)
        else
            ContarSi:=ContarSi(Mat,Vec,N,M,i-1)
    else
        ContarSi:=0;
end;


// Programa principal

var
    Mat: TM;
    Vec: TV;
    N,M: byte;

begin
    // Ingresar datos por archivo
    cargarMatriz(Mat,N,M);
    cargarVector(Vec,N);

    // Imprimir respuesta
    writeLn('En la matriz hay ',ContarSi(Mat,Vec,N,M,N),' filas que cumplen la condicion.');
end.