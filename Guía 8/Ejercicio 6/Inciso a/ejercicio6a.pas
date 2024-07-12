{Sea A un arreglo de reales y un valor X real ingresado por teclado, se pide 
determinar en qué posición se encuentra X, devolver 0 en caso de no encontrarlo.
Implementar:
a) considerando el arreglo desordenado, una búsqueda lineal recursiva. }

Program ejercicio6a;

const
    tope = 100;

type
    TV = array [1..tope] of real;


// Subprogramas

procedure leerArchivo (var A: TV; var N: byte);
var
    archivo: text;
begin
    // Inicializar variable
    N:=0;

    // Abrir archivo
    assign(archivo,'arreglo.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N]);
    end;

    // Cerrar archivo
    close(archivo);
end;

// Busqueda lineal
function busqueda (x:real; A: TV; N: byte):byte;
begin
    if A[N]=x then
            busqueda:=N
    else
        if N=1 then
            busqueda:=0
        else
            busqueda:=busqueda(x,A,N-1);
end;



// Programa principal

var
    x: real;
    A: TV;
    busc,N: byte;

begin
    // Ingresar datos
    leerArchivo(A,N);
    writeLn('Ingrese un numero: ');
    readLn(x);

    // Buscar
    busc:=busqueda(x,A,N);
    if busc = 0 then
        writeLn('No se encontro el numero.')
    else
        writeLn('Posicion: ',busc);
end.