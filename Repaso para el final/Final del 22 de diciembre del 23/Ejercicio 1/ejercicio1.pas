Program ejercicio1;

const
    TOPE = 5;
    MAXDISTRITOS = 50;
    CENTINELA = 99;

type
    TV = array [1..TOPE] of word;
    str15 = string[15];

    // VOTOS_ACUM.DAT
    TRA = record
        numDistrito,numPartido: byte;
        PARTIDOS: TV;
        nombre: str15;
    end;
    TAA = file of TRA;
    TM = array [1..TOPE,1..MAXDISTRITOS] of word;

    // VOTOS_PARCIAL.DAT
    TRP = record
        numDistrito, numPartido: byte;
        cantVotos: word;
    end;
    TAP = file of TRP;

    // DISTRITO.DAT
    TRD = record
        numDistrito: byte;
        nombre: str15;
    end;
    TAD = file of TRD;

// Subprogramas

procedure CargarVotosAcum(var VOTOS_ACUM: TAA);
var
  archivoTexto: Text;
  reg: TRA;
  i: byte;
begin
  Assign(archivoTexto, './txt/VOTOS_ACUM.TXT');
  Reset(archivoTexto);
  Rewrite(VOTOS_ACUM);

  while not eof(archivoTexto) do
  begin
    Read(archivoTexto, reg.numDistrito);
    if reg.numDistrito<CENTINELA then
        for i := 1 to TOPE do
            Read(archivoTexto, reg.PARTIDOS[i]);
    Write(VOTOS_ACUM, reg);
  end;

  Close(archivoTexto);
  Close(VOTOS_ACUM);
end;

procedure CargarVotosParcial(var VOTOS_PARCIAL: TAP);
var
  archivoTexto: Text;
  reg: TRP;
begin
  Assign(archivoTexto, './txt/VOTOS_PARCIAL.TXT');
  Reset(archivoTexto);
  Rewrite(VOTOS_PARCIAL);

  while not eof(archivoTexto) do
  begin
    Read(archivoTexto, reg.numDistrito);
    if reg.numDistrito <> CENTINELA then
    begin
        Read(archivoTexto, reg.numPartido);
        Read(archivoTexto, reg.cantVotos);
    end;
    Write(VOTOS_PARCIAL, reg);
  end;

  Close(archivoTexto);
  Close(VOTOS_PARCIAL);
end;

procedure CargarDistritos(var DISTRITO: TAD);
var
  archivoTexto: Text;
  reg: TRD;
  blanco: char;
begin
  Assign(archivoTexto, './txt/DISTRITO.TXT');
  Reset(archivoTexto);
  Rewrite(DISTRITO);

  while not eof(archivoTexto) do
  begin
    Read(archivoTexto, reg.numDistrito);
    if reg.numDistrito <> CENTINELA then
        Readln(archivoTexto,blanco, reg.nombre);
    Write(DISTRITO, reg);
  end;

  Close(archivoTexto);
  Close(DISTRITO);
end;

procedure buscar (numDistrito: byte; var DISTRITO: TAD; var nombre: str15);
var
    registro: TRD;
begin
    reset(DISTRITO);
    seek(DISTRITO,numDistrito-1);
    read(DISTRITO,registro);
    nombre:=registro.nombre;
    close(DISTRITO);
end;

function maximo (PARTIDOS: TV; N: byte): byte;
var
    maxAux: byte;
begin
    if N=1 then
        maximo:=1
    else
    begin
        maxAux:=maximo(PARTIDOS,N-1);
        if PARTIDOS[N]>PARTIDOS[maxAux] then
            maximo:=N
        else
            maximo:=maxAux;
    end;
end;

// Inciso a

procedure enfrentamiento (
    var VOTOS_ACUM: TAA; var VOTOS_PARCIAL: TAP; var DISTRITO: TAD; 
    var MATRIZ: TM; var N: byte
);
var
    regAcum: TRA;
    regParcial: TRP;
    TEMP: TAA;
    i: byte;
