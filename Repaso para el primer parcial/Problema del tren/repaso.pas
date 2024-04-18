{En un archivo de texto, CHECKIN.TXT se encuentran detallados los pasajeros que deben realizar
el checkin de un determinado tren turístico.
En la primera línea del archivo aparecen la cantidad de asientos del tren turístico (N)
Luego, agrupados por reserva, se detalla en cada línea:

RESERVA [ANU4, puede repetirse, incluyendo más de un DNI]
DNI [ANU8]
Edad
Peso Equipaje de Mano [Númerico]
El tren tiene un asiento por fila y estos están numerados del 1 a N.

Con el fin de balancear el peso del tren, se debe ubicar a los pasajeros según el criterio:

El primero que llega, debe ocupar el primer asiento y mientras el código de reserva no cambie,
se siguen ubicando consecutivamente detrás de dicho pasajero.
Al cambiar el código de reserva, se deben ubicar los pasajeros al fondo del tren, desde el último
asiento hacia el centro.
Se debe continuar con esta acción llenando el tren, desde los extremos hacia el centro.
Se pide, completar el checkin del tren para luego resolver mediante un subprograma por inciso:

a) Dado un DNI, encontrar entre los asientos ocupados cuál es el nro de asiento que se le asignó.
Si no existe, informar “No realizó el checkin”.
b) Para un rango de pesos P1 y P2, informar el promedio de la edad de los pasajeros cuyo equipaje
de mano tiene un peso que pertenece al rango dado.
c) Informar el DNI de los 3 pasajeros que llevan mayor peso de equipaje de mano}

Program repaso;

const
    tope = 255;

type
    str4 = string[4];
    str8 = string[8];
    TVstr = array [1..tope] of str8;
    TVbyte = array [1..tope] of byte;
    TVreal = array [1..tope] of real;

// Subprogramas

procedure leerArchivo (var DNIS: TVstr; var EDADES: TVbyte; var PESOS: TVreal; var i,j,N: byte);
var
    archivo:text;
    edad,contador:byte;
    codigo,anterior:str4;
    procedimiento: TProc;
    blanco:char;
    dni:str8;
    peso:real;
begin
    // Inicializar variables
    i:=0;
    j:=N+1;
    anterior:='    ';

    // Reconocer archivo de texto
    assign(archivo,'CHECKIN.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,N);
    while not eof(archivo) do
    begin
        readLn(archivo,codigo,blanco,dni,edad,peso);
        if codigo<>anterior then
        begin
            contador:=contador+1;
            anterior:=codigo;
        end;
        if odd(contador) then
        begin
            i:=i+1;
            DNIS[i]:=dni;
            EDADES[i]:=edad;
            PESOS[i]:=peso;
        end
        else
        begin
            j:=j-1;
            DNIS[j]:=dni;
            EDADES[j]:=edad;
            PESOS[j]:=peso;
        end;
    end;

    // Cerrar archivo
    close(archivo);
end;

{a) Dado un DNI, encontrar entre los asientos ocupados cuál es el nro de asiento que se le
asignó. Si no existe, informar “No realizó el checkin”.}
function buscar (x:str8;DNIS: TVstr;i,j,N:byte):byte;
var
    k:byte;
begin
    k:=1;
    while (k<=N) and (DNIS[k]<>x) do
    begin
        if k=i then
            k:=j
        else
            k:=k+1;
    end;
        
    if DNIS[k]<>x then
        buscar:=0
    else
        buscar:=k;
end;

{b) Para un rango de pesos P1 y P2, informar el promedio de la edad de los pasajeros cuyo
equipaje de mano tiene un peso que pertenece al rango dado.}
function promediarSi (P1,P2:real; EDADES: TVbyte; PESOS: TVreal; i,j,N:byte):real;
var
    k,contador:byte;
    acumulador:word; {Ya con 3 octogenarios acumulás alrededor de 255 años de edad}
begin
    // Inicializar variables
    contador:=0;
    acumulador:=0;

    // Recorrer arreglo de pesos
    for k:=1 to i do
        if (P1<PESOS[k]) and (PESOS[k]<P2) then
        begin
            contador:=contador+1;
            acumulador:=acumulador+EDADES[k];
        end;
    for k:=j to N do
        if (P1<PESOS[k]) and (PESOS[k]<P2) then
        begin
            contador:=contador+1;
            acumulador:=acumulador+EDADES[k];
        end;
    
    // Sacar un promedio y devolverlo como resultado
    if contador<>0 then
        promediarSi:= acumulador/contador
    else
        promediarSi:=-1;
end;

// c) Informar el DNI de los 3 pasajeros que llevan mayor peso de equipaje de mano