Program emails;

const
    tope = 255;

type
    str64 = string[64];
    TV = array [0..tope] of str64;
    TVbyte = array [0..tope] of byte;

// Subprogramas

function esEspecial(x:char):boolean;
begin
    esEspecial:=not ((upcase(x) in ['A'..'B']) or (upcase(x) in ['0'..'9']));
end;

// Convierte el archivo de texto a vector
procedure leerArchivo(var usernames: TV;var N:byte);
var
    archivo:text;
    contaP:byte;
    caracter:char;
begin
    N:=0;
    assign(archivo,'emails.txt');
    reset(archivo);

    read(archivo,caracter);
    while caracter<>':' do
    begin
        N:=N+1;
        usernames[N]:='';
        while (caracter<>'@') and not esEspecial(caracter) do
        begin
            usernames[N]:=usernames[N]+caracter;
            read(archivo,caracter);
        end;
        if caracter<>'@' then
        begin
            N:=N-1;
            repeat
                read(archivo,caracter);
            until (caracter=';') or (caracter=':');
        end
        else
        begin
            contaP:=0;
            read(archivo,caracter);
            repeat
                if esEspecial(caracter) and (caracter<>'.') then
                begin
                    N:=N-1;
                    repeat
                        read(archivo,caracter);
                    until (caracter=';') or (caracter=':');
                end  
                else
                    if caracter='.' then
                        contaP:=contaP+1;
                read(archivo,caracter);
            until (caracter=';') or (caracter=':');
            if contaP <> 1 then
                N:=N-1;
            read(archivo,caracter);
        end;
    end;

    close(archivo);
end;

function contarSi (N,M:byte;usernames:TV):byte;
var
    contarAux,i:byte;
begin
    contarAux:=0;
    for i:=1 to M do
        if N = length(usernames[i]) then
            contarAux:=contarAux+1;
    contarSi:=contarAux;
end;

procedure longitudes (usernames:TV; var long:TVbyte;N:byte;var maxLong:byte);
var
    i:byte;
begin
    maxLong:=0;
    for i:=1 to N do
    begin
        long[i]:=length(usernames[i]);
        if length(usernames[i])>maxLong then
            maxLong:=length(usernames[i]);
    end;
        
end;

function contador (x,N:byte;A:TVbyte):byte;
var
    i,contadorAux:byte;
begin
    contadorAux:=0;
    for i:=1 to N do
        if A[i]=x then
            contadorAux:=contadorAux+1;
    contador:=contadorAux;
end;

procedure ocurrencias (long:TVbyte;N,maxLong:byte; var apariciciones:TVbyte);
var
    i:byte;
begin
    for i:=1 to maxLong do
        apariciciones[i]:=contador(i,N,long);
end;

function maxOcurrencias (apariciciones:TVbyte;maxLong:byte):byte;
var
    i,max:byte;
begin
    max:=0;
    for i:=1 to maxLong do
        if apariciciones[i]>max then
        begin
            max:=apariciciones[i];
            maxOcurrencias:=i;
        end;
end;

function porcentaje (maxOcurrencias,N:byte):real;
begin
    porcentaje:=maxOcurrencias/N*100;
end;

procedure imprimirRespuesta(usernames:TV;N:byte);
var
    maxLong,maxOc:byte;
    long,apariciciones:TVbyte;
begin
    longitudes (usernames, long,N, maxLong);
    ocurrencias (long,N,maxLong, apariciciones);
    maxOc:= maxOcurrencias (apariciciones,maxLong);
    writeLn('La longitud de nombre de usuario mas usada es ',long[maxOc]);
    writeLn('Eso representa un ',porcentaje(maxOc,N):3:2,'% del total');
end;

// Programa principal

var
    usernames: TV;
    N,M:byte;
begin
    leerArchivo(usernames,N);
    writeLn('Ingrese una longitud: ');
    readLn(M);
    writeLn('Hay ',contarSi (M,N,usernames),' nombres de usuario que tienen ',M,' caracteres');
    imprimirRespuesta(usernames,N);
end.