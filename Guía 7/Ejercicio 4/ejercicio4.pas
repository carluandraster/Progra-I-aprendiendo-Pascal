{En una competencia intervienen N equipos deportivos de los cuales se registró:
 Nombre del Club
 Cantidad de partidos jugados
 El resultado de cada encuentro ( G = ganado, E = empatado, P = perdido)
Se pide almacenar los datos en una estructura adecuada junto con el total del puntaje obtenido.
Por cada partido ganado son 3 puntos, empatado 1 y perdido 0.
A partir de lo almacenado, informar:
a) Listado con los nombres de los clubes junto con el puntaje obtenido.
b) Nombre de el/los punteros de la Tabla.
c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes. }

Program ejercicio4;

const
    tope = 100;

type
    str30 = string[30];

    TVchar = array [1..tope] of char;

    TR = record
        nombre: str30;
        M,puntaje: byte;
        resultados: TVchar;
    end;

    TV = array [1..tope] of TR;

    TVstr = array[1..tope] of str30;

// Subprogramas

procedure leerArchivo (var EQUIPOS: TV; var N: byte);
var
    archivo: text;
    i,j: byte;
    caracter:char;
begin
    // Abrir archivo de texto
    assign(archivo,'equipos.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N);
    for i:=1 to N do
        with EQUIPOS[i] do
        begin
            // Leer nombre del equipo caracter por caracter
            nombre:='';
            read(archivo,caracter);
            repeat
                nombre:=nombre+caracter;
                read(archivo,caracter);
            until caracter=' '; {Asumo que el nombre del equipo no contiene espacios}
            
            // Leer cantidad de partidos
            read(archivo,M);

            // Leer resultados
            for j:=1 to M do
                read(archivo,caracter,resultados[j]);
            
            // Siguiente lína
            readLn(archivo);
        end;
    
    // Cerrar archivo
    close(archivo);
end;

// a) Listado con los nombres de los clubes junto con el puntaje obtenido.

// Confeccionar puntajes
function puntuar (equipo: TR):byte;
var
    i,suma: byte;
begin
    // Inicializar variables
    suma:=0;

    // Recorrer partidos
    with equipo do
        for i:=1 to M do
            case resultados[i] of
                'G': suma:=suma+3;
                'E': suma:=suma+1;
            end;
    
    // Devolver resultado
    puntuar:=suma;
end;

procedure puntajes (var EQUIPOS: TV; N: byte);
var
    i:byte;
begin
    for i:=1 to N do
        EQUIPOS[i].puntaje:=puntuar(EQUIPOS[i]);
end;

procedure listar (EQUIPOS: TV; N: byte);
var
    i: byte;
begin
    writeLn('Club                   Puntaje');
    for i:=1 to N do
        with EQUIPOS[i] do
            writeLn(nombre,'                   ',puntaje);
end;

// b) Nombre de el/los punteros de la Tabla.

procedure maximos (EQUIPOS: TV; N: byte; var PUNTEROS: TVstr; var K: byte);
var
    i,max: byte;
begin
    // Inicializar variables
    max:=0;

    // Recorrer todos los equipos
    for i:=1 to N do
        with EQUIPOS[i] do
            if puntaje>max then
            begin
                max:=puntaje;
                K:=1;
                PUNTEROS[1]:=nombre;
            end
            else
                if puntaje=max then
                begin
                    K:=K+1;
                    PUNTEROS[K]:=nombre;
                end;
end;

// c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes.
function perdio (equipo: TR):boolean;
var
    i: byte;
begin
    i:=1;
    with equipo do
    begin
        while (i<=M) and (resultados[i]<>'P') do
            i:=i+1;
        perdio:=i<=M;
    end;   
end;

function porcentaje (EQUIPOS: TV; N: byte):real;
var
    i,contador: byte;
begin
    contador:=0;

    for i:=1 to N do
        if not perdio(EQUIPOS[i]) then
            contador:=contador+1;
    
    porcentaje:=contador/N*100;
end;

// Programa principal

var
    EQUIPOS: TV;
    i,N,K: byte;
    PUNTEROS: TVstr;

begin
    leerArchivo(EQUIPOS,N);

    // Inciso a
    puntajes(EQUIPOS, N);
    listar(EQUIPOS, N);

    // Inciso b
    maximos (EQUIPOS, N, PUNTEROS, K);
    write('Punteros de la tabla: ');
    for i:=1 to K do
        writeLn(PUNTEROS[i],' ');

    // Inciso c
    writeLn('Porcentaje de los clubes que no perdieron ningun partido: ',porcentaje(EQUIPOS,N):4:2,'%');
end.