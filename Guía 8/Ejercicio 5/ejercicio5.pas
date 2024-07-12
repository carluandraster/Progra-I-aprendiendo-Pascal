{Sea V un arreglo de enteros, mediante procesos recursivos se pide:
a) Calcular e informar la suma de sus elementos.
b) Mostrar sus elementos.
c) Mostrarlos en orden inverso.
d) Obtener el máximo de sus elementos.
e) Obtener el promedio. }


Program ejercicio5;

const
    tope = 100;

type
    TV = array [1..tope] of integer;

// Subprogramas

procedure leerArchivo (var V: TV; var N: byte);
var
    archivo: text;
begin
    // Inicializar variable
    N:=0;

    // Abrir archivo
    assign(archivo,'numeros.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        read(archivo,V[N]);
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Calcular e informar la suma de sus elementos.

function suma (V: TV; N: byte): integer;
begin
    if N<=1 then
        suma:=V[1]
    else
        suma:=V[N]+suma(V,N-1);
end;

// b) Mostrar sus elementos.

procedure imprimirArreglo (V: TV; N: byte);
begin
    if N>1 then
    begin
        // Resolver a la vuelta
        imprimirArreglo(V,N-1);
        write(V[N],' ');
    end
    else
        write(V[1],' ');
end;

// c) Mostrarlos en orden inverso.

procedure invertirArreglo (V: TV; N: byte);
begin
    if N>1 then
    begin
        // Resolver a la ida
        write(V[N],' ');
        invertirArreglo(V,N-1);
    end
    else
        write(V[1],' ');
end;

// d) Obtener el máximo de sus elementos.

function maximo (V: TV; N: byte): integer;
begin
    if N=1 then
        maximo:=V[1]
    else
        if V[N]>maximo(V,N-1) then
            maximo:=V[N];
end;

// e) Obtener el promedio

function promedio (V: TV; N: byte): real;
begin
    promedio:=suma(V,N)/N;
end;



// Programa principal


var
    V: TV;
    N: byte;

begin
    leerArchivo(V,N);

    // Inciso a
    writeLn('Sumatoria de los elementos de la matriz: ',suma(V,N));

    // Inciso b
    writeLn('Arreglo extraido del archivo: ');
    imprimirArreglo (V, N);
    writeLn;

    // Inciso c
    writeLn('Arreglo escrito al reves: ');
    invertirArreglo(V, N);
    writeLn;

    // Inciso d
    writeLn('Maximo: ',maximo(V,N));

    // Inciso e
    writeLn('Promedio: ',promedio(V,N):4:2);
end.