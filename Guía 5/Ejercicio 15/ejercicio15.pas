{Una planta de silos registra el ingreso de camiones de sus clientes con cereal, por cada uno se
tiene:
• Cliente
• Patente del camión
• Tipo de cereal ( 1-trigo, 2-girasol, 3-soja, 4-maiz )
• Toneladas
Se pide que lea los datos desde un archivo y mediante un menú de opciones iterativo calcule e
informe:
a) Porcentaje de toneladas de cada cereal respecto del total.
b) Dada una patente, si es que existe, decir qué tipo de cereal transporta, las toneladas y a
qué cliente pertenece.
c) Generar un arreglo con los clientes que transportaron más de X toneladas, ordenado
alfabéticamente.}

Program ejercicio15;

const
    tope=255;

type
    TVstr= array [1..tope] of string;
    TVbyt= array [1..tope] of byte;
    TVreal= array [1..tope] of real;

// Subprogramas

procedure limpiar(var A:TVstr);
var
    i:byte;
begin
    for i:=1 to tope do
        A[i]:='';
end;

procedure leerArchivo(var A,B:TVstr; var C:TVbyt; var D:TVreal; var N:byte);
var
    archivo:text;
    caracter:char;
begin
    // Inicializar variables y arreglos
    N:=0;
    limpiar(A);
    limpiar(B);

    // Reconocer archivo de texto
    assign(archivo,'camiones.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        N:=N+1;

        // Leer nombre del cliente
        read(archivo,caracter);
        while caracter<>' ' do
        begin
            A[N]:=A[N]+caracter;
            read(archivo,caracter);
        end;

        // Leer patente
        repeat
            read(archivo,caracter);
        until caracter<>' ';

        while caracter<>' ' do
        begin
            B[N]:=B[N]+caracter;
            read(archivo,caracter);
        end;

        // Leer tipo de cereal
        read(archivo,C[N]);

        // Leer toneladas
        read(archivo,D[N]);

        // Saltar a la siguiente linea
        readLn(archivo);
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Porcentaje de toneladas de cada cereal respecto del total.

function sumaTotal(D:TVreal; N:byte):real;
var
    acumulador:real;
    i:byte;
begin
    acumulador:=0;
    for i:=1 to N do
        acumulador:=acumulador+D[i];
    sumaTotal:=acumulador;
end;

function sumarSi(C:TVbyt; D:TVreal; N,condicion:byte):real;
var
    acumulador:real;
    i:byte;
begin
    acumulador:=0;
    for i:=1 to N do
        if condicion=C[i] then
            acumulador:=acumulador+D[i];
    sumarSi:=acumulador;
end;

procedure Porcentaje(C:TVbyt; D:TVreal;N:byte);
var
    sumaTot:real;
begin
    sumaTot:=sumaTotal(D,N);
    writeLn('Trigo: ',sumarSi(C,D,N,1)/sumaTot*100:0:2,'%');
    writeLn('Girasol: ',sumarSi(C,D,N,2)/sumaTot*100:0:2,'%');
    writeLn('Soja: ',sumarSi(C,D,N,3)/sumaTot*100:0:2,'%');
    writeLn('Maiz: ',sumarSi(C,D,N,4)/sumaTot*100:0:2,'%');
end;

{b) Dada una patente, si es que existe, decir qué tipo de cereal transporta, las toneladas y a
qué cliente pertenece.}
function busqueda(x:string;B:TVstr;N:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=N) and (B[i]<>x) do
        i:=i+1;
    if B[i]<>x then
        busqueda:=0
    else
        busqueda:=i;
end;

procedure informacion(A,B:TVstr;C:TVbyt;D:TVreal;N:byte);
var
    patente:string;
    indice:byte;
begin
    writeLn('Ingrese una patente: ');
    readLn(patente);

    indice:=busqueda(patente,B,N);

    if indice=0 then
        writeLn('Lo sentimos pero no pudimos encontrar al camion de patente ',patente)
    else
    begin
        writeLn('Cliente: ',A[indice]);
        case C[indice] of
            1: writeLn('Transporta trigo');
            2: writeLn('Transporta girasol');
            3: writeLn('Transporta soja');
            4: writeLn('Transporta maíz');
        end;
        writeLn('Toneladas que transporta: ',D[indice]:0:2);
    end;
end;

{c) Generar un arreglo con los clientes que transportaron más de X toneladas, ordenado
alfabéticamente}

procedure mayuscula(var A:TVstr;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        A[i]:=upcase(A[i]);
end;

function primero(A:TVstr;comienzo,N:byte):string;
var
    antes:string;
    i:byte;
begin
    antes:='aaa';
    for i:=comienzo to N do
        if A[i]<antes then
            antes:=A[i];
    primero:=antes;
end;

procedure ordenarAlfabeticamente(var A:TVstr;N:byte);
var
    i,j:byte;
    B:TVstr;
    aux:string;
begin
    j:=1;
    B:=A;
    mayuscula(B,N);
    while j<=N do
    begin
        i:=busqueda(primero(B,j,N),B,N);
        aux:=B[j];
        B[j]:=B[i];
        B[i]:=aux;
        aux:=A[j];
        A[j]:=A[i];
        A[i]:=aux;
        j:=j+1;
    end;
end;

procedure masDeX(A:TVstr; D:TVreal; var E:TVstr; var N,j:byte);
var
    X:real;
    i:byte;
begin
    j:=0;
    repeat
        writeLn('Ingrese un peso en toneladas: ');
        readLn(X);
    until X>0;
    for i:=1 to N do
        if D[i]>X then
        begin
            j:=j+1;
            E[j]:=A[i];
        end;
    ordenarAlfabeticamente(E,j);
    write('Los clientes que trasnportaron mas de ',X:0:2,' toneladas son: ');
end;

procedure MostrarE(A:TVstr; D:TVreal; E:TVstr; N:byte);
var
    i,j:byte;
begin
    masDeX(A,D,E,N,j);
    
    for i:=1 to j do
        write(E[i],' ');
    writeLn();
end;

procedure menu(var opcion:byte);
begin
    repeat
        writeLn('Ingrese una opcion');
        writeLn('1 - Ver porcentaje de toneladas de cada cereal respecto del total');
        writeLn('2 - Ver por patente que tipo de cereal transporta, las toneladas y a que cliente pertenece');
        writeLn('3 - Mostrar los clientes que transportaron mas de una cantidad de toneladas');
        writeLn('4 - Salir');
        readLn(opcion);
    until (opcion=1) or (opcion=2) or (opcion=3) or (opcion=4);
end;

// Programa principal

var
    A,B,E:TVstr; C:TVbyt; D:TVreal;
    N,opcion:byte;
begin
    leerArchivo(A,B,C,D,N);
    menu(opcion);
    while opcion<>4 do
    begin
        case opcion of
            1: Porcentaje(C,D,N);
            2: informacion(A,B,C,D,N);
            3: MostrarE(A,D,E,N);
        end;
        menu(opcion);
    end;
end.