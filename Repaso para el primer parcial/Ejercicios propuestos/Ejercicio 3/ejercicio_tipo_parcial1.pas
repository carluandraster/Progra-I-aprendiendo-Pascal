Program imprenta;

const
    tope = 255;

type
    TVreal = array [1..tope] of real;
    TVbyte = array [1..tope] of byte;
    TVstr = array [1..tope] of string;

// Subprogramas

// Procesar archivo y generar 3 arreglos paralelos: Costo, CantPal y MasLarga
procedure leerArchivo (var Costo: TVreal; var CantPal: TVbyte; var MasLarga: TVstr; var N:byte);
var
    archivo:text;
    caracter,tipo:char;
    contaCaracteres,factor,tamano,maximo:byte;
    palabra:string;
begin
    // Inicializar variables
    N:=0;

    // Reconocer archivo de texto
    assign(archivo,'imprenta.txt');
    reset(archivo);

    // Recorrer archivo
    while not eof(archivo) do
    begin
        // Inicializar variable para cada linea
        N:=N+1;
        maximo:=0;
        contaCaracteres:=0;
        CantPal[N]:=0;

        // Leer tipo y tamaño
        read(archivo,tipo,tamano);

        // Leer frase
        read(archivo,caracter);
        while caracter<>'.' do
        begin
            if caracter=' ' then
            begin
                if contaCaracteres>maximo then
                begin
                    maximo:=contaCaracteres;
                    MasLarga[N]:=palabra;
                end;
                contaCaracteres:=0;
                palabra:='';
            end
            else
            begin
                palabra:=palabra+caracter;
                contaCaracteres:=contaCaracteres+1;
                if contaCaracteres=1 then
                    CantPal[N]:=CantPal[N]+1;
            end;
            read(archivo,caracter);
        end;
        
        // Calcular costo
        case tipo of
            'A': factor:=2;
            'B': factor:=3;
            'C': factor:=5;
        end;
        if tamano=2 then
            Costo[N]:=CantPal[N]*factor*1.5
        else
            Costo[N]:=CantPal[N]*factor;

        // Salto de linea
        readLn(archivo);
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Indicar el costo del folleto que contenga la palabra mas larga, 
// si hay mas de uno el costo promedio de los mismos
function maximo (Costo: TVreal;  MasLarga: TVstr; N:byte):real;
var
    i,contador:byte;
    max,acumulador:real;
begin
    // Inicializar variables
    max:=-1;

    // Recorrer arreglos
    for i:=1 to N do
    begin
        if length(MasLarga[i])>max then
        begin
            max:=length(MasLarga[i]);
            contador:=1;
            acumulador:=Costo[i];
        end
        else
            if length(MasLarga[i])=max then
            begin
                contador:=contador+1;
                acumulador:=acumulador+Costo[i];
            end;
    end;

    // Devolver resultado
    maximo:=acumulador/contador;
end;

{b) Para un entero N que ingresa por teclado, buscar el primer folleto que contenga exactamente
N palabras y mostrar su costo (considerar que puede no existir)}
function informacion (CantPal:TVbyte; Costo:TVreal; x,N:byte):real;
var
    i:byte;
begin
    i:=1;
    while (i<=N) and (CantPal[i]<>x) do
        i:=i+1;
    if CantPal[i]=x then
        informacion:=Costo[i]
    else
        informacion:=0;
end;

// Programa principal

var
    Costo: TVreal;
    CantPal: TVbyte;
    MasLarga: TVstr;
    x,N:byte;
    maxCosto:real;

begin
    leerArchivo (Costo, CantPal, MasLarga, N);
    writeLn('Los folletos con las palabras mas largas costaron en promedio $',maximo(Costo,MasLarga,N):0:2);
    repeat
        writeLn('Ingrese un numero entero: ');
        readLn(x);
    until x>0;
    maxCosto:=informacion(CantPal,Costo,x,N);
    if maxCosto=0 then
        writeLn('Lo sentimos pero ninguna frase contiene ',x,' palabras.')
    else
        writeLn('Costo de folleto de ',x,' palabras: $',maxCosto:0:2);
end.