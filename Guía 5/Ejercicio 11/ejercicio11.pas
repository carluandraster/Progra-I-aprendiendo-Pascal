{De una competencia de atletismo se tienen los siguientes datos del lanzamiento de jabalina:
• Nombre del competidor (ordenado ascendentemente por este dato)
• 1º lanzamiento
• 2º lanzamiento
Se pide:
a) Cuántos competidores superaron con el 2º lanzamiento el 1º.
b) Nombre del atleta que registró la mejor marca.
c) Dado el Nombre de un atleta, informar la marca que realizó en ambos lanzamientos.
d) Generar un nuevo arreglo con los participantes que pasaron a la semifinal (aquellos que
superaron una marca X establecida en el 1º ó 2º lanzamiento). Mostrar ambos arreglos. }

Program ejercicio11;

type
    TVstr = array [1..255] of string;
    TVreal = array [1..255] of real;

// Subprogramas

procedure leerArchivo(var A:TVstr; var B,C:TVreal; var N:byte);
var
    archivo:text;
begin
    // Inicializar variable de control
    N:=0;

    // Inicializar archivo de texto
    assign(archivo,'lanzamientos.txt');
    reset(archivo);

    // Lectura de archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N]);
        readLn(archivo,B[N]);
        readLn(archivo,C[N]);
    end;

    // Cerrar archivo de texto
    close(archivo);
end;

// a) Cuántos competidores superaron con el 2º lanzamiento el 1º.
function cont_mejoras(B,C:TVreal; N:byte):byte;
var
    i,contador:byte;
begin
    // Inicializar contador
    contador:=0;

    // Recorrer arreglos y contar
    for i:=1 to N do
        if C[i]>B[i] then
            contador:=contador+1;
    
    // Devolver resultado final
    cont_mejoras:=contador;
end;

// b) Nombre del atleta que registró la mejor marca.
function mejorMarca(A: TVstr; B,C: TVreal; N:byte):string;
var
    i:byte;
    maximo:real;
    mejorAtleta:string;

begin
    // Inicializar maximo
    maximo:=-1;

    // Recorrer arreglos en busca de la mejor marca
    for i:=1 to N do
    begin
        if B[i] > maximo then
        begin
            maximo:=B[i];
            mejorAtleta:=A[i];
        end;
        if C[i] > maximo then
        begin
            maximo:=C[i];
            mejorAtleta:=A[i];
        end;
    end;

    // Devolver resultado
    mejorMarca:=mejorAtleta;
end;

// c) Dado el Nombre de un atleta, informar la marca que realizó en ambos lanzamientos.

function busqueda(nombre:string; A:TVstr; N:byte):byte;
var
    i,inicio,fin:byte;

begin
    // Inicializar variables
    inicio:=1;
    fin:=N;

    // Busqueda binaria
    repeat
        i:=(fin-inicio) div 2 + inicio;
        if nombre<A[i] then
            fin:=i
        else
            if nombre>A[i] then
                inicio:=i;
    until (nombre=A[i]) or (inicio=fin);

    // Si no se encontró a la persona, devolver 0
    if nombre<>A[i] then
        i:=0;
    
    // Devolver resultado
    busqueda:=i;
end;

procedure informacion(nombre:string; A:TVstr; N:byte; B,C:TVreal);
var
    i:byte;
begin
    i:=busqueda(nombre,A,N);
    if i<>0 then
    begin
        writeLn('Primera marca: ',B[i]:0:2);
        writeLn('Segunda marca: ',C[i]:0:2);
    end
    else
        writeLn('Lo sentimos, no pudimos encontrar a ',nombre);
end;

{d) Generar un nuevo arreglo con los participantes que pasaron a la semifinal (aquellos que
superaron una marca X establecida en el 1º ó 2º lanzamiento)}
procedure semifinal(A:TVstr; B,C: TVreal; N:byte; var D:TVstr; var j:byte);
var
    i:byte;
    X:real;
begin
    // Inicializar variable de control
    j:=0;

    // Ingresar X por teclado y validarlo
    repeat
        writeLn('Ingrese marca minima para clasificar: ');
        readLn(X);
    until X>0;

    // Recorrer arreglos
    for i:=1 to N do
        if (B[i]>X) or (C[i]>X) then
        begin
            j:=j+1;
            D[j]:=A[i];
        end;
end;

// Mostrar arreglo
procedure imprimirArr(A: TVstr; N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        writeLn(A[i]);
end;

// Programa principal

var
    A,D:TVstr;
    B,C:TVreal;
    N,M:byte;
    nombre:string;

begin
    leerArchivo(A,B,C,N);
    writeLn(cont_mejoras(B,C,N),' competidores superaron con el 2do lanzamiento el 1ro');
    writeLn('El atleta que registro la mejor marca fue ',mejorMarca(A,B,C,N));
    writeLn('Ingrese el nombre de algun atleta: ');
    readLn(nombre);
    informacion(nombre,A,N,B,C);
    semifinal(A,B,C,N,D,M);
    writeLn('Listado de jugadores que compitieron: ');
    imprimirArr(A,N);
    writeLn('Listado de jugadores que clasificaron: ');
    imprimirArr(D,M);
end.