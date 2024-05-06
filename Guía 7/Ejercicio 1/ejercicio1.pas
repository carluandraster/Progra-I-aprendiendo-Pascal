{El departamento de Recursos Humanos de una empresa desea que sus empleados fraternicen y
decidió cada 3 meses hacer un brindis por los que nacieron en esa estación del año. Se pide:
 Leer los datos (Nombre del empleado y Fecha de Nacimiento)
 Informar en qué estación del año se festejan más cumpleaños. }

Program ejercicio1;

const
    tope = 100;

type
    str16 = string[16];
    str9 = string[9];

    TregF = record
        dia,mes: byte;
        anio: word;
    end;

    TR = record
        nombre: str16;
        fecha: TregF;
    end;

    TV = array [1..tope] of TR;

    TV4 = array [1..4] of byte;


// Subprogramas

// Leer los datos (Nombre del empleado y Fecha de Nacimiento)
procedure leerArchivo (var empleados: TV; var N: byte);
var
    archivo: text;
begin
    // Inicializar variables
    N:=0;

    // Abrir archivo de texto
    assign(archivo,'cumpleaños.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        with empleados[N] do
            readLn(archivo,nombre,fecha.dia,fecha.mes,fecha.anio);
    end;

    // Cerrar archivo
    close(archivo);
end;

// Informar en qué estación del año se festejan más cumpleaños.

function estacion (fecha: TregF):char;
begin
    with fecha do
        case mes of
            1,2: estacion:='V';
            3:
                case dia of
                    1..20: estacion:='V';
                    else: estacion:='O';
                end;
            4,5: estacion:='O';
            6:
                case dia of
                    1..20: estacion:='O';
                    else: estacion:='I';
                end;
            7,8: estacion:='I';
            9:
                case dia of
                    1..20: estacion:='I';
                    else: estacion:='P';
                end;
            10,11: estacion:='P';
            12:
                case dia of
                    1..20: estacion:='P';
                    else: 'V';
                end;
        end;
end;

procedure InicializarArreglo (var CONTADOR: TV4);
var
    i:byte;
begin
    for i:=1 to 4 do
        CONTADOR[i]:=0;
end;

procedure contar (empleados: TV; N: byte; var CONTADOR: TV4);
var
    i: byte;
begin
    // Inicializar variables
    InicializarArreglo(CONTADOR);

    // Recorrer personal
    for i:=1 to N do
        case estacion(empleados[i].fecha) of
            'V': CONTADOR[1]:=CONTADOR[1]+1;
            'O': CONTADOR[2]:=CONTADOR[2]+1;
            'I': CONTADOR[3]:=CONTADOR[3]+1;
            'P': CONTADOR[4]:=CONTADOR[4]+1;
        end;
end;

function maximo (empleados: TV; N: byte):str9;
var
    i,max: byte;
    CONTADOR: TV4;
begin
    contar (empleados, N, CONTADOR);
end;