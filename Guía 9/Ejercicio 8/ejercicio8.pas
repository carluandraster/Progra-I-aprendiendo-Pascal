{La fábrica de Camperas (descripta en el ejercicio 4) debe satisfacer un pedido de un cliente,
y cuenta con la siguiente información:
# ARTICULO (1er. campo de secuencia, clave secundaria)
# TALLE (2do. campo de secuencia)
# COLOR (3er. campo de secuencia)
# CANTIDAD
 ARTICULO + TALLE + COLOR es Clave primaria
 ARTICULO + TALLE es Clave secundaria
Por cada pedido se pide actualizar el stock, en caso de no poder entregar lo posible informar
la cantidad adeudada. }

Program ejercicio8;

type
    str4 = string[4];

    // STOCK.DAT
    TRstock = record
        articulo: str4;
        talle: char;
        color,cantidad: byte;
        precio: real;
    end;
    TAstock = file of TR;

    // PEDIDOS.DAT
    TRpedido = record
        articulo: str4;
        talle: char;
        color,cantidad: byte;
    TApedidos = file of TRpedido;

// Subprogramas

// Cargar PEDIDOS.DAT

procedure CargarPedidos (var PEDIDOS: TApedidos);
var
    archivo: text;
    registro: TRpedido;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/pedidos.txt');
    reset(archivo);
    rewrite(PEDIDOS);

    // Copiar contenido de un archivo a otro
    with registro do
        begin
            read(archivo,articulo);
            while articulo<>'ZZZZ' do
                begin
                    read(archivo,blanco,talle,color,cantidad);
                    write(PEDIDOS, registro);

                    readLn(archivo);
                    read(archivo,articulo);
                end;
        end;
    write(PEDIDOS, registro);
    
    // Cerrar archivos
    close(archivo);
    close(PEDIDOS);
end;

procedure Enfrentar (var STOCK: TAstock; var PEDIDOS: TApedidos);
var
    TEMP: TAstock;
    regStock: TRstock;
    regPedido: TRpedido;
begin
    // Abrir archivos
    assign(TEMP,'./dat/TEMP.DAT');
    rewrite(TEMP);
    reset(STOCK);
    reset(PEDIDOS);

    // Actualizar base de datos
    read(STOCK,regStock);
    read(PEDIDOS,regPedido);
    while not eof(STOCK) or not eof(PEDIDOS) do
        if regStock.articulo>regPedido.articulo then
            begin
                writeLn('No existe el articulo ',regPedido.articulo);
                read(PEDIDOS,regPedido);
            end
        else
            if regStock.articulo<regPedido.articulo then
                begin
                    write(TEMP,regStock);
                    read(STOCK,regStock);
                end
            else
                if regStock.articulo>regPedido.articulo then
                    begin
                        writeLn('No existe el articulo ',regPedido.articulo);
                        read(PEDIDOS,regPedido);
                    end
                else
                    if regStock.articulo<regPedido.articulo then
                        begin
                            write(TEMP,regStock);
                            read(STOCK,regStock);
                        end
end;