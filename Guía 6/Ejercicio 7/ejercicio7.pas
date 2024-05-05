{La Secretaría de Transporte quiere evaluar el movimiento de pasajeros en N paradas de colectivo.
En cada una de ellas se detienen M líneas de colectivo. Dispositivos electrónicos han registrado
el movimiento de un día y grabado en un archivo de texto dicha información en tiempo real
(desordenada).
En cada registro se expresa:
 Parada (1..N)
 Línea (1..M)
 Cantidad de pasajeros que ascienden
 Cantidad de pasajeros que descienden
Se pide leer la información del archivo, almacenándola de forma adecuada para calcular e 
informar:
a) Parada con mayor cantidad de pasajeros que bajaron.
b) Línea con menor cantidad de pasajeros que subieron.
c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las
que bajaron.
d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.
Los ítems anteriores se refieren al movimiento de todo el día.
¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que
ascendió o descendió cada vez que se detuvo el colectivo? }

Program ejercicio7;

const
    tope = 100;

type
    TM = array [1..tope,1..tope] of byte;

// Subprogramas

procedure limpiarMatriz(var matriz: TM);
var
    i,j:byte;
begin
    for i:=1 to tope do
        for j:=1 to tope do
            matriz[i,j]:=0;
end;

procedure leerArchivo (var ASCENSOS,DESCENSOS: TM; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Inicializar variables
    limpiarMatriz(ASCENSOS);
    limpiarMatriz(DESCENSOS);

    // Abrir archivo de texto
    assign(archivo,'paradas.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    while not eof(archivo) do
        // Filas: paradas; columnas: lineas
        readLn(archivo,i,j,ASCENSOS[i,j],DESCENSOS[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

// a) Parada con mayor cantidad de pasajeros que bajaron

function sumar (Mat: TM; N: byte; tipo: char; indice:byte): byte;
var
    i:byte;
    sumAux: word;
begin
    sumAux:=0;
    case tipo of
        'F':
            for i:=1 to N do
                sumAux:=sumAux+Mat[indice,i];
        'C':
            for i:=1 to N do
                sumAux:=sumAux+Mat[i,indice];
    end;
    sumar:=sumAux;
end;

function maximo (DESCENSOS: TM; N,M: byte):byte;
var
    i,maxAux,suma:byte;
begin
    // Inicializar variables
    maxAux:=0;

    // Recorrer paradas
    for i:=1 to N do
    begin
        suma:= sumar(DESCENSOS, M,'F',i);
        if suma>maxAux then
        begin
            maxAux:=suma;
            maximo:=i;
        end;
    end;
end;

// b) Línea con menor cantidad de pasajeros que subieron.

function minimo (ASCENSOS: TM; N,M: byte):byte;
var
    i,minAux,suma:byte;
begin
    // Inicializar variables
    minAux:=255;

    // Recorrer paradas
    for i:=1 to M do
    begin
        suma:= sumar(ASCENSOS, N,'C',i);
        if suma<minAux then
        begin
            minAux:=suma;
            minimo:=i;
        end;
    end;
end;

// c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que bajaron

function contarSi (DESCENSOS,ASCENSOS: TM; N,M: byte):byte;
var
    i,contador,subas,bajas: byte;
begin
    contador:=0;
    for i:=1 to N do
    begin
        subas:=sumar (ASCENSOS, M, 'F', i);
        bajas:=sumar(DESCENSOS, M, 'F', i);
        if subas<0.4*bajas then
            contador:=contador+1;
    end;
    contarSi:=contador;
end;

// d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada

function contarLineas (DESCENSOS,ASCENSOS: TM; N,M: byte):byte;
var
    i,j,contador:byte;
begin
    // Inicializar variables
    i:=1;
    j:=1;
    contador:=0;

    // Recorrer matriz
    for j:=1 to M do
    begin
        while (i<=N) and (ASCENSOS[i,j]<>0) and (DESCENSOS[i,j]<>0) do
            i:=i+1;
        if i<=N then
            contador:=contador+1;
    end;
    
    // Devolver resultado
    contarLineas:=contador;
end;

{¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que
ascendió o descendió cada vez que se detuvo el colectivo?}
// Respuesta: contar cuántas veces subió o bajó pasajeros por línea o parada y sumar ascensos o descensos

// Programa principal

var
    ASCENSOS,DESCENSOS: TM;
    N,M: byte;

begin
    leerArchivo (ASCENSOS, DESCENSOS, N, M);

    // Inciso a
    writeLn('La parada con mayor cantidad de pasajeros que bajaron es ',maximo(DESCENSOS,N,M));

    // Inciso b
    writeLn('La linea con menor cantidad de pasajeros que subieron es ',minimo(ASCENSOS,N,M));

    // Inciso c
    writeLn('Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que bajaron: ',
    contarSi(DESCENSOS,ASCENSOS,N,M));

    // Inciso d
    writeLn(contarLineas (DESCENSOS,ASCENSOS, N,M),' lineas no registraron subida o bajada de pasajeros en alguna parada');
end.