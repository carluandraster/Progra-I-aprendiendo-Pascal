Program repasoParcial;

uses
    SysUtils;

const
    tope = 50;

type
    str8 = string[8];
    str2 = string[2];
    str30 = string[30];

    TRins = record
        dni: str8;
        edad: byte;
    end;
    TVins = array [1..tope] of TRins;
    TR = record
        N: byte;
        inscriptos: TVins;
    end;
    TM = array [1..9,1..tope] of TR;

    TRprov = record
        codigo: str2;
        nombre: str30;
    end;
    TVprov = array [1..tope] of TRprov;

    TRprovRan = record
        provincia: str30;
        rango: byte;
    end;
    TVpR = array [1..tope] of TRprovRan;


// Subprogramas

// Dado un codigo de provincia, devolver indice

function buscar (x: str2; Provincias: TVprov; M: byte): byte;
begin
    if (M<>0) and (Provincias[M].codigo<>x) then
        buscar:=buscar(x,Provincias,M-1)
    else
        buscar:=M;  
end;

procedure InicializarProvincia (var INSCRIPTOS: TM; columna: byte);
var
    i: byte;
begin
    for i:=1 to 9 do
        INSCRIPTOS[i,columna].N:=0;
end;

procedure cargarInscriptos (var INSCRIP: TM; var M: byte; var PROVINCIAS: TVprov);
var
    i,age: byte;
    archivo: text;
    code: str2;
    blanco: char;
    documento: str8;
begin
    // Inicializar variables
    M:=0;
    
    // Abrir archivo
    assign(archivo,'INSCRIPTOS.TXT');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,documento,age,blanco,code);
        i:=buscar (code, Provincias, M);
        if i=0 then
        begin
            M:=M+1;
            i:=M;
            InicializarProvincia (INSCRIP, i);
            Provincias[i].codigo:=code;
        end;
        with INSCRIP[age div 10,i] do
        begin
            N:=N+1;
            with inscriptos[N] do
            begin
                dni:=documento;
                edad:=age;
            end;
        end;
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure cargarProvincias (var Provincias: TVprov; M: byte);
var
    archivo: text;
    cod,blanco: str2;
    nom: str30;
    i: byte;
begin
    // Abrir archivo
    assign(archivo,'PROVINCIAS.TXT');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,cod,blanco,nom);
        nom:=trim(nom);
        i:=buscar (cod, Provincias, M);
        if i<>0 then
            Provincias[i].nombre:=nom;
    end;

    // Cerrar archivo
    close(archivo);
end;

// a) Contar rangos etarios sin inscriptos para una provincia

function contarSi (INSCRIP: TM; M: byte; x: str2; Provincias: TVprov): byte; {Asumo que la provincia existe (se valida en el programa principal)}
var
    contador,i,busc: byte;
begin
    // Inicializar variable
    contador:=0;
    busc:=buscar (x, Provincias, M);

    // Recorrer y sumar
    for i:=1 to 9 do
        if INSCRIP[i,busc].N=0 then
            contador:=contador+1;
    
    // Devolver resultado
    contarSi:=contador;
end;

// Dado un rango etario y una provincia, contar estudiantes

function contarRango (INSCRIP: TM; columna,R,T: byte): byte;
var
    i,j,contador: byte;
begin
    contador:=0;
    for i:=1 to 9 do
        for j:=1 to INSCRIP[i,columna].N do
            if (INSCRIP[i,columna].inscriptos[j].edad>=R) and (INSCRIP[i,columna].inscriptos[j].edad<T) then
                contador:=contador+1;
    contarRango:=contador;
end;

// La provincia con menos cantidad total de inscriptos en los rangos etarios ubicados entre el rango R y 
// el rango T (asumir que es una sola)

function minimo (INSCRIP: TM; M,R,T: byte; Provincias: TVprov): str30;
var
    minAux,minIn,j,conta: byte;
begin
    minAux:=255;
    for j:=1 to M do
    begin
        conta:=contarRango(INSCRIP,j,R,T);
        if conta<minAux then
            begin
                minAux:=conta;
                minIn:=j;
            end;
    end;
    minimo:=Provincias[minIn].nombre;
end;

// Calcular el total de inscriptos

function totalInscriptos (INSCRIP: TM; i,j,M: byte): byte;
begin
    if (j=0) and (i>1) then
        totalInscriptos:=totalInscriptos(INSCRIP,i-1,M,M)
    else
        if (j=0) and (i=1) then
            totalInscriptos:=0
        else
            totalInscriptos:=INSCRIP[i,j].N+totalInscriptos(INSCRIP,i,j-1,M);
end;

// Generar un arreglo con los pares provincia-rango etario que superen el 10% del total de inscriptos en la carrera

procedure GenerarArreglo (INSCRIP: TM; var ProvRango: TVpR; var T: byte; M: byte; Provincias: TVprov);
var
    i,j,total: byte;
begin
    T:=0;
    total:=totalInscriptos(INSCRIP,9,M,M);
    for i:=1 to 9 do
        for j:=1 to M do
            if INSCRIP[i,j].N>0.1*total then
            begin
                T:=T+1;
                ProvRango[T].provincia:=Provincias[j].nombre;
                ProvRango[T].rango:=i*10;
            end;
end;

// Mostrar arreglo generado

procedure imprimirArreglo (ProvRango: TVpR; T: byte);
var
    i: byte;
begin
    for i:=1 to T do
        writeLn(ProvRango[i].provincia,'. Rango etario: ',ProvRango[i].rango,'-',ProvRango[i].rango+9);
end;


// Programa principal

var
    Provincias: TVprov;
    INSCRIP: TM;
    R,T,M: byte;
    ProvRango: TVpR;
    x: str2;

begin
    // Ingresar datos por archivo
    cargarInscriptos(INSCRIP, M, Provincias);
    cargarProvincias (Provincias, M);

    // Inciso a
    writeLn('Ingrese un codigo de provincia: ');
    readLn(x);
    if buscar (x, Provincias, M)=0 then
        writeLn('No se encontro la provincia. Lo sentimos.')
    else
        writeLn('Cantidad de rangos etarios sin inscriptos: ',contarSi (INSCRIP, M, x,Provincias));
    
    // Inciso b
    writeLn('Ingrese limite inferior y superior de rango etario: ');
    readLn(R,T);
    writeLn('Provincia con menos cantidad total de inscriptos en los rangos etarios: ',minimo (INSCRIP, M,R,T, Provincias));

    // Inciso c
    GenerarArreglo (INSCRIP, ProvRango, T, M, Provincias);
    writeLn('Provincias y rangos estarios que superan el 10% del total: ');
    imprimirArreglo (ProvRango, T);
end.