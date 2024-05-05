{Sean T1 y T2 dos matrices de NxN que representan las fichas (rojas, azules) de un tablero,
la primera almacena el caracter ‘R’ ó ‘A’ y la segunda enteros (cantidad de fichas). Se pide 
calcular e informar:
a) Color predominante (presente en más casillas)
b) Color con más fichas
c) Cantidad de columnas de un solo color }

Program ejercicio9;

const
    tope = 100;

type
    TMcar = array [1..tope,1..tope] of char;
    TMint = array [1..tope,1..tope] of byte;
    str26 = string[26];
    str49 = string[49];

// Subprogramas

procedure cargarT1 (var T1: TMcar; var N:byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'caracteres.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N);
    for i:=1 to N do
    begin
        for j:=1 to N do
            repeat
                read(archivo,T1[i,j]);
            until T1[i,j]<>' ';
        readLn(archivo);
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure cargarT2(var T2: TMint; N: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'enteros.txt');
    reset(archivo);

    // Leer archivo
    for i:=1 to N do
    begin
        for j:=1 to N do
            read(archivo,T2[i,j]);
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Color predominante (presente en más casillas)

function contarSi(T1: TMcar; condicion: char; N: byte): byte;
var
    i,j,contador: byte;
begin
    // Inicializar variables
    contador:=0;

    // Contar
    for i:=1 to N do
        for j:=1 to N do
            if T1[i,j]=condicion then
                contador:=contador+1;
    
    // Devolver resultado
    contarSi:=contador;
end;

function colorPredominante(T1: TMcar; N: byte):str26;
var
    contaR,contaA: byte;
begin
    // Inicializar variables
    contaR:=contarSi(T1,'R',N);
    contaA:=contarSi(T1,'A',N);

    // Devolver resultado
    if contaR>contaA then
        colorPredominante:='Color predominante: rojo.'
    else
        if contaR<contaA then
            colorPredominante:='Color predominante: azul.'
        else
            colorPredominante:='No hay color predominante.';
end;

// b) Color con más fichas

function acumularSi(T1: TMcar; T2: TMint; condicion: char; N: byte): byte;
var
    i,j,acumulador: byte;
begin
    // Inicializar variables
    acumulador:=0;

    // Acumular
    for i:=1 to N do
        for j:=1 to N do
            if T1[i,j]=condicion then
                acumulador:=acumulador+T2[i,j];
    
    // Devolver resultado
    acumularSi:=acumulador;
end;

function maximo (T1: TMcar; T2: TMint; N: byte):str49;
var
    acumR,acumA: byte;
begin
    // Inicializar variables
    acumR:=acumularSi(T1,T2,'R',N);
    acumA:=acumularSi(T1,T2,'A',N);

    // Devolver resultado
    if acumR>acumA then
        maximo:='Color con mas fichas: rojo.'
    else
        if acumR<acumA then
            maximo:='Color con mas fichas: azul.'
        else
            maximo:='Ambos colores tienen la misma cantidad de fichas.';
end;

// c) Cantidad de columnas de un solo color

function unSoloColor(T1: TMcar;N,columna: byte):boolean;
var
    i: byte;
    color: char;
begin
    color:=T1[1,columna];
    i:=2;
    while (i<=N) and (T1[i,columna]=color) do
        i:=i+1;
    unSoloColor:=i>N;
end;

function contarColumnas (T1: TMcar; N: byte): byte;
var
    j,contador: byte;
begin
    // Inicializar variables
    contador:=0;

    // Recorrer matriz
    for j:=1 to N do
        if unSoloColor(T1,N,j) then
            contador:=contador+1;
    
    // Devolver resultado
    contarColumnas:=contador;
end;

// Programa principal

var
    T1: TMcar;
    T2: TMint;
    N:byte;

begin
    // Cargar matrices desde los archivos
    cargarT1(T1,N);
    cargarT2(T2,N);

    // Inciso a
    writeLn(colorPredominante(T1,N));

    // Inciso b
    writeLn(maximo(T1,T2,N));

    // Inciso c
    writeLn('Columnas de un solo color: ',contarColumnas(T1,N));
end.