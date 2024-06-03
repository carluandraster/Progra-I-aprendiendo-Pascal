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
    TAstock = file of TRstock;

    // PEDIDOS.DAT
    TRpedido = record
        articulo: str4;
        talle: char;
        color,cantidad: byte;
    end;
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

{Dados 2 registros, devolver:
- 0 si son iguales
- 1 si regStock es mayor
- 2 si regPedido es mayor}

function comparacion (regStock: TRstock; regPedido: TRpedido): byte;
begin
    if regStock.articulo>regPedido.articulo then
        comparacion:=1
    else
        if regStock.articulo<regPedido.articulo then
            comparacion:=2
        else
            if regStock.talle>regPedido.talle then
                comparacion:=1
            else
                if regStock.talle<regPedido.talle then
                    comparacion:=2
                else
                    if regStock.color>regPedido.color then
                        comparacion:=1
                    else
                        if regStock.color<regPedido.color then
                            comparacion:=2
                        else
                            comparacion:=0;
end;

procedure Enfrentar (var STOCK: TAstock; var PEDIDOS: TApedidos);
var
    TEMP: TAstock;
    regStock: TRstock;
    regPedido: TRpedido;
    comparison: byte;
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
        begin
            comparison:=comparacion(regStock,regPedido);
            if comparison=1 then
                begin
                    if regStock.articulo>regPedido.articulo then
                            writeLn('No existe el articulo ',regPedido.articulo)
                    else
                        if regStock.talle>regPedido.talle then
                            writeLn('No existe el talle ',regPedido.talle,', para el articulo ',regPedido.articulo)
                        else
                            writeLn('No existe el color ',regPedido.color,', para el articulo ',regPedido.articulo);
                    read(PEDIDOS,regPedido);
                end
                else
                    if comparison=2 then
                        begin
                            write(TEMP,regStock);
                            read(STOCK,regStock);
                        end
                    else
                        begin
                            if regStock.cantidad<regPedido.cantidad then
                                begin
                                    writeLn('Se adeudan ',regPedido.cantidad-regStock.cantidad,' prendas de ',regPedido.articulo,'.');
                                    regStock.cantidad:=0;
                                end
                            else
                                regStock.cantidad:=regStock.cantidad-regPedido.cantidad;
                            read(PEDIDOS,regPedido);
                        end;
        end;
        
    
    // Cerrar archivos
    close(TEMP);
    close(STOCK);
    close(PEDIDOS);

    // Reemplazar archivo de Stock
    erase(STOCK);
    rename(TEMP,'./dat/STOCK.DAT');
end;

// Mostrar el nuevo Stock por texto

procedure mostrarStock (var STOCK: TAstock; nombre: string);
var
    archivo: text;
    registro: TRstock;
begin
    // Abrir archivos
    assign(archivo,nombre);
    rewrite(archivo);
    reset(STOCK);

    // Copiar de un archivo a otro
    while not eof(STOCK) do
        begin
            read(STOCK,registro);
            with registro do
                writeLn(archivo,articulo,' ',talle,' ',color,' ',cantidad,' ',precio:4:2);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(STOCK);
end;


// Programa principal

var
    STOCK: TAstock;
    PEDIDOS: TApedidos;

begin
    // Archivos
    assign(STOCK,'./dat/STOCK.DAT');
    assign(PEDIDOS,'./dat/PEDIDOS.DAT');
    CargarPedidos(PEDIDOS);

    // Procesamiento de datos
    Enfrentar(STOCK,PEDIDOS);

    // Salida de datos
    mostrarStock(STOCK,'./txt/STOCK.txt');
end.