Program ejercicio1;

uses
    SysUtils;

const
    tope = 10;
    dolar = 360;
    impuesto = 0.75;
    descuento = 0.95;

type
    str10 = string[10];
    TR = record
        cereal: str10;
        cotizacion: real;
    end;
    TVreg = array [1..tope] of TR;
    TVstr = array [1..tope] of str10;
    TM = array [1..10,1..tope] of real;
    TRb = record
        codigo: byte;
        total: real;
    end;
    TVb = array [1..tope] of TRb;


// Subprogramas

// Dado un cereal, buscar su subindice (0 si no se encontró)
function buscar (x:str10; VCereales: TVstr; N:byte): byte;
begin
    if (N>0) and (VCereales[N]<>x) then
        buscar:=buscar(x,VCereales,N-1)
    else
        buscar:=N;
end;

// Llenar de 0s la columna de una matriz
procedure InicializarColumna(var EXPORTACIONES: TM; columna: byte);
var
    i: byte;
begin
    for i:=1 to 10 do
        EXPORTACIONES[i,columna]:=0;
end;

procedure leerExportaciones (var VCereales: TVstr; var N: byte; var EXPORTACIONES: TM);
var
    archivo: text;
    codigo,i: byte;
    cereal: str10;
    toneladas: real;
    blanco: char;
begin
    // Inicializar variables
    N:=0;

    // Abrir archivo
    assign(archivo,'Exportaciones.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,codigo,blanco,cereal,toneladas);
        cereal:=trim(cereal);
        i:=buscar(cereal,VCereales,N);
        if i=0 then
        begin
            N:=N+1;
            VCereales[N]:=cereal;
            InicializarColumna(EXPORTACIONES,N);
            i:=N;
        end;
        EXPORTACIONES[codigo,i]:=toneladas;
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure leerCotizaciones (var VCotizaciones: TVreg; var M: byte);
var
    archivo: text;
begin
    // Inicializar variable
    M:=0;

    // Abrir archivo
    assign(archivo,'Cereales.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        M:=M+1;
        with VCotizaciones[M] do
        begin
            readLn(archivo,cereal,cotizacion);
            cereal:=trim(cereal);
        end;
            
    end;

    // Cerrar archivo
    close(archivo);
end;

// Para un tipo de cereal C, contar silos

// Para una columna, contar en cuántas posiciones no hay 0s

function contarSi (EXPORTACIONES: TM; i,j:byte): byte;
begin
    if i=0 then
        contarSi:=0
    else
        if EXPORTACIONES[i,j]<>0 then
            contarSi:=1+contarSi(EXPORTACIONES,i-1,j)
        else
            contarSi:=contarSi(EXPORTACIONES,i-1,j);
end;

procedure incisoA (VCereales: TVstr; EXPORTACIONES: TM; N: byte);
var
    j: byte;
    C: str10;
begin
    // Ingreso de datos
    writeLn('Ingrese un cereal: ');
    readLn(C);

    // Buscar columna
    j:=buscar(C,VCereales,N);

    // Contar
    if j=0 then
        writeLn('El cereal no se guardo en ningun silo.')
    else
        writeLn('El cereal se guardo en ',contarSi(EXPORTACIONES,10,j),' silos.');
end;

// Dado un cereal, buscar su cotización
function cotizar (x: str10; VCotizaciones: TVreg; M: byte): real;
begin
    if M=0 then
        cotizar:=0
    else
        if VCotizaciones[M].cereal=x then
            cotizar:=VCotizaciones[M].cotizacion
        else
            cotizar:=cotizar(x,VCotizaciones,M-1);
end;


// Dado un silo, determinar su importe bruto en pesos

function importe (VCereales: TVstr; EXPORTACIONES: TM; VCotizaciones: TVreg; codigo,N,M: byte): real;
begin
    if N=0 then
        importe:=0
    else
        importe:=EXPORTACIONES[codigo,N]*cotizar(VCereales[N],VCotizaciones,M)*dolar+importe(VCereales,EXPORTACIONES,VCotizaciones,codigo,N-1,M);
end;

// Dado un silo, determinar sus toneladas en total

function toneladas (EXPORTACIONES: TM; N,codigo: byte): real;
begin
    if N=0 then
        toneladas:=0
    else
        toneladas:=EXPORTACIONES[codigo,N]+toneladas(EXPORTACIONES,N-1,codigo);
end;

// Generar arreglo de registros

procedure incisoB (var SILOS: TVb;VCereales: TVstr; EXPORTACIONES: TM; VCotizaciones: TVreg; N,M,i: byte; Z: real; var K: byte);
var
    imp: real;
begin
    if i>1 then
        incisoB(SILOS,VCereales,EXPORTACIONES,VCotizaciones,N,M,i-1,Z,K);
    
    // Resolver a la vuelta
     if toneladas(EXPORTACIONES,N,i)>Z then
     begin
        K:=K+1;
        imp:=importe(VCereales, EXPORTACIONES, VCotizaciones, i,N,M);
        with SILOS[K] do
            begin
                codigo:=i;
                if imp>100000000 then
                    total:=imp*impuesto
                else
                    total:=imp*descuento;
            end;
     end;
        
end;

procedure listar (SILOS: TVb; K: byte);
begin
    if K>1 then
        listar(SILOS,K-1);
    with SILOS[K] do
        writeLn('Silo: ',codigo,'. Recaudacion neta: $',total:4:2);
end;



// Programa principal

var
    EXPORTACIONES: TM;
    VCereales: TVstr;
    VCotizaciones: TVreg;
    N,M,K: byte;
    Z: real;
    SILOS: TVb;


begin
    // Ingresar datos
    leerExportaciones (VCereales, N, EXPORTACIONES);
    leerCotizaciones (VCotizaciones, M);

    // Inciso a
    incisoA (VCereales, EXPORTACIONES, N);

    // Inciso b
    K:=0;
    repeat
        writeLn('Ingrese toneladas: ');
        read(Z);
    until Z>0;
    incisoB (SILOS,VCereales,EXPORTACIONES,VCotizaciones, N,M,10, Z, K);
    writeLn('Silos con mayor tonelaje: ');
    listar(SILOS,K);
end.