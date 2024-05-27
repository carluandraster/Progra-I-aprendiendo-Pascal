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
        legajo,totalVentas,factura: word;
        nombre: str15;
        importe: real;
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
    registro: TR1;
    