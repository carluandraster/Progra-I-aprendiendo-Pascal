{Sea A un arreglo de reales y un valor X real ingresado por teclado, se pide 
determinar en qué posición se encuentra X, devolver 0 en caso de no encontrarlo.
Implementar:
b) para un arreglo ordenado en forma ascendente, una búsqueda binaria recursiva}

Program ejercicio6b;

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

// Busqueda binaria
function busqueda (x: real; A: TV; pri,ult,N: byte): byte;
var
    medio: byte;
begin
    // Inicializar variable
    medio:=(pri+ult) div 2;

    // Divide y vencerás
    if pri<ult then
        if x=A[medio] then
            busqueda:=medio
        else
            if x>A[medio] then
                busqueda:=busqueda(x,A,medio+1,ult,N)
            else
                busqueda:=busqueda(x,A,pri,medio-1,N)
    else
        if x=A[pri] then
            busqueda:=pri
        else
            busqueda:=0;
end;



// Programa principal

var
    A: TV;
    busc,N: byte;
    x: real;

begin
    // Ingresar datos
    leerArchivo(A,N);
    writeLn('Ingrese un numero: ');
    readLn(x);

    // Buscar
    busc:=busqueda(x,A,1,N,N);
    if busc = 0 then
        writeLn('No se encontro el numero.')
    else
        writeLn('Posicion: ',busc);
end.