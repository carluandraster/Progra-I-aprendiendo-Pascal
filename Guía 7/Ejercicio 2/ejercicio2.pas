{En una matriz Tablero de 8x8 se almacenó una jugada de ajedrez. Además, se sabe la 
posición (i,j) de una de las Torres Negras, y que juegan las negras. Determinar e informar
a qué piezas “defiende” la Torre y a cuáles “amenaza”, sabiendo que las piezas tienen dos
atributos:
 Tipo: R = Rey, Q = Reina, A = Alfil, T = Torre, C = Caballo, P = Peón
 Color: 1 = Blanco, 2 = Negro
Nota: armar el Tablero leyendo desde archivo, donde en cada línea viene (fila, col, Tipo,
Color) }

Program ejercicio2;

const
    tope = 8;

type
    TR = record
        tipo: char;
        color: byte;
    end;

    TM = array [1..tope,1..tope] of TR;

    TV = array [1..4] of char;

// Subprogramas

procedure inicializarMatriz (var Tablero: TM);
var
    i,j:byte;
begin
    for i:=1 to tope do
        for j:=1 to tope do
            with Tablero[i,j] do
                color:=0;
end;

procedure leerArchivo (var Tablero: TM);
var
    i,j: byte;
    archivo: text;
begin
    // Inicializar variables
    inicializarMatriz(Tablero);

    // Abrir archivo
    assign(archivo,'tablero.txt');
    reset(archivo);

    // Leer archivo
    while not eof (archivo) do
        readLn(archivo,i,j,Tablero[i,j].tipo,Tablero[i,j].color);
    
    // Cerrar archivo
    close(archivo);
end;

// Encontrar una torre negra

procedure encontrarPieza (Tablero: TM; var i,j: byte);
begin
    // Inicializar variables
    i:=1;
    j:=1;

    // Recorrer tablero en busca de la pieza
    while (i<=8) and ((Tablero[i,j].tipo<>'T') or (Tablero[i,j].color<>2)) do
    begin
        while (j<=8) and ((Tablero[i,j].tipo<>'T') or (Tablero[i,j].color<>2)) do
            j:=j+1;
        if j>8 then
        begin
            i:=i+1;
            j:=1;
        end;
    end;
end;

procedure otrasPiezas (TABLERO: TM;var DEFIENDE,AMENAZA: TV, fila,columna: byte);
var
    i,j,N,M: byte;
begin
    // Asumo que existe al menos una torre negra

    // Inicializar variables
    N:=0;
    M:=0;
    i:= fila;
    j:= columna;

    // Recorrer columna superior
    while (i<=8) and (TABLERO[i,j].color=0) do
        i:=i+1;
    
    case TABLERO[i,j].color of
        1:
            
end;