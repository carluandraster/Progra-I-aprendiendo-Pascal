{Una empresa paga a fin de mes a sus empleados una comisión del 0.5% sobre las ventas
efectuadas, para ello almacena el acumulado mensual de ventas en un archivo cuyo diseño
de registro es:
# LEGAJO (campo de secuencia, clave primaria)
# NOMBRE y APELLIDO
# TOTAL de VENTAS
# NRO de FACTURA de MAYOR VENTA del MES
# IMPORTE de MAYOR VENTA del MES
Al final del día actualiza los registros de ese archivo con las ventas efectuadas
almacenadas en otro archivo cuyo diseño de registro es:
# LEGAJO (campo de secuencia, clave secundaria)
# NRO de FACTURA
# IMPORTE
Se pide actualizar el primer archivo y listar las comisiones que le corresponden hasta
el momento a cada empleado. }

Program ejercicio6;

type
    str15 = string[15];
    TR1 = record
        legajo,factura: word;
        nombre: str15;
        totalVentas,importe: real;
    end;
    TA1 = file of TR1;
    TR2 = record
        legajo, factura: word;
        importe: real;
    end;
    TA2 = file of TR2;

// Subprogramas

// Cargar archivos tipados

procedure cargarVendedores (var VENDEDORES: TA1);
var
    archivo: text;
    registro: TR1; {Legajo - Nombre - Total ventas - Factura - Importe}
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/vendedores.txt');
    reset(archivo);
    rewrite(VENDEDORES);

    // Copiar contenido de un archivo a otro
    while not eof(archivo) do
        begin
            with registro do
                begin
                    read(archivo,legajo);
                    if legajo<>9999 then
                        read(archivo,blanco,nombre,totalVentas,factura,importe);
                end;
            readLn(archivo);
            write(VENDEDORES,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(VENDEDORES);
end;

procedure cargarVentas (var VENTAS: TA2);
var
    archivo: text;
    registro: TR2; {Legajo, nro de factura, importe}
begin
    // Abrir archivos
    assign(archivo,'./txt/ventas.txt');
    reset(archivo);
    rewrite(VENTAS);

    // Copiar contenido de un archivo a otro
    while not eof(archivo) do
        begin
            with registro do
                begin
                    read(archivo,legajo);
                    if legajo<>9999 then
                        read(archivo,factura,importe);
                end;
            readLn(archivo);
            write(VENTAS,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(VENTAS);
end;

// Programa principal

var
    // Archivos
    VENDEDORES,TEMP: TA1;
    VENTAS: TA2;

    // Registros
    registro1: TR1;
    registro2: TR2;

begin
    // Archivos

    assign(VENDEDORES,'./dat/VENDEDORES.DAT');
    cargarVendedores(VENDEDORES);
    reset(VENDEDORES);

    assign(VENTAS,'./dat/VENTAS.DAT');
    cargarVentas(VENTAS);
    reset(VENTAS);

    assign(TEMP,'./dat/TEMP.DAT');
    rewrite(TEMP);

    // Enfrentar archivos
    read(VENDEDORES,registro1);
    read(VENTAS, registro2);
    writeLn('Empleado        Comision');
    while not eof(VENDEDORES) or not eof (VENTAS) do
        if registro1.legajo<registro2.legajo then // Un vendedor no vendio mas nada
            begin
                write(TEMP,registro1);
                writeLn(registro1.nombre,' $',registro1.totalVentas*0.005:8:2);
                read(VENDEDORES,registro1);
            end
        else
            begin
                if registro1.legajo = registro2.legajo then
                        with registro1 do
                            begin
                                totalVentas:=totalVentas+registro2.importe;
                                if registro2.importe>importe then
                                    begin
                                        importe:=registro2.importe;
                                        factura:=registro2.factura;
                                    end;
                            end;
                read(VENTAS, registro2);
            end;

    // Cerrar archivos
    close(VENDEDORES);
    close(VENTAS);
    close(TEMP);
    
    // Actualizar archivo de VENDEDORES
    erase(VENDEDORES);
    rename(TEMP,'./dat/VENDEDORES.DAT');
end.