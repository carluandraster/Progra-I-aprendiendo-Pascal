{ Una cadena de cines tiene grabados en un archivo binario los siguientes datos de sus
salas:
# CODIGO de CINE (cadena de 4, campo de secuencia clave primaria)
# ZONA (1..10) (puede haber más de un cine en la misma zona)
# CAPACIDAD
Además o en otro archivo binario la venta de localidades de las películas que
proyecta:
# CODIGO de CINE (cadena de 4, campo de secuencia, clave secundaria)
# CODIGO de PELICULA (cadena de 3, campo de secuencia, puede repetirse en este u otro cine)
# LOCALIDADES VENDIDAS
Se cuenta, además, con un archivo de texto que contiene los códigos de película, títulos y
la duración (en minutos) de cada película (40 como máximo); una película por línea.
Se pide generar el siguiente listado:
Cine Cant.Películas(1) Cant. funciones Total Loc.Vendidas %Ocup.Promedio
xxxx 999 999 999 99.99%
. . . . . . . . . . . . . . .
Cantidad de cines que no proyectaron ninguna película: 999
Película con menor promedio de localidades vendidas por función: xxx(99 min.)
Total de localidades vendidas por zona
Zona 1 999
. . .
(1) Cantidad de películas diferentes. Una película se puede proyectar en varias
funciones en el mismo cine }

Program ejercicio7;

const
    TOPE = 40;
    ZONAS = 10;

type
    // Tipos de string
    str4 = string[4];
    str3 = string[3];
    strTop = string[TOPE];

    // Tipos de arreglo
    TV = array [1..ZONAS] of word;

    // CINES.dat
    TRcines = record
        codCine: str4;
        zona,capacidad: byte;
    end;
    TAcines = file of TRcines;

    // VENTAS.dat
    TRventas = record
        codCine: str4;
        codPelicula: str3;
        localidadesVendidas: byte;
    end;
    TAventas = file of TRventas;

    // Registro de Películas
    TRpeliculas = record
        codPelicula: str3;
        localidadesVendidas: word;
        cantidadFunciones: byte;
    end;
    TVpeli = array [1..TOPE] of TRpeliculas;

// Subprogramas

// Cargar archivos binarios

procedure cargarCines (var CINES: TAcines);
var
    archivo: text;
    registro: TRcines;
begin
    // Abrir archivos
    assign(archivo,'./txt/CINES.txt');
    reset(archivo);
    rewrite(CINES);

    // Copiar contenido de un archivo a otro
    with registro do
        begin
            read(archivo,codCine);
            while codCine<>'ZZZZ' do
                begin
                    read(archivo,zona,capacidad);
                    write(CINES,registro);

                    readLn(archivo);
                    read(archivo,codCine);
                end;
        end;
        write(CINES,registro);
    
    // Cerrar archivos
    close(archivo);
    close(CINES);
end;

procedure cargarVentas (var VENTAS: TAventas);
var
    archivo: text;
    registro: TRventas;
begin
    // Abrir archivos
    assign(archivo,'./txt/VENTAS.txt');
    reset(archivo);
    rewrite(VENTAS);

    // Copiar contenido de un archivo a otro
    with registro do
        begin
            read(archivo,codCine);
            while codCine<>'ZZZZ' do
                begin
                    read(archivo,codPelicula,localidadesVendidas);
                    write(VENTAS,registro);

                    readLn(archivo);
                    read(archivo,codCine);
                end;
        end;
    write(VENTAS,registro);

    // Cerrar archivos
    close(archivo);
    close(VENTAS);
end;

// Dado un código de pelicula, buscar su nombre y su duración

procedure buscarPelicula (x: str3; var  titulo:strTop; var duracion: byte);
var
    archivo: text;
    cod: str3;
    caracter,blanco: char;
