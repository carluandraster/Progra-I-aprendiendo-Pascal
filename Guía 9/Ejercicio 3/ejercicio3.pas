{Una empresa de turismo ofrece a sus clientes distintas excursiones a los distintos puntos de
interés de la ciudad (paseo a las Sierras, a la Laguna, City Tour, viaje en barco, etc.):
# CODIGO de EXCURSIÓN (cadena de 3, no hay más de 50)
# DESCRIPCION (cadena de 15)
# PRECIO BASE
# PRECIO de la COMIDA
Por otro lado se tiene un archivo BOLETERIA.DAT con el registro de los boletos vendidos con los
siguientes datos:
# CODIGO de EXCURSION (cadena de 3, campo de secuencia, clave secundaria)
# NRO de BOLETO
# INCLUYE COMIDA (S/N)
Se desea realizar el siguiente listado:
Excursión Cantidad de Boletos Cantidad de Comida Monto Total
xxxxxxxxxxxx 99 99 $9999.99
. . . . . . . . . . . .
% de turistas que contrataron excursión con comida: 99.99% }

Program ejercicio3;

type
    str3 = string[3];
    str15 = string[15];

    // EXCURSIONES.DAT
    TR1 = record
        codigo: str3;
        descripcion: str15;
        base,precioComida: real;
    end;
    TA1 = file of TR1;

    // BOLETERIA.DAT
    TR2 = record
        codigo: str3;
        nroBoleto: byte;
        incluyeComida: char;
    end;
    TA2 = file of TR2;

// Subprogramas

// Cargar archivos tipados

procedure cargarExcursiones (var EXCURSIONES: TA1);
var
    archivo: text;
    registro: TR1; {Codigo, descripción, precio base y precio de la comida}
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/excursiones.txt');
    reset(archivo);
    rewrite(EXCURSIONES);

    // Leer archivo de texto y escribir archivo tipado
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,codigo,blanco,descripcion,base,precioComida);
            write(EXCURSIONES,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(EXCURSIONES);
end;

procedure cargarBoleteria (var BOLETERIA: TA2);
var
    archivo: text;
    registro: TR2; {Codigo, numero de boleto y si incluye comida (S/N)}
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/boleteria.txt');
    reset(archivo);
    rewrite(BOLETERIA);

    // Leer archivo de texto y escribir en el archivo tipado
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,codigo,nroBoleto,blanco,incluyeComida);
            write(BOLETERIA,registro);
        end;
    
    // Cerrar archivo
    close(archivo);
    close(BOLETERIA);
end;

// Dado un codigo de excursion, devolver su indice

function buscar (x: str3; var EXCURSIONES: TA1): byte;
var
    i: byte;
    registro: TR1;
begin
    i:=0;
    read(EXCURSIONES,registro);
    while not eof(EXCURSIONES) and (registro.codigo<>x) do
        begin
            i:=i+1;
            read(EXCURSIONES,registro);
        end;
    if registro.codigo=x then
        buscar:=i
    else
        buscar:=51;
end;

// Dado un codigo de excursión, extraer registro de EXCURSIONES.DAT

procedure informacion (x: str3; var EXCURSIONES: TA1; var registro1: TR1);
begin
    reset(EXCURSIONES);
    seek(EXCURSIONES,buscar(x,EXCURSIONES));
    read(EXCURSIONES,registro1);
    close(EXCURSIONES);
end;

// Programa principal

var
    EXCURSIONES: TA1;
    BOLETERIA: TA2;
    VC: str3;
    contadorBoletos,contadorComida,totalTuristas,totalComida: byte;
    registro1: TR1;
    registro2: TR2;

begin
    // Inicializar variables
    totalTuristas:=0;
    totalComida:=0;

    // Inicializar archivos
    assign(EXCURSIONES,'./dat/EXCURSIONES.DAT');
    assign(BOLETERIA,'./dat/BOLETERIA.DAT');

    // Cargar archivos tipados
    cargarExcursiones(EXCURSIONES);
    cargarBoleteria(BOLETERIA);

    // Corte de primer grado
    writeLn('Excursion      Cantidad de Boletos Cantidad de Comida Monto Total');

    reset(BOLETERIA);

    contadorBoletos:=0;
    contadorComida:=0;

    read(BOLETERIA,registro2);
    VC:=registro2.codigo;

    informacion (registro2.codigo, EXCURSIONES, registro1);

    while registro2.codigo<>'ZZZ' do
        begin
            with registro2 do
                while codigo=VC do
                    begin
                        contadorBoletos:=contadorBoletos+1;
                        if incluyeComida='S' then
                            contadorComida:=contadorComida+1;
                        read(BOLETERIA,registro2);
                    end;
            writeLn(registro1.descripcion,'        ',contadorBoletos,'                    ',contadorComida,'         $',
            contadorBoletos*registro1.base+contadorComida*registro1.precioComida:4:2);

            totalTuristas:=totalTuristas+contadorBoletos;
            totalComida:=totalComida+contadorComida;

            if registro2.codigo='ZZZ' then
                writeLn('% de turistas que contrataron excursion con comida: ',totalComida/totalTuristas*100:4:2,'%')
            else
                begin
                    contadorBoletos:=0;
                    contadorComida:=0;
                    VC:=registro2.codigo;
                    informacion (registro2.codigo, EXCURSIONES, registro1);
                end;  
        end;
    
    // Cerrar archivos
    close(BOLETERIA);
end.