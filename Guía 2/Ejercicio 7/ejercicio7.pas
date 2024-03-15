{Un negocio vende camisas, éstas pueden ser de hombre o de mujer. Los talles que fabrican son: S,
M, L y X. El precio base unitario es de $1000 para hombres y $1200 para mujer, se debe agregar el IVA
del 21%. Hay una promoción en los talles S de hombre y X de mujer con un 5% de descuento. Además, si
la compra supera la docena se considera venta mayorista y obtiene un descuento extra del 7% del total.
Determinar cuáles son los datos necesarios para calcular el importe a facturar en una venta. }

Program ejercicio7;

const
    iva=1.21;
    descuentoTalla=0.95;
    descuentoMayorista=0.93;

var
    sexo,talle:char;
    cantidad:byte;

begin
    // Preguntar sexo
        writeLn('¿Que sos: hombre (H) o mujer (M)');
        readLn(sexo);

    // Preguntar talle
        writeLn('¿En que talle estas interesado: S, M, L o X');
        readLn(talle);

    // Preguntar cantidad
        writeLn('¿Cuantas unidades te vas a llevar?');
        readLn(cantidad);
end.