begin
    // Inicializar variables
    titulo:='';

    // Abrir archivo
    assign(archivo,'./txt/PELICULAS.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,cod);
    while not eof(archivo) and (cod<>x) do
        begin
            readLn(archivo);
            read(archivo,cod);
        end;
    if cod = x then
        begin
            read(archivo,blanco,caracter);
            while caracter<>' ' do
                begin
                    if caracter='_' then
                        titulo:=titulo+' '
                    else
                        titulo:=titulo+caracter;
                    read(archivo,caracter);
                end;
            read(archivo,duracion);
        end
    else
        titulo:='ERROR: No se encontro la pelicula.';
    
    // Cerrar archivo
    close(archivo);
end;

// Dada una pelicula, buscar en el registro de las mismas

function buscar (x: str3; N: byte; PELICULAS: TVpeli): byte;
begin
    if (N=0) or (PELICULAS[N].codPelicula=x) then
        buscar:=N
    else
        buscar:=buscar(x,N-1,PELICULAS);
end;

// Programa principal

var
    CINES: TAcines;
    VENTAS: TAventas;
    PELICULAS: TVpeli;
    regCines: TRcines;
    regVentas: TRventas;
    ventasXZona: TV;
    contaPeliculas, contaFunciones, totalVendidas, cinesSinFuncion: word;
    i,duracion,busqueda,N: byte;
    VC,minCod: str3;
    minProm: real;
    titulo: strTop;

begin
    // Inicializar variables
    cinesSinFuncion:=0;
    for i:=1 to ZONAS do
        ventasXZona[i]:=0;
    minProm:=99999999999999999999999999999;
    N:=0;

    // Archivos

    assign(CINES,'./dat/CINES.dat');
    cargarCines(CINES);
    reset(CINES);

    assign(VENTAS,'./dat/VENTAS.dat');
    cargarVentas(VENTAS);
    reset(VENTAS);

    // Enfrentar archivos
    read(CINES,regCines);
    read(VENTAS,regVentas);
    writeLn('Cine Cant.Peliculas Cant. funciones Total Loc.Vendidas %Ocup.Promedio');
    while not eof(CINES) or not eof(VENTAS) do
        if regCines.codCine>regVentas.codCine then
            begin
                writeLn('Error, no se encontro el cine ',regVentas.codCine);
                read(VENTAS,regVentas);
            end
        else
            if regCines.codCine<regVentas.codCine then
                begin
                    cinesSinFuncion:=cinesSinFuncion+1;
                    read(CINES,regCines);
                end
            else
                begin
                    contaPeliculas:=0;
                    contaFunciones:=0;
                    totalVendidas:=0;
                    VC:='';
                    while regCines.codCine=regVentas.codCine do
                        begin
                            busqueda:=buscar(regVentas.codPelicula,N,PELICULAS);
                            if busqueda=0 then
                                begin
                                    N:=N+1;
                                    busqueda:=N;
                                    PELICULAS[N].codPelicula:=regVentas.codPelicula;
                                    PELICULAS[N].localidadesVendidas:=0;
                                    PELICULAS[N].cantidadFunciones:=0;
                                end;
                            PELICULAS[busqueda].localidadesVendidas:=PELICULAS[busqueda].localidadesVendidas+regVentas.localidadesVendidas;
                            PELICULAS[busqueda].cantidadFunciones:=PELICULAS[busqueda].cantidadFunciones+1;
                            if regVentas.codPelicula<>VC then
                                begin
                                    contaPeliculas:=contaPeliculas+1;
                                    VC:=regVentas.codPelicula;
                                end;
                            contaFunciones:=contaFunciones+1;
                            totalVendidas:=totalVendidas+regVentas.localidadesVendidas;
                            ventasXZona[regCines.zona]:=ventasXZona[regCines.zona]+regVentas.localidadesVendidas;
                            read(VENTAS,regVentas);
                        end;
                    writeLn(regCines.codCine,'       ',contaPeliculas,'               ',contaFunciones,'                   ',totalVendidas,'           ',totalVendidas/(contaFunciones*regCines.capacidad)*100:4:2,'%');
                    read(CINES,regCines);
                end;
    writeLn('Cantidad de cines que no proyectaron ninguna pelicula: ',cinesSinFuncion);

    // Hallar película con menor promedio de localidades vendidas por función
    for i:=1 to N do
        with PELICULAS[i] do
            if localidadesVendidas/cantidadFunciones<minProm then
                begin
                    minProm:=localidadesVendidas/cantidadFunciones;
                    minCod:=codPelicula;
                end;
    buscarPelicula(minCod, titulo, duracion);
    writeLn('Pelicula con menor promedio de localidades vendidas por funcion: ',titulo,' (',duracion,' min)');

    writeLn('Total de localidades vendidas por zona');
    for i:=1 to ZONAS do
        writeLn('Zona ',i,'   ',ventasXZona[i]);
end.