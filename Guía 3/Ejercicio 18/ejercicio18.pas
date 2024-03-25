{Reescribir el ejercicio 17, considerando que los datos están grabados en un archivo (con el formato
que considere más adecuado). }

Program ejercicio18;

const
    descuento=0.1; {10%=0,1}

var
    // Variables de entrada
        nombre:string;
        cantidad:byte;
        precioBase:real;
        promocion,espacio:char;
        archivo:text;
    
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
    
    // Archivo de texto
        assign(archivo,'ventas.txt');
        reset(archivo);
    
    // Leer archivo
        while not eof(archivo) do
            begin
                    readLn(archivo,nombre);
                    readLn(archivo,cantidad);
                    descuentoTotal:=0;
                    subtotal:=0;
                    cuentaOferta:=0;
                    soloOfertas:=true;
                    for i:=1 to cantidad do
                        begin
                            readLn(archivo,precioBase,espacio,promocion);
                            subtotal:=subtotal+precioBase;
                            if promocion='S' then
                                begin
                                  descuentoTotal:=descuentoTotal+descuento*precioBase;
                                  cuentaOferta:=cuentaOferta+1;
                                end
                            else
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
    
    // Cerrar archivo
        close(archivo);

    // Salida de datos
        writeLn('El cliente que compro la mayor cantidad de articulos en oferta se llama ',maxnombre);
        writeLn(contador,' clientes compraron solo articulos en oferta');
end.