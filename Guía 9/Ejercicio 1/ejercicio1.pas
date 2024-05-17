{Una empresa de transporte de encomiendas tiene un registro de los paquetes a transportar en un
archivo PAQUETES.DAT, de cada uno se conoce:
# CODIGO de PAQUETE
# PESO
# CODIGO de DESTINO (1..30)
# MONTO ASEGURADO
Por otro lado se cuenta con un archivo DESTINO.DAT que contiene:
# CODIGO de DESTINO (1..30, desordenado)
# DESCRIPCION (cadena de 15)
Se desea saber:
a) El peso promedio de los paquetes.
b) Total del monto asegurado de la carga a transportar.
c) Al finalizar el proceso armar el siguiente listado:
     Destino           Cantidad de Paquetes
Xxxxxxxxxxxxxxxx                99
. . . . . .
      TOTAL                     99 }

Program ejercicio1;

type
    str15=string[15];

    // Paquetes.dat
    TR1 = record
        peso,monto: real;
        codPaquete,codDestino: byte;
    end;
    TA1 = file of TR1;

    // Destinos.dat
    TR2 = record
        codDestino: byte;
        descripcion: str15;
    end;
    TA2 = file of TR2;

    TV = array[1..50] of str15;

    TVbyte = array [1..50] of byte;

// Subprogramas

// Pasar de txt a dat

procedure leerPaquetes (var PAQUETES: TA1);
var
    archivo: text;
    registro: TR1;
begin
    // Abrir archivos
    assign(archivo,'paquetes.txt');
    reset(archivo);
    assign(PAQUETES,'PAQUETES.DAT');
    rewrite(PAQUETES);

    // Leer archivo txt y escribir en el archivo dat
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,codPaquete,peso,codDestino,monto);
            write(PAQUETES,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(PAQUETES);
end;

procedure leerDestinos (var DESTINOS: TA2);
var
    archivo: text;
    registro: TR2;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'destinos.txt');
    reset(archivo);
    assign(DESTINOS,'DESTINO.DAT');
    rewrite(DESTINOS);

    // Leer archivo txt y almacenar en dat
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,codDestino,blanco,descripcion);
            write(DESTINOS,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(DESTINOS);
end;

// Almacenar los destinos en un arreglo

procedure cargarDestinos (var DEST: TV; var DESTINOS: TA2);
var
    registro: TR2;
begin
    reset(DESTINOS);
    while not eof(DESTINOS) do
    begin
        read(DESTINOS,registro);
        with registro do
            DEST[codDestino]:=descripcion;
    end;
        
    close(DESTINOS);
end;

// Inicializar arreglo

procedure limpiarCont(var CONTADORES: TVbyte);
var
    i: byte;
begin
    for i:=1 to 50 do
        CONTADORES[i]:=0;
end;

// Programa principal

var
    PAQUETES: TA1;
    DESTINOS: TA2;
    DEST: TV;
    CONTADORES: TVbyte;
    pesoTotal,montoTotal: real;
    registro: TR1;
    i,N: byte;

begin
    // Inicializar variables
    limpiarCont(CONTADORES);
    pesoTotal:=0;
    montoTotal:=0;
    N:=0;

    // Cargar datos de archivo
    leerPaquetes (PAQUETES);
    leerDestinos (DESTINOS);
    cargarDestinos (DEST, DESTINOS);

    // Leer PAQUETES.DAT
    reset(PAQUETES);
    while not eof(PAQUETES) do
        begin
            read(PAQUETES,registro);
            with registro do
                begin
                    // Inciso a
                    pesoTotal:=pesoTotal+peso;
                    N:=N+1;

                    // Inciso b
                    montoTotal:=montoTotal+monto;

                    // Inciso c
                    CONTADORES[codDestino]:=CONTADORES[codDestino]+1;
                end;
        end;
    
    // Imprimir resultados
    writeLn('Peso promedio: ',pesoTotal/N:4:2);
    writeLn('Total del monto asegurado de la carga a transportar: $',montoTotal:4:2);
    writeLn('Destino           Cantidad de Paquetes');
    for i:=1 to 30 do
        writeLn(DEST[i],'           ',CONTADORES[i]:(15-length(DEST[i])));
end.