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
    TVbyte = array [1..tope] of byte;
    TV4 = array [1..4] of word;
    TM = array [1..tope,1..4] of real;

// Programa principal

function buscar (x:word; A:TVword; N: byte):byte;
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

procedure limpiarVectorContador(var A: TVbyte);
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
    limpiarVector4(comprasPorRubro);
    limpiarVectorContador(comprasPorCliente);

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
            i:=N;
        end;
        NroCli[i]:=codigo;
        Compras[i,rubro]:=Compras[i,rubro]+monto;
        comprasPorCliente[i]:=comprasPorCliente[i]+1;
        comprasPorRubro[rubro]:=comprasPorRubro[rubro]+1;
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Total de compras en cada rubro

procedure imprimirArreglo(comprasPorRubro: TV4);
begin
    writeLn('Total de compras en cada rubro:');
    writeLn('Supermecados: ',comprasPorRubro[1],' compras.');
    writeLn('Combustible: ',comprasPorRubro[2],' compras.');
    writeLn('Indumentaria: ',comprasPorRubro[3],' compras.');
    writeLn('Otros: ',comprasPorRubro[4],' compras.');
end;

// b) Listado con los clientes en los cuales el monto en Supermercado (1) superó a Indumentaria (3)

procedure mostrarClientes (NroCli: TVword; Compras: TM; N: byte);
var
    i:byte;
begin
    writeLn('Los clientes cuyo monto en supermercado supero a indumentaria son:');
    for i:=1 to N do
        if Compras[i,1]>Compras[i,3] then
            writeLn(NroCli[i]);
end;

// c) Promedio de compra por cliente. 

procedure promedio (NroCli: TVword; Compras: TM; comprasPorCliente: TVbyte; N: byte);
var
    i,j:byte;
    suma:real;
begin
    writeLn('Los promedios de compra por cliente son: ');
    for i:=1 to N do
    begin
        suma:=0;
        for j:=1 to 4 do
            suma:=suma+Compras[i,j];
        writeLn(NroCli[i],': $',suma/comprasPorCliente[i]:6:2);
    end;
end;

// d) Número de cliente que más consumió.

function maximo (NroCli: TVword; Compras: TM; N: byte):word;
var
    maxAux,suma:real;
    i,j:byte;
begin
    maxAux:=-1;
    for i:=1 to N do
    begin
        suma:=0;
        for j:=1 to 4 do
            suma:=suma+Compras[i,j];
        if suma>maxAux then
        begin
            maxAux:=suma;
            maximo:=NroCli[i];
        end;
    end;
end;

// e) Cuántos clientes no registraron compras en algún rubro

function contarSi (Compras: TM; N:byte):byte;
var
    contador,i:byte;
begin
    contador:=0;
    for i:=1 to N do
        if (Compras[i,1]=0) and (Compras[i,2]=0) and (Compras[i,3]=0) then
            contador:=contador+1;
    contarSi:=contador;
end;

// Programa principal

var
    NroCli: TVword; 
    Compras: TM; 
    N: byte;
    comprasPorCliente: TVbyte; 
    comprasPorRubro: TV4;

begin
    leerArchivo (NroCli,Compras,N,comprasPorCliente,comprasPorRubro);

    // Inciso a
    imprimirArreglo(comprasPorRubro);

    // Inciso b
    mostrarClientes(NroCli, Compras, N);

    // Inciso c
    promedio (NroCli,Compras,comprasPorCliente,N);

    // Inciso d
    writeLn('Numero de cliente que mas consumio: ',maximo (NroCli,Compras,N));

    // Inciso e
    writeLn(contarSi (Compras, N),' clientes no registraron compras en ningun rubro');
end.