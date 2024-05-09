{Dado un conjunto de puntos en el plano, almacenar en un arreglo sus coordenadas junto con la
distancia al centro de coordenadas y a qué cuadrante pertenece.
Usando el arreglo, se pide:
 Informar el más cercano y más lejano al centro.
 Porcentaje de puntos en cada cuadrante (1..4, centro, eje X, eje Y).
Cada punto en el plano P tiene una coordenada X y otra Y. Desarrollar la función Distancia que
dados dos puntos P y Q devuelva la distancia entre ambos.}

Program ejercicio3;

const
    tope = 100;

type
    TR = record
        x,y: real;
    end;

    TV = array [1..tope] of TR;

    str29 = string[29];

// Subprogramas

procedure leerArchivo (var PUNTOS: TV; var N: byte);
var
    archivo: text;
begin
    // Inicializar variables
    N:=0;

    // Abrir archivo
    assign(archivo,'coordenadas.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        with PUNTOS[N] do
            readLn(archivo,x,y);
    end;

    // Cerrar archivo
    close(archivo);
end;

function ubicacion (punto: TR): char;
begin
    with punto do
    begin
        if (x=0) or (y=0) then
            if (x=0) and (y=0) then
                ubicacion:='C'
            else
                if x=0 then
                    ubicacion:='Y'
                else
                    ubicacion:='X'
        else
            if x>0 then
                if y>0 then
                    ubicacion:='1'
                else
                    ubicacion:='4'
            else
                if y>0 then
                    ubicacion:='2'
                else
                    ubicacion:='3';
    end;
end;

// Desarrollar la función Distancia que dados dos puntos P y Q devuelva la distancia entre ambos
function Distancia (P,Q: TR): real;
begin
    Distancia:=sqrt(sqr(P.x-Q.x)+sqr(P.y-Q.y)); {Por teorema de Pitágoras}
end;

// Informar el punto más cercano y el más lejano al centro.

function cercano (PUNTOS: TV; N: byte): byte;
var
    minimo,dist: real;
    i: byte;
    origen: TR;
begin
    // Inicializar variables
    minimo:=99999999;
    with origen do
    begin
        x:=0;
        y:=0;
    end;

    // Buscar punto más cercano al origen
    for i:=1 to N do
    begin
        dist:=Distancia(PUNTOS[i],origen);
        if dist<minimo then
        begin
            minimo:=dist;
            cercano:=i;
        end;
    end;
end;

function lejano (PUNTOS: TV; N: byte): byte;
var
    maximo,dist: real;
    i: byte;
    origen: TR;
begin
    // Inicializar variables
    maximo:=-1;
    with origen do
    begin
        x:=0;
        y:=0;
    end;

    // Buscar punto más lejano al origen
    for i:=1 to N do
    begin
        dist:=Distancia(PUNTOS[i],origen);
        if dist>maximo then
        begin
            maximo:=dist;
            lejano:=i;
        end;
    end;
end;

// Porcentaje de puntos en cada cuadrante (1..4, centro, eje X, eje Y).

function Porcentaje (PUNTOS: TV; N: byte; cuadrante: char):real;
var
    i,contador: byte;
begin
    // Inicializar variables
    contador:=0;

    // Recorrer arreglo
    for i:=1 to N do
        if ubicacion(PUNTOS[i])=cuadrante then
            contador:=contador+1;
    
    // Devolver un resultado
    Porcentaje:=contador/N*100;
end;

procedure escribirPorcentajes (PUNTOS: TV; N: byte);
begin
    writeLn('Porcentaje de puntos en el centro: ',Porcentaje(PUNTOS,N,'C'):4:2,'%');
    writeLn('Porcentaje de puntos en el eje x: ',Porcentaje(PUNTOS,N,'X'):4:2,'%');
    writeLn('Porcentaje de puntos en el eje y: ',Porcentaje(PUNTOS,N,'Y'):4:2,'%');
    writeLn('Porcentaje de puntos en el primer cuadrante: ',Porcentaje(PUNTOS,N,'1'):4:2,'%');
    writeLn('Porcentaje de puntos en el segundo cuadrante: ',Porcentaje(PUNTOS,N,'2'):4:2,'%');
    writeLn('Porcentaje de puntos en el tercer cuadrante: ',Porcentaje(PUNTOS,N,'3'):4:2,'%');
    writeLn('Porcentaje de puntos en el cuarto cuadrante: ',Porcentaje(PUNTOS,N,'4'):4:2,'%');
end;

procedure imprimirPunto(punto: TR; texto: str29);
begin
    with punto do
        writeLn(texto,'(',x:4:2,' ; ',y:4:2,')');
end;

// Programa principal

var
    PUNTOS: TV;
    N: byte;

begin
    leerArchivo(PUNTOS, N);

    // Inciso a
    imprimirPunto(PUNTOS[cercano(PUNTOS, N)],'Punto mas cercano al origen: ');
    imprimirPunto(PUNTOS[lejano(PUNTOS, N)],'Punto mas lejano al origen: ');

    // Inciso b
    escribirPorcentajes(PUNTOS, N);
end.