Program ejercicio1;

const
    TOPE = 255;

type
    // Cadenas de texto
    str3 = string[3];
    str8 = string[8];
    str20 = string[20];

    // CARRERAS.DAT
    TRcarreras = record
        codigo: str3;
        fecha: str8;
        ventas: word;
    end;
    TAcarreras = file of TRcarreras;

    // CIRCUITOS.DAT
    TRcircuitos = record
        codigo: str3;
        nombre: str20;
        capacidad: word;
        precio: real;
    end;
    TAcircuitos = file of TRcircuitos;
    TVcircuitos = array[1..TOPE] of TRcircuitos;

    // Para la fecha de mayor recaudacion
    TRfecha = record
        fecha: str8;
        recaudacion: real;
    end;
    TVfechas = array [1..TOPE] of TRfecha;


// Subprogramas

procedure cargarCarreras (var CARRERAS: TAcarreras);
var
    archivo: text;
    blanco: char;
    registro: TRcarreras;
begin
    // Abrir archivos
    rewrite(CARRERAS);
    assign(archivo,'./txt/CARRERAS.txt');
    reset(archivo);

    // Copiar archivo
    while not eof(archivo) do
    begin
        with registro do
            readLn(archivo,codigo,blanco,fecha,ventas);
        write(CARRERAS,registro);
    end;

    // Cerrar archivos
    close(archivo);
    close(CARRERAS);
end;

procedure cargarCircuitos (var CIRCUITOS: TAcircuitos);
var
    archivo: text;
    blanco: char;
    registro: TRcircuitos;
begin
    // Abrir archivos
    rewrite(CIRCUITOS);
    assign(archivo,'./txt/CIRCUITOS.txt');
    reset(archivo);

    // Copiar archivo
    while not eof(archivo) do
    begin
        with registro do
            readLn(archivo,codigo,blanco,nombre,capacidad,precio);
        write(CIRCUITOS,registro);
    end;

    // Cerrar archivos
    close(archivo);
    close(CIRCUITOS);
end;

procedure leerCircuitos (var CIRC: TVcircuitos; var N: byte; var CIRCUITOS: TAcircuitos);
begin
    reset(CIRCUITOS);
    N:=0;
    while not eof(CIRCUITOS) do
    begin
        N:=N+1;
        read(CIRCUITOS,CIRC[N]);
    end;
    close(CIRCUITOS);
end;

// Dado un código x, decir en qué posición está

function buscar (x: str3; CIRC: TVcircuitos; N: byte): byte;
begin
    if (N=0) or (CIRC[N].codigo=x) then
        buscar:=N
    else
        buscar:=buscar(x,CIRC,N-1);
end;

function posFecha (x: str8; FECHAS: TVfechas; M: byte): byte;
begin
    if (M=0) or (FECHAS[M].fecha=x) then
        posFecha:=M
    else
        posFecha:=posFecha(x,FECHAS,M-1);
end;

procedure corte (var CARRERAS: TAcarreras; CIRC: TVcircuitos; N: byte; var M,contadorCiudades: byte; var FECHAS: TVfechas;
var recaudacionTotal: real; var acumEntradas: word);
var
    VC: str3;
    totalEntradas: word;
    registro: TRcarreras;
    i,j: byte;
    
    
begin
    // Abrir archivo
    reset(CARRERAS);

    // Inicializar variables
    contadorCiudades:=0;
    acumEntradas:=0;
    M:=0;
    read(CARRERAS,registro);
    VC:=registro.codigo;
    recaudacionTotal:=0;

    // Leer archivo
    while not eof(CARRERAS) do
    begin
        totalEntradas:=0;
        i:=buscar(VC,CIRC,N);
        writeLn('Nombre Ciudad: ',CIRC[i].nombre);
        contadorCiudades:=contadorCiudades+1;
        writeLn('Fecha carrera   Entradas vendidas   % Ocupacion');
        while registro.codigo=VC do
        begin
            writeLn('  ',registro.fecha,'             ',registro.ventas,'        ',registro.ventas/CIRC[i].capacidad*100:8:2,' %');
            totalEntradas:=totalEntradas+registro.ventas;
            j:=posFecha(registro.fecha,FECHAS,M);
            if j=0 then
            begin
                M:=M+1;
                j:=M;
                with FECHAS[j] do
                begin
                    fecha:=registro.fecha;
                    recaudacion:=0;
                end;
            end;
            FECHAS[j].recaudacion:=FECHAS[j].recaudacion+registro.ventas*CIRC[i].precio;
            read(CARRERAS,registro);
        end;
        writeLn('Total entradas vendidas en ciudad ',CIRC[i].nombre,': ',totalEntradas);
        acumEntradas:=acumEntradas+totalEntradas;
        VC:=registro.codigo;
        recaudacionTotal:=recaudacionTotal+totalEntradas*CIRC[i].precio;
    end;


    // Cerrar archivo
    close(CARRERAS);
end;

// Posicion de la fecha con mayor recaudación
function maximo (FECHAS: TVfechas; M: byte): byte;
var
    maxAux: byte;
begin
    if (M=1) then
        maximo:=1
    else
    begin
        maxAux:=maximo(FECHAS,M-1);
        if FECHAS[M].recaudacion>FECHAS[maxAux].recaudacion then
            maximo:=M
        else
            maximo:=maxAux;
    end;
end;


// Programa principal

var
    CARRERAS: TAcarreras;
    CIRCUITOS: TAcircuitos;
    CIRC: TVcircuitos;
    FECHAS: TVfechas;
    N,M,contadorCiudades: byte;
    recaudacionTotal: real;
    acumEntradas: word;
    
begin
    // Archivos
    assign(CARRERAS,'./dat/CARRERAS.DAT');
    assign(CIRCUITOS,'./dat/CIRCUITOS.DAT');
    cargarCarreras(CARRERAS);
    cargarCircuitos(CIRCUITOS);

    // Procesamiento
    leerCircuitos(CIRC,N,CIRCUITOS);
    corte(CARRERAS,CIRC,N,M,contadorCiudades,FECHAS,recaudacionTotal,acumEntradas);

    // Salida
    writeLn('Importe total recaudado por entradas: $',recaudacionTotal:8:2);
    writeLn('Promedio general de entradas vendidas por ciudad: ',acumEntradas/contadorCiudades:8:2);
    writeLn('Fecha en la que se realizo la mayor recaudacion: ',FECHAS[maximo(FECHAS,M)].fecha);
end.