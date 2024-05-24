{Una empresa de turismo ofrece a sus clientes distintas excursiones a los distintos puntos de interés
de la ciudad (paseo a las Sierras, a la Laguna, City Tour, viaje en barco, etc.):
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
begin
    // Abrir archivos
    assign(archivo,'./txt/excursiones.txt');
    reset(archivo);
    rewrite(EXCURSIONES);
end;

procedure Corte1