begin
    Assign(TEMP,'./dat/TEMP.DAT');
    Rewrite(TEMP);
    reset(VOTOS_ACUM);
    reset(VOTOS_PARCIAL);
    N:=1;

    read(VOTOS_ACUM,regAcum);
    read(VOTOS_PARCIAL,regParcial);
    while not eof(VOTOS_ACUM) or not eof(VOTOS_PARCIAL) do
        if regAcum.numDistrito<regParcial.numDistrito then
        begin
            with regAcum do
            begin
                buscar(numDistrito,DISTRITO,nombre);
                numPartido:=maximo(PARTIDOS,TOPE);
                for i:=1 to TOPE do
                    MATRIZ[N,i]:=PARTIDOS[i];
            end;
            N:=N+1;
            write(TEMP,regAcum);
            read(VOTOS_ACUM,regAcum);
        end
        else
        begin
            if regAcum.numDistrito>regParcial.numDistrito then
                writeLn('Error: el distrito ',regParcial.numDistrito,' no existe.')
            else
                regAcum.PARTIDOS[regParcial.numPartido]:=regAcum.PARTIDOS[regParcial.numPartido]+regParcial.cantVotos;
            read(VOTOS_PARCIAL,regParcial);
        end;
    write(TEMP,regAcum);
            

    close(VOTOS_ACUM);
    close(VOTOS_PARCIAL);
    close(TEMP);

    erase(VOTOS_ACUM);
    rename(TEMP,'./dat/VOTOS_ACUM.DAT');
end;

procedure suma (MATRIZ: TM; N: byte; var VOTOS: TV);
var
    i,j: byte;
begin
    for j:=1 to TOPE do
    begin
        VOTOS[j]:=0;
        for i:=1 to N do
            VOTOS[j]:=VOTOS[j]+MATRIZ[i,j];
    end;
end;

// Inciso b

procedure corte (X: word; VOTOS: TV);
var
    i: byte;
begin
    writeLn('TOTALES GENERALES POR PARTIDO');
    writeLn('PARTIDO      TOTALES');
    for i:=1 to TOPE do
        if VOTOS[i]>X then
            writeLn(i:4,'         ',VOTOS[i]:5);
end;

procedure mostrarArchivo (var VOTOS_ACUM: TAA);
var
    archivoTexto: Text;
    registro: TRA;
    i: byte;
begin
    Assign(archivoTexto,'./txt/ACUM_ACTUALIZADO.TXT');
    rewrite(archivoTexto);
    reset(VOTOS_ACUM);
    while not eof(VOTOS_ACUM) do
    begin
        read(VOTOS_ACUM,registro);
        if registro.numDistrito=CENTINELA then
            write(archivoTexto,CENTINELA)
        else
            with registro do
            begin
                write(archivoTexto,numDistrito);
                for i:=1 to TOPE do
                    write(archivoTexto,' ',PARTIDOS[i]);
                write(archivoTexto,' ',nombre,' ',numPartido);
                writeLn(archivoTexto);  
            end;
        
    end;
    close(archivoTexto);
    close(VOTOS_ACUM);
end;


// Programa principal

var
    VOTOS_ACUM: TAA;
    VOTOS_PARCIAL: TAP;
    DISTRITO: TAD;
    MATRIZ: TM;
    N: byte;
    VOTOS: TV;
    X: word;

    i,j: byte;

begin
    assign(VOTOS_ACUM,'./dat/VOTOS_ACUM.DAT');
    assign(VOTOS_PARCIAL,'./dat/VOTOS_PARCIAL.DAT');
    Assign(DISTRITO,'./dat/DISTRITO.DAT');
    
    CargarVotosAcum(VOTOS_ACUM);
    CargarVotosParcial(VOTOS_PARCIAL);
    CargarDistritos(DISTRITO);

    enfrentamiento (VOTOS_ACUM,VOTOS_PARCIAL,DISTRITO,MATRIZ,N);        
    mostrarArchivo(VOTOS_ACUM);

    suma (MATRIZ,N,VOTOS);
    writeLn('Ingrese una cantidad minima de votos: ');
    Readln(X);
    corte (X,VOTOS);
end.