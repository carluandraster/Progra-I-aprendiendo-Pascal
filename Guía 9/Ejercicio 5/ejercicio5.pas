{Dado un archivo ALUMNOS.DAT con las notas de alumnos cuyo diseño de registro es:
# MATRICULA (campo de secuencia, clave primaria)
# NOTA en MATEMÁTICA (0..10)
# NOTA en FISICA I (0..10)
# NOTA en QUIMICA I (0..10)
y un archivo de inscriptos (INSCRIPTOS.DAT) en QUIMICA II y FISICA II cuyo diseño de
registro es:
# MATRICULA (campo de secuencia, clave primaria)
# QUIMICA II (1=inscripto, 0=no inscripto)
# FISICA II (1=inscripto, 0=no inscripto)
Obtener un listado con la matrícula de aquellos alumnos inscriptos que no cumplan con
los requisitos de equivalencia exigidos, que son: para FISICA II, tener aprobados
MATEMATICA y FISICA I, y para QUIMICA II, tener aprobado QUIMICA I. 
(se aprueba con NOTA >=4) }

Program ejercicio5;

type
    str6 = string[6];
    TRalumnos = record
        matricula: str6;
        notaMat,notaFis,notaQui: byte;
    end;
    TAalumnos = file of TRalumnos;
    TRinscriptos = record
        matricula: str6;
        quimica2,fisica2: byte;
    end;
    TAinscriptos = file of TRinscriptos;

// Subprogramas

// Cargar archivos tipados

procedure cargarAlumnos (var ALUMNOS: TAalumnos);
var
    archivo: text;
    registro: TRalumnos;
begin
    // Abrir archivos
    assign(archivo,'./txt/alumnos.txt');
    reset(archivo);
    rewrite(ALUMNOS);

    // Pasar datos
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,matricula,notaMat,notaFis,notaQui);
            write(ALUMNOS,registro);
        end;
    
    // Cerrar archivo
    close(archivo);
    close(ALUMNOS);
end;

procedure cargarInscriptos (var INSCRIPTOS: TAinscriptos);
var
    archivo: text;
    registro: TRinscriptos;
begin
    // Abrir archivos
    assign(archivo, './txt/inscriptos.txt');
    reset(archivo);
    rewrite(INSCRIPTOS);

    // Pasar datos
    while not eof(archivo) do
        begin
            with registro do
                readLn(archivo,matricula,quimica2,fisica2);
            write(INSCRIPTOS,registro);
        end;
    
    // Cerrar archivo
    close(archivo);
    close(INSCRIPTOS);
end;

// Programa principal

var
    ALUMNOS: TAalumnos;
    INSCRIPTOS: TAinscriptos;
    registroA: TRalumnos;
    registroI: TRinscriptos;

begin
    // Archivos de texto
    assign(ALUMNOS,'./dat/ALUMNOS.DAT');
    cargarAlumnos(ALUMNOS);
    reset(ALUMNOS);
    assign(INSCRIPTOS,'./dat/INSCRIPTOS.DAT');
    cargarInscriptos(INSCRIPTOS);
    reset(INSCRIPTOS);

    // Elaborar informe
    writeLn('Alumnos inscriptos que no cumplen con los requisitos de equivalencia exigidos: ');
    while not eof(ALUMNOS) do
        begin
            // Leer archivos
            read(ALUMNOS,registroA);
            read(INSCRIPTOS,registroI);

            // Listar si se insribio a una materia que no corresponde
            if ((registroI.quimica2=1) and (registroA.notaQui<4)) or 
                ((registroI.fisica2=1) and ((registroA.notaMat<4) or (registroA.notaFis<4))) then
                    writeLn(registroA.matricula);
        end;
    
    // Cerrar archivos
    close(ALUMNOS);
    close(INSCRIPTOS);
end.