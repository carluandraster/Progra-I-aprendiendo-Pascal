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
        soloOfertas:boolean;
    
    // Variables de salida
        subtotal,descuentoTotal,precioFinal:real;
        maxnombre:string;
        contador:word;

begin
    // Inicializar variables
        maxCantidad:=0;
        contador:=0;
        nombre:='';
    
    // Ciclo mientras
        while nombre<>'*****' do
            begin
              // Preguntar nombre del cliente
                writeLn('Ingrese nombre del cliente: ');
                readLn(nombre);
              
              // ¿Fin de datos?
                if nombre<>'*****' then
                  begin
                    // Inicializar variables
                        descuentoTotal:=0;
                        subtotal:=0;
                        cuentaOferta:=0;
                        soloOfertas:=true;
                    
                    // Preguntar y validar cantidad de artículos que compró el cliente
                        repeat
                          writeLn('Ingrese cantidad de articulos comprados: ');
                          readLn(cantidad);
                        until cantidad>0;
                    
                    // Ciclo para
                        for i:=1 to cantidad do
                            begin
                              // Preguntar y validar precio base
                                repeat
                                  writeLn('Ingrese precio base: ');
                                  readLn(precioBase);
                                until precioBase>0;
                            
                              // Acumular subtotal
                                subtotal:=subtotal+precioBase;
                            
                              // Preguntar y validar si está o no en promoción
                                repeat
                                  writeLn('El articulo esta en promocion? (S o N)');
                                  readLn(promocion);
                                  promocion:=upcase(promocion);
                                until (promocion='S') or (promocion='N');

                              // Si está en promoción, aplicar descuento
                                if (promocion='S') then
                                    begin
                                      descuentoTotal:=descuentoTotal+descuento*precioBase;
                                      cuentaOferta:=cuentaOferta+1;
                                    end
                                else {Si existe un artículo que no está en promoción, el cliente no solo compró artículos en oferta}
                                    soloOfertas:=false;
                            end;
                    
                    // a) Monto total de cada venta, el total del descuento y el precio final a pagar.
                        writeLn('SUBTOTAL: $',subtotal:8:2);
                        writeLn('DESCUENTO: $',descuentoTotal:8:2);
                        precioFinal:=subtotal-descuentoTotal;
                        writeLn('PRECIO FINAL: $',precioFinal:8:2);
                    
                    // b) Nombre del cliente que compró la mayor cantidad de artículos en oferta.
                        if cuentaOferta>maxCantidad then
                            begin
                              maxCantidad:=cuentaOferta;
                              maxnombre:=nombre;
                            end;
                    // c) Cuántos clientes compraron solo artículos en oferta?
                        if soloOfertas then
                            contador:=contador+1;
                  end;
            end;
    
    // Salida de datos
        writeLn('El cliente que compro la mayor cantidad de articulos en oferta se llama ',maxnombre);
        writeLn(contador,' clientes compraron solo articulos en oferta');
end.