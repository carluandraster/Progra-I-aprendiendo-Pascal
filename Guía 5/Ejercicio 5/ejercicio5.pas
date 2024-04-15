{ Dado un archivo de enteros, almacenarlos en un arreglo, luego obtener el promedio de todos los
números divisores del máximo y con ellos armar otro arreglo. Mostrar ambos arreglos y el
promedio obtenido. }

Program ejercicio5;

type
    TV= array[1..255] of integer;

// Subprogramas

procedure leerArchivo(var A:TV;var N:byte);
var
    i:byte;
    archivo:text;
begin
    // Inicializar variable
    i:=1;

    // Archivo de texto
    assign(archivo,'enteros.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,A[i]);
        i:=i+1;
    end;

    // Cantidad de elementos del array
    N:=i-1;
end;

function maximo(A:TV;N:byte): integer;
var
    max:integer;
    i:byte;
begin
    // Inicializar variables
    max:=-32768;

    // Recorrer arreglo
    for i:=1 to N do
        if A[i]>max then
            max:=A[i];
    
    // Devolver maximo
    maximo:=max;
end;

procedure divisores(numero:integer; var B:TV; var N:byte);
var
    i:word;
    j:byte;
begin
    // Quitar signo al numero
    numero:=abs(numero);

    // Inicializar variable
    j:=1;

    // Armar un arreglo de los divisores del numero
    for i:=1 to numero do
        if numero mod i =0 then
        begin
            B[j]:=i;
            j:=j+1;
        end;
    
    // Devolver cuantos numeros tiene el arreglo
    N:=j-1;
end;

function promedio(A:TV;N:byte):real;
var
    i:byte;
    acumulador:word;
begin
    // Inicializar variable
    acumulador:=0;

    // Sumar todos los elementos del arreglo
    for i:=1 to N do
        acumulador:=acumulador+A[i];
    
    // Obtener romedio
    promedio:=acumulador/N;
end;

procedure mostrarArreglo(A:TV;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        writeLn(A[i]);
end;

// Programa principal

var
    A,B:TV;
    max:integer;
    N,M:byte;
    prom:real;

begin
    // Dado el archivo de enteros, almacenarlos en un arreglo
    leerArchivo(A,N);

    // Obtener el promedio de todos los números divisores del máximo y con ellos armar otro arreglo
    max:=maximo(A,N);
    divisores(max,B,M);
    prom:=promedio(B,M);

    // Mostrar ambos arreglos y el promedio obtenido
    writeLn('Los numeros extraidos del archivo son: ');
    mostrarArreglo(A,N);

    writeLn('Los divisores del numero mas grande son: ');
    mostrarArreglo(B,M);

    writeLn('Promedio de divisores del numero mas grande: ',prom:0:2);
end.