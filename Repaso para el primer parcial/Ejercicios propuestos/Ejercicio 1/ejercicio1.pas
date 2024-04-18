{Una compañía Láctea recibe la producción diaria de, en litros de leche, de N tambos de la zona,
durante varios días consecutivos (no se conoce).
Los datos vienen de la siguiente manera:
- Código del Tambo (cadena de 4 caracteres) y a continuación
    - la entrega diaria en litros, 0=fin de datos.
Se pide, armar 3 vectores paralelos, COD, TOT, PROM y además calcular e informar:
a) Código del tambo que más leche entregó a la compañía.
b) Cuántos superaron un promedio de X litros de entrega.
c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).
COD con los códigos de cada Tambo
TOT con los totales de litros entregados
PROM con el promedio diario entregado }

program ejercicio1;

const
    tope=255;

type
    str4 = string[4];
    TVstr = array [1..tope] of str4;
    TVreal = array [1..tope] of real;

// Subprogramas

// Se pide, armar 3 vectores paralelos, COD, TOT, PROM
procedure leerArchivo(var COD:TVstr; var TOT,PROM:TVreal; var N:byte);
var
    archivo:text;
    i,contador:byte;
    acumulador,numero:real;
begin
    // Reconocer archivo de texto
    assign(archivo,'tambos.txt');
    reset(archivo);

    // Leer archivo
    read(archivo,N);
    for i:=1 to N do
    begin
        // Inicializar variables
        contador:=0;
        acumulador:=0;

        // Organizar información en los arreglos
        readLn(archivo);
        read(archivo,COD[i]);
        readLn(archivo); {Salto de linea}
        read(archivo,numero);
        while numero>0 do
        begin
            acumulador:=acumulador+numero;
            contador:=contador+1;
            read(archivo,numero);
        end;
        TOT[i]:=acumulador;
        PROM[i]:=acumulador/contador;
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Código del tambo que más leche entregó a la compañía.
function maximo (COD:TVstr; TOT:TVreal; N:byte):str4;
var
    i:byte;
    max:real;
begin
    max:=-1;
    for i:=1 to N do
        if TOT[i]>max then
        begin
            max:=TOT[i];
            maximo:=COD[i];
        end;
end;

// b) Cuántos superaron un promedio de X litros de entrega.
function contarSi (PROM:TVreal;X:real;N:byte):byte;
var
    i,contador:byte;
begin
    // Inicializar variables
    contador:=0;

    // Recorrer arreglo
    for i:=1 to N do
        if PROM[i]>X then
            contador:=contador+1;
    
    // Devolver resultado
    contarSi:=contador;
end;

// c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código)
procedure informacion (COD:TVstr; TOT,PROM:TVreal; N:byte);
var
    i:byte;
    x:str4;
begin
    i:=1;
    writeLn('Ingrese un codigo: ');
    readLn(x);
    while (i<=N) and (COD[i]<>x) do
        i:=i+1;
    if COD[i]=x then
    begin
        writeLn('Total entregado: ',TOT[i]:0:2,' litros.');
        writeLn('Promedio: ',PROM[i]:0:2,' litros por dia.');
    end
    else
        writeLn('No se encontro el codigo');
end;

// Programa principal

var
    COD:TVstr; TOT,PROM:TVreal;
    N:byte;
    X:real;
begin
    leerArchivo(COD,TOT,PROM,N);
    writeLn('Codigo del tambo que mas leche entrego a la compania: ',maximo(COD,TOT,N));
    repeat
        writeLn('Ingrese un minimo promedio: ');
        readLn(X);
    until X>0;
    writeLn(contarSi(PROM,X,N),' superaron un promedio de ',X:0:2,' litros de entrega');
    informacion(COD,TOT,PROM,N);
end.