{ Una compañía Láctea recibe la producción diaria en litros de leche, de N tambos de la zona,
durante quince días.
Los datos vienen de la siguiente manera, sin orden alguno:
 Código del Tambo (cadena de 4 caracteres) puede repetirse
 dia
 la entrega en litros.
Se pide, armar 3 vectores paralelos, COD, TOT, ENTREGAS y además calcular e informar:
a) Código del tambo que más leche entregó a la compañía.
b) Cuántos superaron un promedio de X litros de entrega.
c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).
COD con los códigos de cada Tambo
TOT con los totales de litros entregados
ENTREGAS con La cantidad total de entregas}

Program ejercicio2;

const
    tope = 255;

type
    str4 = string[4];
    TVstr = array [1..tope] of str4;
    TVreal = array [1..tope] of real;
    TVbyte = array [1..tope] of byte;

// Subprogramas

function busqueda(x:string;B:TVstr;N:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=N) and (B[i]<>x) do
        i:=i+1;
    if B[i]<>x then
        busqueda:=0
    else
        busqueda:=i;
end;

procedure leerArchivo(var COD:TVstr; var TOT:TVreal; var ENTREGAS:TVbyte; var N:byte);
var
    i,dia:byte;
    archivo:text;
    codigo:str4;
    entrega:real;
begin
    // Inicializar variable
    N:=0;

    // Reconocer archivo de texto
    assign(archivo,'TAMBOS.TXT');
    reset(archivo);

    // Recorrer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,codigo,dia,entrega);
        i:=busqueda(codigo,COD,N);
        if i<>0 then
        begin
            TOT[i]:=TOT[i]+entrega;
            ENTREGAS[i]:=ENTREGAS[i]+1;
        end
        else
        begin
            N:=N+1;
            COD[N]:=codigo;
            TOT[N]:=entrega;
            ENTREGAS[N]:=1;
        end;
    end;
end;

// a) Código del tambo que más leche entregó a la compañía.
function maximo (TOT:TVreal;COD:TVstr;N:byte):str4;
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
function contarSi (x:real; TOT:TVreal; ENTREGAS:TVbyte; N:byte):byte;
var
    i,contador:byte;
begin
    contador:=0;
    for i:=1 to N do
        if TOT[i]/ENTREGAS[i]>X then
            contador:=contador+1;
    contarSi:=contador;
end;

// c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).
procedure informacion (COD: TVstr; TOT: TVreal; ENTREGAS: TVbyte; N:byte);
var
    i:byte;
    x:string;
begin
    // Ingreso de datos
    writeLn('Ingrese un codigo: ');
    readLn(x);

    // Busqueda
    i:=busqueda(x,COD,N);

    // Imprimir info
    if i=0 then
        writeLn('Lo sentimos pero ese codigo no esta en nuestra base de datos')
    else
    begin
        writeLn('Total entregado: ',TOT[i]:0:2,' litros.');
        writeLn('Promedio diario entregado: ',TOT[i]/ENTREGAS[i]:0:2,' litros');
    end;
end;

// Programa principal

var
    COD:TVstr; 
    TOT:TVreal; 
    ENTREGAS:TVbyte; 
    N:byte;
    x:real;

begin
    leerArchivo(COD,TOT,ENTREGAS,N);
    writeLn('Codigo del tambo que mas leche entrego a la compania: ',maximo (TOT,COD,N));
    repeat
        writeLn('Ingrese un promedio minimo de litros de entrega: ');
        readLn(x);
    until x>0;
    writeLn(contarSi (x, TOT, ENTREGAS,N),' superaron un promedio de ',X:0:2,' litros de entrega');
    informacion (COD, TOT, ENTREGAS, N);
end.