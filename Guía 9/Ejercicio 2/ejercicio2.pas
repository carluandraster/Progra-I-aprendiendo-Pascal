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
            with registo do
                readLn(archivo,tarjeta,blanco,nombre,tope,gasto);
            write(TARJETAS,registro);
        end;
    
    // Cerrar archivos
    close(archivo);
    close(TARJETAS);
end;

// Descargar de TARJETAS.DAT los números de tarjeta sobre un arreglo

procedure cargarNumeros (var numTARJETAS: TV; var N: byte; TARJETAS: TA1);
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
    registro: TR2;
    busqueda: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'./txt/compras.txt');
    reset(archivo);

    // Abrir archivos para escritura
    rewrite(TARJETAS);
    rewrite(RECHAZADOS);

    // Leer archivo
    while not eof(archivo) do
        with registro do
            begin
                readLn(archivo,tarjeta,monto,blanco,codigo);
                busqueda:=buscar(tarjeta,numTARJETAS,N);
                
            end;
end;