{ Una Tarjeta de Crédito tiene información de las compras de sus N clientes en un archivo y
en cada línea se almacenó:
 Número de cliente (puede repetirse)
 Tipo de compras (1=Supermercado, 2=Combustible, 3=Indumentaria, 4=Otros)
 Monto de la compra.
Nota: Un cliente puede registrar más de una compra del mismo tipo.
Leer los datos en un arreglo NroCli paralelo a la matriz acumulativa Compras de Nx4 donde
la 1º columna corresponde a la compra en Supermercado, la 2º a Combustible, la 3º a
Indumentaria y la 4º a Otros. Calcular e Informar:
a) Total de compras en cada rubro.
b) Listado con los clientes en los cuales el monto en Supermercado superó a Indumentaria
c) Promedio de compra por cliente. 
d) Número de cliente que más consumió.
e) Cuántos clientes no registraron compras en algún rubro.}

Program ejercicio5;

const
    tope = 100;

type
    TVword = array [1..tope] of word;
    TVbyte = array [1..tope] of word;
    TV4 = array [1..4] of word;
    TM = array [1..tope,1..4] of real;

// Programa principal

function buscar (x:word; A:TV; N: byte):byte;
var
    i:byte;
begin
    // Inicializar variables
    buscar:=0;
    i:=1;

    // Recorrer el arreglo en busca del elemento
    while (i<=N) and (A[i]<>x) do
        i:=i+1;
    
    // Devolver resultado
    if A[i]=x then
        buscar:=i;
end;

procedure limpiarMatriz(var matriz: TM);
var
    i,j:byte;
begin
    for i:=1 to tope do
        for j:=1 to 4 do
            matriz[i,j]:=0;
end;

procedure limpiarVector4(var A: TV4);
var
    i: byte;
begin
    for i:=1 to 4 do
        A[i]:=0;
end;

procedure leerArchivo (var NroCli: TVword; var Compras: TM; var N: byte;
var comprasPorCliente: TVbyte; var comprasPorRubro: TV4);
var
    archivo: text;
    i,rubro: byte;
    codigo: word;
    monto: real;
begin
    // Inicializar variables
    N:=0;
    limpiarMatriz(Compras);

    // Abrir archivo
    assign(archivo,'info_clientes.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,codigo,rubro,monto);
        i:= buscar(codigo,NroCli,N);
        if i=0 then
        begin
            N:=N+1;
            NroCli[N]:=codigo;
            case rubro of

        end
    end;
end;
