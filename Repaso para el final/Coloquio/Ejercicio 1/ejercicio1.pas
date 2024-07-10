Program ejercicio1;

const
    TOPE = 255;

type
    // Cadenas de texto
    str6 = string[6];
    str30 = string[30];

    // CANCIONES.DAT
    TRC = record
        id: str6;
        genero: byte;
        nombre: str30;
        disponible: char;
        duracion: word;
    end;
    TAC = file of TRC;

    // INTERPRETES.DAT
    TRI = record
        id: str6;
        nombre: str30;
        contrato: char;
    end;
    TAI = file of TRI;
    TVI = array [1..TOPE] of TRI;

// Subprogramas

procedure cargarCanciones (var CANCIONES: TAC);
var
    archivo: text;
    blanco: char;
    registro: TRC;
begin
    // Abrir archivos
    assign(archivo,'./txt/CANCIONES.TXT');
    reset(archivo);
    rewrite(CANCIONES);

    // Copiar archivo
    while not eof(archivo) do
    begin
        with registro do
            readLn(archivo,id,genero,blanco,nombre,disponible,duracion);
        write(CANCIONES,registro);
    end;

    // Cerrar archivos
    close(archivo);
    close(CANCIONES);
end;

procedure cargarInterpretes(var INTERPRETES: TAI);
var
    archivo: text;
    blanco: char;
    registro: TRI;
begin
    // Abrir archivos
    assign(archivo,'./txt/INTERPRETES.TXT');
    reset(archivo);
    rewrite(INTERPRETES);

    // Copiar archivo
    while not eof(archivo) do
    begin
        with registro do
            readLn(archivo,id,blanco,nombre,contrato);
        write(INTERPRETES,registro);
    end;

    // Cerrar archivos
    close(archivo);
    close(INTERPRETES);
end;

procedure leerInterpretes (var INTERPRETES: TAI; var ARRINTER: TVI; var N: byte);
begin
    reset(INTERPRETES);
    N:=0;
    while not eof (INTERPRETES) do
    begin
        N:=N+1;
        read(INTERPRETES,ARRINTER[N]);
    end;
    close(INTERPRETES);
end;

function buscar (id: str6; ARRINTER: TVI; N: byte): byte;
begin
    if (N=0) or (ARRINTER[N].id=id) then
        buscar:=N
    else
        buscar:=buscar(id,ARRINTER,N-1);
end;

procedure corte (var CANCIONES: TAC; ARRINTER: TVI; X,N: byte);
var
    registro: TRC;
    i,contDisponibles,contNoDisponibles: byte;
    duracionTotal: word;
begin
    reset(CANCIONES);
    read(CANCIONES,registro);
    duracionTotal:=0;
    while not eof(CANCIONES) do
    begin
        i:=buscar(registro.id,ARRINTER,N);
        if ARRINTER[i].contrato='S' then
        begin
            writeLn('Nombre interprete: ',ARRINTER[i].nombre);
            writeLn('Nombre de los temas del Genero ',X);
            contDisponibles:=0;
            contNoDisponibles:=0;
            while (registro.id=ARRINTER[i].id) and not eof(CANCIONES) do
            begin
                if registro.disponible='S' then
                    contDisponibles:=contDisponibles+1
                else
                    contNoDisponibles:=contNoDisponibles+1;
                if registro.genero=X then
                begin
                    writeLn(registro.nombre);
                    duracionTotal:=duracionTotal+registro.duracion;
                end;
                read(CANCIONES,registro);
            end;
            writeLn('Cantidad de Temas Disponibles: ',contDisponibles);
            writeLn('Cantidad de Temas No Disponibles: ',contNoDisponibles);
        end
        else
            while registro.id=ARRINTER[i].id do
            begin
                if registro.genero=X then
                    duracionTotal:=duracionTotal+registro.duracion;
                if not eof (CANCIONES) then
                    read(CANCIONES,registro);
            end;
    end;
    writeLn('Duracion Total de los Temas del Genero ',X,': ',duracionTotal);

    close(CANCIONES);
end;


// Programa principal

var
    CANCIONES: TAC;
    INTERPRETES: TAI;
    ARRINTER: TVI;
    X,N: byte;

begin
    assign(CANCIONES,'./dat/CANCIONES.DAT');
    assign(INTERPRETES,'./dat/INTERPRETES.DAT');
    cargarCanciones(CANCIONES);
    cargarInterpretes(INTERPRETES);
    leerInterpretes (INTERPRETES, ARRINTER, N);
    repeat
        writeLn('Ingrese un genero: ');
        readLn(X);
    until X in [1..5];
    corte(CANCIONES,ARRINTER,X,N);
end.