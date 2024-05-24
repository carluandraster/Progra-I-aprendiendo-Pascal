{Un Banco registra en TARJETAS.DAT el movimiento de las tarjetas de crédito de sus
usuarios.
# NUMERO de TARJETA (1er campo de secuencia, clave primaria)
# NOMBRE del PROPIETARIO
# TOPE
# GASTO del MES (hasta el momento)
Además, se van ingresando (desde teclado ó archivo de texto) las compras con los
siguientes datos:
- Número de Tarjeta (puede repetirse)
- Monto
- Código de operación
Procesar los datos, actualizando los gastos del mes, siempre que no supere el monto tope,
en caso contrario, rechazarlo y grabar en un archivo RECHAZADOS.DAT con la siguiente
información:
# NUMERO de TARJETA
# CODIGO DE OPERACION
# MONTO
Sugerencia: para obtener la dirección relativa y acceder en forma directa al archivo 
TARJETAS, descargar del mismo los números de tarjeta sobre un arreglo (tabla). }

Program ejercicio2;

const
    tope=100;

type
    str20 = string[20];
    str17 = string[17];
    str8 = string[8];
    str5 = string[5];
    TR1 = record
        tarjeta: str8;
        nombre: str17;
        tope, gasto: real;
    end;
    TA1 = file of TR1;
    TR2 = record
        tarjeta: str8;
        codigo: str5;
        monto: real;
    end;
    TA2 = file of TR2;
    TV = array [1..tope] of str8;


// Subprogramas

// Cargar TARJETAS.DAT de tarjetas.txt

procedure CargarTarjetas (var TARJETAS: TA1);
var
    archivo: text;
    blanco: char;
    registro: TR1;
begin
    // Abrir TARJETAS para escritura
    rewrite(TARJETAS);

    // Abrir archivo de texto
    assign(archivo,'./txt/tarjetas.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,tarjeta,blanco,nombre,tope,gasto);
            write(TARJETAS,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(TARJETAS);
end;

// Descargar de TARJETAS.DAT los números de tarjeta sobre un arreglo

procedure cargarNumeros (var numTARJETAS: TV; var N: byte; var TARJETAS: TA1);
var
    registro: TR1;
begin
    // Inicializar variables
    N:=0;

    // Abrir archivo para LECTURA
    reset(TARJETAS);

    // Leer numeros de tarjetas tarjetas
    while not eof(TARJETAS) do
    begin
        N:=N+1;
        read(TARJETAS,registro);
        numTARJETAS[N]:=registro.tarjeta;
    end;

    // Cerrar archivo
    close(TARJETAS);
end;

// Dado un numero de tarjeta, buscar en el arreglo

function buscar (tarjeta: str8; numTARJETAS: TV; N: byte): byte;
begin
    if (N=0) or (numTARJETAS[N]=tarjeta) then
        buscar:=N
    else
        buscar:=buscar(tarjeta,numTARJETAS,N-1);
end;

// Leer compras.txt y actualizar gastos

procedure leerCompras(var TARJETAS: TA1; var RECHAZADOS: TA2; numTARJETAS: TV; N: byte);
var
    archivo: text;
    blanco: char;
    registro1: TR1; {Nro de tarjeta, nombre, tope y gasto}
    registro2: TR2; {Numero de tarjeta, monto y codigo de operacion}
    busqueda: byte;
begin
    // Abrir archivos
    assign(archivo,'./txt/compras.txt');
    reset(archivo);
    reset(TARJETAS);
    rewrite(RECHAZADOS);
        
    // Leer archivo compras.txt
    while not eof(archivo) do
        with registro2 do
            begin
                readLn(archivo,tarjeta,monto,blanco,codigo);
                busqueda:=buscar(tarjeta,numTARJETAS,N);
                seek(TARJETAS,busqueda-1);
                read(TARJETAS,registro1);
                with registro1 do
                    if gasto+monto>tope then
                        write(RECHAZADOS,registro2)
                    else
                        begin
                            seek(TARJETAS,busqueda-1);
                            gasto:=gasto+monto;
                            write(TARJETAS,registro1);
                        end;
            end;
    
    // Cerrar archivos
    close(TARJETAS);
    close(RECHAZADOS);
    close(archivo);
end;

// Imprimir gastos del mes

procedure imprimir1(var TARJETAS: TA1);
var
    registro: TR1;
begin
    reset(TARJETAS);

    writeLn('Nro de tarjeta  Nombre            Tope     Gasto');
    while not eof(TARJETAS) do
        begin
            read(TARJETAS,registro);
            with registro do
                writeLn(tarjeta,' ',nombre:24,' $',tope:4:2,' $',gasto:4:2);
        end;
    
    close(TARJETAS);
end;

// Imprimir operaciones rechazadas

procedure imprimir2(var RECHAZADOS: TA2);
var
    registro: TR2;
begin
    reset(RECHAZADOS);

    writeLn('Operaciones rechazadas: ');
    while not eof(RECHAZADOS) do
        begin
            read(RECHAZADOS,registro);
            with registro do
                writeLn(tarjeta,' $',monto:4:2,' ',codigo);
        end;
    
    close(RECHAZADOS);
end;


// Programa principal

var
    TARJETAS: TA1;
    RECHAZADOS: TA2;
    numTARJETAS: TV;
    N: byte;

begin
    // Asignar las variables de tipo archivo
    assign(TARJETAS,'./dat/TARJETAS.DAT');
    assign(RECHAZADOS,'./dat/RECHAZADOS.DAT');

    // Inicializar variables
    CargarTarjetas(TARJETAS);
    cargarNumeros (numTARJETAS, N, TARJETAS);

    // Resolver
    leerCompras(TARJETAS, RECHAZADOS, numTARJETAS, N);

    // Imprimir respuestas
    imprimir1(TARJETAS);
    imprimir2(RECHAZADOS);
end.