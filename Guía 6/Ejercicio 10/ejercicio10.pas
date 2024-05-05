{Dado el siguiente procedimiento:
Procedure Maximo (Mat:TM; N:Byte; Func:TFunc; var maxk:Byte);
Var
max, prom: real;
k: byte;
Begin
 max:= Func(Mat, 1, N);
 maxk:= 1;
 For k:= 2 to N do
 Begin
 prom := Func(Mat, k, N);
 if max < prom then
 begin
 max := prom;
 maxk := k;
 end;
 end;
End;
a) Desarrollar las funciones de tipo TFunc y un programa completo (incluir declaraciones,
directivas al compilador, etc) que utilizándolas calcule para una matriz cuadrada:
i. la fila de máximo promedio
ii. la columna de máximo promedio
b) Indicar las modificaciones que serían necesarias para utilizar un tipo procedimiento, en
lugar de TFunc, muestre los cambios para el punto i. del inciso a) }

Program ejercicio10;

const
    tope = 100;

type
    TM = array[1..tope,1..tope] of byte;
    TFunc = function (Mat: TM; k,N: byte): real;

// Subprogramas

procedure leerArchivo(var Mat: TM; var N: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'matriz.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N);
    for i:=1 to N do
        for j:=1 to N do
            read(archivo,Mat[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

Procedure Maximo (Mat:TM; N:Byte; Func:TFunc; var maxk:Byte);
Var
    max, prom: real;
    k: byte;
Begin
    max:= Func(Mat, 1, N);
    maxk:= 1;
    For k:= 2 to N do
    Begin
        prom := Func(Mat, k, N);
        if max < prom then
        begin
            max := prom;
            maxk := k;
        end;
    end;
End;

function promedioFila (Mat: TM; indice,N:byte):real;
var
    suma,i:byte;
begin
    // Inicializar variables
    suma:=0;

    // Recorrer fila
    for i:=1 to N do
        suma:=suma+Mat[indice,i];

    // Devolver resultado
    promedioFila:=suma/N;
end;

function promedioColumna (Mat: TM; indice,N:byte):real;
var
    suma,i:byte;
begin
    // Inicializar variables
    suma:=0;

    // Recorrer Columna
    for i:=1 to N do
        suma:=suma+Mat[i,indice];

    // Devolver resultado
    promedioColumna:=suma/N;
end;

// Programa principal

var
    Mat: TM;
    N,maxk: byte;
    Func: TFunc;

begin
    leerArchivo(Mat,N);

    // La fila de promedio maximo
    Func:=@promedioFila;
    Maximo (Mat, N, Func, maxk);
    writeLn('La fila de promedio maximo es ',maxk);

    // La columna de promedio maximo
    Func:=@promedioColumna;
    Maximo (Mat, N, Func, maxk);
    writeLn('La columna de promedio maximo es ',maxk);
end.

{b) Indicar las modificaciones que serían necesarias para utilizar un tipo procedimiento, 
en lugar de TFunc, muestre los cambios para el punto i. del inciso a) }
{Para utilizar un tipo procedimiento sería necesario que promedioFila sea procedimiento
y una variable que almacene el promedio de la fila.
Es mejor como está ahora ya que si tengo que devolver un solo resultado es rercomendable
usar una función, no un procedimiento.}