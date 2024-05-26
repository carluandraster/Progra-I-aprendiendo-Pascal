{Una fábrica de camperas tiene organizado su stock de la siguiente manera en un archivo de
tipo:
# CODIGO de ARTICULO (cadena de 4) (1er. campo de secuencia, clave secundaria)
# TALLE ( S, M, L, X) (2do. campo de secuencia, clave secundaria)
# COLOR (1=Negro, 2=Marrón, 3=Azul, 4=Rojo) (3er. campo de secuencia, clave secundaria)
# CANTIDAD de PRENDAS
# PRECIO de COSTO
 Clave primaria: CODIGO de ARTICULO + TALLE + COLOR
Se desea obtener el siguiente listado:
Stock de Prendas
Código: XXXX
 Talle    Cantidad     Precio Costo
   X        999         $ 99999.99
 . . . . . . . . .
Código: XXXX
. . .
Cantidad Total: 9999
Porcentaje de Prendas Negras: 99.99 % }

Program ejercicio4;

type
    str4 = string[4];
    TR = record
        codigo: str4;
        talle: char;
        color,cantidad: byte;
        precio: real;
    end;
    TA = file of TR;

// Subprogramas

// Cargar STOCK.DAT por archivo

procedure cargarStock (var STOCK: TA);
var
    archivo: text;
    registro: TR;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/STOCK.TXT');
    reset(archivo);
    rewrite(STOCK);

    // Copiar contenido de un archivo a otro
    while not eof(archivo) do
        begin
            with registro do
                begin
                    read(archivo,codigo);
                    if codigo<>'ZZZZ' then
                        read(archivo,blanco,talle,color,cantidad,precio);
                end;
                readLn(archivo);
            write(STOCK,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(STOCK);
end;


// Programa principal

var
    STOCK: TA;
    registro: TR;
    VC1: str4; VC2: char;
    cantidad,cantidadTotal,prendasNegras: word;
    precioCosto: real;

begin
    // Archivo
    assign(STOCK,'./dat/STOCK.DAT');
    cargarStock(STOCK);
    reset(STOCK);

    // Inicializar variables
    cantidad:=0;
    cantidadTotal:=0;
    prendasNegras:=0;
    precioCosto:=0;

    // Leer archivo
    read(STOCK,registro);
    with registro do
        begin
            VC1:=codigo;
            VC2:=talle;
        end;
    writeLn('Stock de prendas');
    while registro.codigo<>'ZZZZ' do
        begin
            writeLn('Codigo: ',registro.codigo);
            writeLn('Talle    Cantidad     Precio Costo');
            while registro.codigo=VC1 do
                begin
                    while (registro.talle=VC2) and (registro.codigo=VC1) do
                        begin
                            cantidad:=cantidad+registro.cantidad;
                            precioCosto:=precioCosto+registro.precio;
                            if registro.color=1 then
                                prendasNegras:=prendasNegras+registro.cantidad;
                            read(STOCK, registro);
                        end;
                    writeLn('  ',VC2,'         ',cantidad,'           $',precioCosto:4:2);
                    cantidadTotal:=cantidadTotal+cantidad;
                    VC2:=registro.talle;
                    cantidad:=0;
                    precioCosto:=0;
                end;
            VC1:=registro.codigo;
            if registro.codigo='ZZZZ' then
                begin
                    writeLn('Cantidad total: ',cantidadTotal);
                    writeLn('Porcentaje de Prendas Negras: ',prendasNegras/cantidadTotal*100:4:2,'%');
                end;
        end;
end.