{En un archivo se almacenó el Nombre del alumno y la nota de los K parciales,
pasar los datos a un vector Nbre paralelo a la matriz Notas e informar:
a) Listado de los alumnos que aprobaron los K parciales.
b) Por cada alumno determinar su situación:
 Promociona: si el promedio es >= 7
 Habilita: si promedio >= 5 y < 7; y la K-ésima nota >= 5
 Desaprobado: en otro caso
y generar un arreglo con los nombres de aquellos que promocionaron.}

Program ejercicio2;

const
    maxElem = 100;

type
    str30 = string[30];
    TVstr = array [1.. maxElem] of str30;
    TM = array [1..maxElem,1..maxElem] of byte;

// Subprogramas

procedure leerArchivo (var Notas: TM; var N,K: byte; var  Nbre: TVstr);
var
    archivo: text;
    caracter: char;
    i: byte;
begin
    // Inicializar variables
    N:=0;

    // Reconocer archivo de texto
    assign(archivo,'notas.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,K);
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo);
        read(archivo,caracter);
        repeat
             Nbre[N]:= Nbre[N]+caracter;
            read(archivo,caracter);
        until caracter=' ';
        for i:=1 to K do
            read(archivo,Notas[N,i]);
    end;
end;

// a) Listado de los alumnos que aprobaron los K parciales.

function aproboTodo(Notas: TM; i,K:byte):boolean;
var
    j:byte;
begin
    j:=1;
    while (j<=K) and (Notas[i,j]>=5) do
        j:=j+1;
    aproboTodo:=j>K;
end;

procedure arregloAprobados (Notas: TM; Nbre: TVstr; var aprobados: TVstr; N,K:byte; var M:byte);
var
    i:byte;
begin
    // Inicializar variables
    M:=0;

    // Recorrer arreglo
    for i:=1 to N do
        if aproboTodo(Notas,i,K) then
        begin
            M:=M+1;
            aprobados[M]:=Nbre[i];
        end;
end;

procedure imprimir (aprobados: TVstr; M: byte);
var
    i:byte;
begin
    writeLn('Alumnos que aprobaron todos los parciales: ');
    for i:=1 to M do
        writeLn(aprobados[i]);
end;

// b) Por cada alumno determinar su situación

function promedio (Notas: TM; i,K:byte):real;
var
    acumulador:real;
    j:byte;
begin
    // Inicializar variables
    acumulador:=0;

    // Sumar todas las notas
    for j:=1 to K do
        acumulador:=acumulador+Notas[i,j];
    
    // Devolver promedio
    promedio:=acumulador/K;
end;

procedure situaciones(Notas: TM; Nbre: TVstr; N,K: byte; var promocionados: TVstr; var T:byte);
var
    i:byte;
    prom:real;
begin
    T:=0;
    for i:=1 to N do
    begin
        prom:=promedio(Notas,i,K):
        if prom >= 7 then
        begin
            writeLn(Nbre[i],' promociona');
            T:=T+1;
            promocionados[T]:=Nbre[i];
        end
    end;
end;