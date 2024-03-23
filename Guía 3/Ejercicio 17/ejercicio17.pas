{La cajera de un supermercado ha registrado varias ventas, de cada una sabe:
- Nombre del cliente ( “ ***** “ indica fin de datos )
- Cantidad de artículos que compró el cliente y por cada uno se conoce:
    - Precio base del artículo
    - Si está o no en promoción ( ‘S’ ó ‘N’ )
En el caso de estar en promoción, se realiza un descuento del 10% sobre el precio base.
Se pide ingresar los datos e informar:
a) Monto total de cada venta, el total del descuento y el precio final a pagar.
b) Nombre del cliente que compró la mayor cantidad de artículos en oferta.
c) Cuántos clientes compraron solo artículos en oferta}

Program ejercicio17;

const
    descuento=0.1; {10%=0,1}

var
    // Variables de entrada
        nombre:string;
        cantidad:byte;
        precioBase:real;
        promocion:char;
    
    // Variables de proceso
        i,maxCantidad,cuentaOferta:byte;
    
    // Variables de salida
        subtotal,descuentoTotal,precioFinal:real;
        maxnombre:string;
        contador:word;