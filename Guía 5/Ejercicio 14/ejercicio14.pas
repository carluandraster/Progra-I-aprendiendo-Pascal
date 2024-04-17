{Una empresa de autos de alquiler grabó en cada línea del archivo la patente del vehículo (cadena
de 7) y el total recaudado en el día. Se pide leer los datos en dos arreglos paralelos e informar:
a) El promedio recaudado por auto.
b) Las patentes de los vehículos que superaron en la recaudación X pesos (X es dato).
c) La patente del que recaudó menos. }

Program ejercicio14;

const
    tope=255;

type
    TVstr = array [1..tope] of string[7];
    TVreal = array [1..tope] of real;

// Subprogramas

procedure leerArchivo(var A:TVstr; var B:TVreal; var N:byte);
var
    archivo:text;
begin
    // Inicializar variable
    N:=0;

    // Reconocer archivo de texto
    assign(archivo,'autos.txt');
    reset(archivo);

    // Leer archivo y guardar en arreglos
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N],B[N]);
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) El promedio recaudado por auto.
function promedio(B:TVreal; N:byte):real;
var
    i:byte;
    suma:real;
begin
    suma:=0;
    for i:=1 to N do
        suma:=suma+B[i];
    promedio:=suma/N;
end;

// b) Las patentes de los vehículos que superaron en la recaudación X pesos (X es dato).
procedure superaron(A:TVstr;B:TVreal;N:byte);
var
    i:byte;
    X:real;
begin
    // ingresar X por teclado
    repeat
        write('Ingrese un monto en pesos: $');
        read(X);
    until X>0;

    write('Los vehiculos que reaudaron mas de $',X:0:2,' son: ');
    // Recorrer array B
    for i:=1 to N do
        if B[i]>X then
            write(A[i],' ');
end;

// c) La patente del que recaudó menos
function minimo(A:TVstr;B:TVreal;N:byte):string;
var
    i:byte;
    min:real;
begin
    min:=999999999999;
    for i:=1 to N do
        if B[i]<min then
        begin
            min:=B[i];
            minimo:=A[i];
        end;
end;

// Programa principal

var
    A:TVstr; B:TVreal;
    N:byte;

begin
    leerArchivo(A,B,N);
    writeLn('El promedio recaudado por auto es de $',promedio(B,N):0:2);
    superaron(A,B,N);
    writeLn();
    writeLn('El auto que menos recaudo es ',minimo(A,B,N));
end.