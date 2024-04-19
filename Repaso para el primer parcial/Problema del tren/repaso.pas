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

procedure leerArchivo (var DNIS: TVstr; var ASIENTOS,EDADES: TVbyte; var PESOS: TVreal;
var N,cantidad: byte);
var
    archivo:text;
    i,j,edad,contador:byte;
    codigo,anterior:str4;
    blanco:char;
    dni:str8;
    peso:real;
begin
    // Inicializar variables
    i:=0;
    j:=N+1;
    anterior:='';
    cantidad:=0;
    contador:=0;

    // Reconocer archivo de texto
    assign(archivo,'CHECKIN.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N);
    while not eof(archivo) do
    begin
        readLn(archivo,codigo,blanco,dni,edad,peso);
        if codigo<>anterior then
        begin
            contador:=contador+1;
            anterior:=codigo;
        end;
        cantidad:=cantidad+1;
        DNIS[cantidad]:=dni;
        EDADES[cantidad]:=edad;
        PESOS[cantidad]:=peso;
        if odd(contador) then
        begin
            i:=i+1;
            ASIENTOS[cantidad]:=i;
        end
        else
        begin
            j:=j-1;
            ASIENTOS[cantidad]:=j;
        end;
    end;

    // Cerrar archivo
    close(archivo);
end;

{a) Dado un DNI, encontrar entre los asientos ocupados cuál es el nro de asiento que se le
asignó. Si no existe, informar “No realizó el checkin”.}
function buscar (x:str8;DNIS: TVstr;ASIENTOS: TVbyte;cantidad:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantidad) and (DNIS[i]<>x) do
        i:=i+1;
        
    if DNIS[i]<>x then
        buscar:=0
    else
        buscar:=ASIENTOS[i];
end;

{b) Para un rango de pesos P1 y P2, informar el promedio de la edad de los pasajeros cuyo
equipaje de mano tiene un peso que pertenece al rango dado.}
function promediarSi (P1,P2:real; EDADES: TVbyte; PESOS: TVreal; cantidad:byte):real;
var
    i,contador:byte;
    acumulador:word; {Ya con 3 octogenarios acumulás alrededor de 255 años de edad}
begin
    // Inicializar variables
    contador:=0;
    acumulador:=0;

    // Recorrer arreglo de pesos
    for i:=1 to cantidad do
        if (P1<PESOS[i]) and (PESOS[i]<P2) then
        begin
            contador:=contador+1;
            acumulador:=acumulador+EDADES[i];
        end;
    
    // Sacar un promedio y devolverlo como resultado
    if contador<>0 then
        promediarSi:= acumulador/contador
    else
        promediarSi:=-1;
end;

// c) Informar el DNI de los 3 pasajeros que llevan mayor peso de equipaje de mano
function maximoIn (PESOS:TVreal;cantidad:byte):byte;
var
    i:byte;
    max:real;
begin
    max:=-1;
    for i:=1 to cantidad do
        if PESOS[i]>max then
        begin
            max:=PESOS[i];
            maximoIn:=i;
        end;
end;

procedure eliminarStr (indice:byte; var A:TVstr; var cantidad:byte);
var
    i:byte;
begin
    for i:=indice to cantidad do
        A[i]:=A[i+1];
end;

procedure eliminarReal (indice:byte; var A:TVReal; var cantidad:byte);
var
    i:byte;
begin
    for i:=indice to cantidad do
        A[i]:=A[i+1];
    cantidad:=cantidad-1;
end;

procedure maximos (DNIS:TVstr; PESOS:TVreal; cantidad:byte);
var
    i,j:byte;
begin
    for j:=1 to 3 do
    begin
        i:= maximoIn(PESOS,cantidad);
        writeLn(DNIS[i]);
        eliminarStr(i,DNIS,cantidad);
        eliminarReal(i,PESOS,cantidad);
    end;
end;

// Procedimientos de escritura

procedure incisoA(DNIS:TVstr;ASIENTOS:TVbyte;cantidad:byte);
var
    x:str8;
    busqueda:byte;
begin
    writeLn('Ingrese un DNI: ');
    readLn(x);
    busqueda:=buscar(x,DNIS,ASIENTOS,cantidad);
    if busqueda = 0 then
        writeLn('No realizo el chekin')
    else
        writeLn('Se le asigno el asiento ',busqueda);
end;

procedure incisoB(EDADES: TVbyte; PESOS: TVreal; cantidad:byte);
var
    promedio,P1,P2:real;
begin
    // Ingreso de datos
    repeat
        writeLn('Ingrese un peso minimo: ');
        readLn(P1);
    until P1>=0;
    repeat
        writeLn('Ingrese un peso maximo: ');
        readLn(P2);
    until P2>=0;

    // Procesamiento
    promedio:=promediarSi (P1,P2,EDADES,PESOS,cantidad);

    // Salida
    if promedio=-1 then
        writeLn('Ninguna maleta pesa entre ',P1:3:2,' y ',P2:3:2)
    else
        writeLn('Las maletas de entre ',P1:3:2,' y ',P2:3:2,' de peso son de personas de ',promedio:2:0,' anios de edad promedio.');
end;

// Programa principal

var
    DNIS: TVstr;
    ASIENTOS,EDADES: TVbyte;
    PESOS: TVreal;
    N,cantidad: byte;
    

begin
    leerArchivo(DNIS, ASIENTOS,EDADES, PESOS, N,cantidad);
    incisoA(DNIS,ASIENTOS,cantidad);
    incisoB(EDADES, PESOS, cantidad);
    writeLn('Las 3 personas que llevan mayor peso de maleta son: ');
    maximos (DNIS, PESOS, cantidad);
end.