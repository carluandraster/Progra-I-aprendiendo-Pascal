{Parcial del 22 de mayo del 2023}

Program repasoParcial;

const
    tope = 10;

type
    TMbyte = array [1..tope,1..tope] of byte;
    TMreal = array [1..tope,1..tope] of real;
    TR = record
        nivel,autos: byte;
        promedio: real;
    end;
    TV = array [1..tope] of TR;


// Subprogramas

procedure leerMatAutos (var MatAutos: TMbyte; var N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'autos.txt');
    reset(archivo);

    // Leer archivo
    readLn(archivo,N,M);
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,MatAutos[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

procedure leerMatHoras (var MatHoras: TMreal; N,M: byte);
var
    archivo: text;
    i,j: byte;
begin
    // Abrir archivo de texto
    assign(archivo,'horas.txt');
    reset(archivo);

    // Leer archivo
    for i:=1 to N do
        for j:=1 to M do
            read(archivo,MatHoras[i,j]);
    
    // Cerrar archivo
    close(archivo);
end;

// Dado un nivel, el total de autos que estacionaron durante el día

function totalDeAutos (nivel: byte; MatAutos: TMbyte; M: byte): byte;
begin
    if M=1 then
        totalDeAutos:=MatAutos[nivel,1]
    else
        totalDeAutos:=MatAutos[nivel,M]+totalDeAutos(nivel,MatAutos,M-1);
end;

// Dado un nivel, el total de tiempo de ocupación

function totalDeTiempo (nivel: byte; MatHoras: TMreal; M: byte): real;
begin
    if M=1 then
        totalDeTiempo:=MatHoras[nivel,1]
    else
        totalDeTiempo:=MatHoras[nivel,M]+totalDeTiempo (nivel,MatHoras,M-1);
end;

// Dado un nivel, determinar si todas sus plazas se ocuparon al menos una vez

function seOcupo (nivel: byte; MatAutos: TMbyte; M: byte):boolean;
begin
    if M=0 then
        seOcupo:=true
    else
        if MatAutos[nivel,M]=0 then
            seOcupo:=false
        else
            seOcupo:=seOcupo(nivel,MatAutos,M-1);
end;

// Armar el vector VNiveles

procedure arregloDeRegistros (var VNiveles: TV; var K: byte; MatAutos: TMbyte; MatHoras: TMreal; N,M: byte);
var
    i: byte;
begin
    // Inicializar variable
    K:=0;

    // Recorrer niveles
    for i:=1 to N do
        if seOcupo(i,MatAutos,M) then
        begin
            K:=K+1;
            with VNiveles[K] do
            begin
                nivel:=i;
                autos:=totalDeAutos(i,MatAutos,M);
                promedio:=totalDeTiempo(i,MatHoras,M)/autos;
            end;
        end;
end;

procedure mostrarArreglo (VNiveles: TV; K: byte);
begin
    if K<>1 then
        mostrarArreglo(VNiveles,K-1);
    with VNiveles[K] do
        writeLn('Nivel ',nivel,'. Total de autos: ',autos,'. Tiempo promedio de ocupacion por auto: ',promedio:4:2,' horas.');
end;

// Dado un nivel, determinar si al menos una plaza supera en cantidad de autos a x

function supera (nivel: byte; MatAutos: TMbyte; M,x: byte):boolean;
begin
    if M=0 then
        supera:=false
    else
        if MatAutos[nivel,M]>x then
            supera:=true
        else
            supera:=supera(nivel,MatAutos,M-1,x);
end;

// Contar cuántos niveles tienen al menos una plaza que haya superado a x en cantidad de autos

function contarSi (MatAutos: TMbyte; N,M,x: byte): byte;
begin
    if N=0 then
        contarSi:=0
    else
        if supera(N,MatAutos,M,x) then
            contarSi:=1+contarSi(MatAutos,N-1,M,x)
        else
            contarSi:=contarSi(MatAutos,N-1,M,x);
end;



// Programa principal

var
    MatAutos: TMbyte;
    MatHoras: TMreal;
    VNiveles: TV;
    N,M,K,x: byte;

begin
    // Ingresar datos por achivo
    leerMatAutos(MatAutos,N,M);
    leerMatHoras(MatHoras,N,M);

    // Inciso a
    arregloDeRegistros (VNiveles, K, MatAutos, MatHoras, N,M);
    mostrarArreglo(VNiveles,K);

    // Inciso b
    writeLn('Ingrese un numero: ');
    read(x);
    writeLn(contarSi(MatAutos,N,M,x),' niveles tienen al menos una plaza con mas de ',x,' autos.');
end.