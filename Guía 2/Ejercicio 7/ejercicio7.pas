
{Un negocio vende camisas, éstas pueden ser de hombre o de mujer. Los talles que fabrican son: S,
M, L y X. El precio base unitario es de $1000 para hombres y $1200 para mujer, se debe agregar el IVA
del 21%. Hay una promoción en los talles S de hombre y X de mujer con un 5% de descuento. Además, si
la compra supera la docena se considera venta mayorista y obtiene un descuento extra del 7% del total.
Determinar cuáles son los datos necesarios para calcular el importe a facturar en una venta. }

Program ejercicio7;

Const
    // Impuestos y descuentos
        iva =   1.21;
        descuentoTalla =   0.95;
        descuentoMayorista =   0.93;
    
    // Precios base unitario
        precioBaseHombres=1000;
        precioBaseMujeres=1200;

Var 
    sexo,talle:   char;
    cantidad:   byte;
    precio:   real;

Begin
    // Preguntar sexo
        writeLn('¿Que sos: hombre (H) o mujer (M)?');
        readLn(sexo);
        sexo:=upcase(sexo);

    // Preguntar talle
        writeLn('¿En que talle estas interesado: S, M, L o X');
        readLn(talle);
        talle:=upcase(talle);

    // Preguntar cantidad
        writeLn('¿Cuantas unidades te vas a llevar?');
        readLn(cantidad);

    // Determinar precio
        if sexo='H' then {Es para hombres?}
            if talle='S' then {La talla es S?}
                if cantidad>12 then {Es una compra mayorista?}
                    // Al precio base le aplico IVA, descuento por la talla y descuento mayorista
                    precio:=precioBaseHombres*iva*descuentoTalla*descuentoMayorista
                else {No es una compra mayorista}
                    // Al precio base le aplico IVA y descuento por la talla
                    precio:=precioBaseHombres*iva*descuentoTalla
            else {La talla no es S}
                if cantidad>12 then {Es una compra mayorista?}
                    // Al precio base le aplico IVA y descuento mayorista
                    precio:=precioBaseHombres*iva*descuentoMayorista
                else {No es una compra mayorista}
                    // Al precio base le aplico IVA
                    precio:=precioBaseHombres*iva
        else
            if sexo='M' then {Es para mujeres?}
                if talle='X' then {La talla es X?}
                    if cantidad>12 then {Es una compra mayorista?}
                        // Al precio base le aplico IVA, descuento por la talla y descuento mayorista
                        precio:=precioBaseMujeres*iva*descuentoTalla*descuentoMayorista
                    else {No es una compra mayorista}
                        // Al precio base le aplico IVA y descuento por la talla
                        precio:=precioBaseMujeres*iva*descuentoTalla
                else {La talla no es X}
                    if cantidad>12 then {Es una compra mayorista?}
                        // Al precio base le aplico IVA y descuento mayorista
                        precio:=precioBaseMujeres*iva*descuentoMayorista
                    else {No es una compra mayorista}
                        // Al precio base le aplico IVA
                        precio:=precioBaseMujeres*iva
            else
                writeLn('Error: solo hay 2 generos');
        
        // Salida
            if (sexo='H') or (sexo='M') then
                writeLn('Precio final: $',precio:8:2);
End.
