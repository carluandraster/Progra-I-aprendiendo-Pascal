{ Dado un archivo de números enteros no nulos, almacenar en un arreglo A aquellos que
formen una secuencia ascendente. A partir de A generar B con la misma cantidad de
elementos de A pero poniendo ceros en aquellas componentes simétricas donde la simétrica
derecha no sea múltiplo de la izquierda. Escribir ambos arreglos. }

Program ejercicio9;

type
    TV = array [1..255] of integer;

// Subprogramas

// Leer del archivo y almacenar en un arreglo A aquellos que formen una secuencia ascendente
procedure leerArchivo(var A:TV; var N:byte);
var
    i:byte;
    archivo:text;
    numero:integer;

begin
    // Inicializar variables
    i:=1;

    // Archivo de texto
    assign(archivo,'numeros.txt');
    reset(archivo);

    // Lectura de texto
    while not eof(archivo) do
    begin
        read(archivo,numero);
        if (i=1) or (numero>A[i-1]) then
        begin
            A[i]:=numero;
            i:=i+1;
        end;
    end;

    // Devolver longitud de arreglo
    N:=i-1;

    // Cerrar archivo
    close(archivo);
end;

{A partir de A generar B con la misma cantidad de elementos de A pero poniendo ceros en
aquellas componentes simétricas donde la simétrica derecha no sea múltiplo de la izquierda}
procedure generarB(A:TV; N:byte; var B:TV);
var
    i:byte;

begin
    for i:=1 to (N div 2 + N mod 2) do
    begin
        if (A[N-i+1] mod A[i])<>0 then
        begin
            B[i]:=0;
            B[N-i+1]:=0;
        end
        else
        begin
            B[i]:=A[i];
            B[N-i+1]:=A[N-i+1];
        end;
    end;
end;

// Escribir ambos arreglos
procedure escribirArray(A:TV;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        write(A[i],' ');
end;

// Programa principal

var
    A,B:TV;
    N:byte;

begin
    leerArchivo(A,N);
    generarB(A,N,B);

    // Mostrar arreglo A
    write('Vector A: ');
    escribirArray(A,N);

    writeLn();

    // Mostrar arreglo B
    write('Vector B: ');
    escribirArray(B,N);
end.