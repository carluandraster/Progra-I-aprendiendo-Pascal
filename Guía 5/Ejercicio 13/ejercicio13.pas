{En una estación de peaje hay N cabinas por donde pasan varios vehículos. Desde un archivo se lee
la siguiente información:
• Número de cabina
• Tipo de vehículo (1=auto, 2=moto, 3=camioneta, 4=camión, 5=colectivo)
• Hora (0..23) 
Las tarifas son: moto = $150, auto y camioneta = $300, camión = $470, colectivo = $390.
Si la hora está entre las 10 y las 18 sufre un incremento del 10%.
Calcular e informar:
a) Cuántos vehículos atendió cada una de las N cabinas.
b) Cuál fue la que más importe recaudó.}

Program ejercicio13;

const
    // Tarifas
    moto=150;
    auto=300;
    camioneta=300;
    camion=470;
    colectivo=390;

    // Array
    tope=30;
type
    TVint = array [1..tope] of word; {En las estaciones de peaje de Bs As se atiende a mucho más que 255 vehiculos}
    TVlong = array [1..tope] of longint;

// Subprogramas

procedure limpiar(var A:TVint; var B:TVlong);
var
    i:byte;
begin
    for i:=1 to tope do
    begin
        A[i]:=0;
        B[i]:=0;
    end;
end;

procedure leerArchivo(var A:TVint; var B:TVlong; var N:byte);
var
    i,tipo,hora:byte;
    archivo:text;
    precio:word;

begin
    // Reconocer archivo de texto
    assign(archivo,'registros.txt');
    reset(archivo);

    // Inicializar arreglos y variables
    limpiar(A,B);
    N:=0;

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,i,tipo,hora);
        if i>N then N:=i;
        case tipo of
        {(1=auto, 2=moto, 3=camioneta, 4=camión, 5=colectivo)}
            1: precio:=auto;
            2: precio:=moto;
            3: precio:=camioneta;
            4: precio:=camion;
            5: precio:=colectivo;
        end;
        // Si la hora está entre las 10 y las 18 sufre un incremento del 10%.
        if (hora>=10) and (hora<18) then
            precio:=round(precio*1.1);
        
        // Contar auto y acumular recaudacion
        A[i]:=A[i]+1;
        B[i]:=B[i]+precio;
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Cuántos vehículos atendió cada una de las N cabinas.
procedure imprimirArr(A:TVint;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        writeLn('La cabina ',i,' atendio a ',A[i],' vehiculos.');
end;

// b) Cuál fue la que más importe recaudó
function maxRecaudacion(A:TVlong;N:byte):byte;
var
    i:byte;
    max:word;
begin
    // Inicializar maximo
    max:=0;

    for i:=1 to N do
        if A[i]>max then
        begin
            max:=A[i];
            maxRecaudacion:=i;
        end;
end;

// Programa principal

var
    A:TVint;
    B:TVlong;
    N:byte;

begin
    leerArchivo(A,B,N);
    imprimirArr(A,N);
    writeLn('La cabina que mas recaudo fue la cabina ',maxRecaudacion(B,N));
end.