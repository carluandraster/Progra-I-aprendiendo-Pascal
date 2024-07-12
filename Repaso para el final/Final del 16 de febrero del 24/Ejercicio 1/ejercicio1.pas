Program ejercicio1;

const
    TOPE = 10;
    CENTINELA = 9999;

type
    // Cadenas de texto
    str3 = string[3];
    str8 = string[8];
    str30 = string[30];

    // EMPLEADOS.DAT
    TRE = record
        legajo: word;
        nombre: str30;
        sueldo: real;
    end;
    TAE = file of TRE;

    // HORAS-TRABAJO.DAT
    TRH = record
        legajo: word;
        fecha: str8;
        horas: real;
        codPozo: str3;
    end;
    TAH = file of TRH;

    // Pozo-Petrolero.dat
    TRP = record
        codPozo: str3;
        descripcion: str30;
        valorHora: real;
    end;
    TAP = file of TRP;

    // Vector pozos petroleros
    TRPA = record
        codPozo: str3;
        descripcion: str30;
        valorHora,horas: real;
    end;
    TV = array [1..TOPE] of TRPA;

// Subprogramas

procedure cargarEmpleados (var EMPLEADOS: TAE);
var
    archivo: text;
    registro: TRE;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/EMPLEADOS.txt');
    reset(archivo);
    rewrite(EMPLEADOS);

    // Copiar contenido
    with registro do
    begin
        read(archivo,legajo);
        while legajo<>CENTINELA do
        begin
            read(archivo,blanco,nombre,sueldo);
            readLn(archivo);
            write(EMPLEADOS,registro);
            read(archivo,legajo);
        end;
    end;
    write(EMPLEADOS,registro);

    // Cerrar archivos
    close(archivo);
    close(EMPLEADOS);    
end;

procedure cargarHorasDeTrabajo (var HORAS: TAH);
var
    archivo: text;
    registro: TRH;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/HORAS-TRABAJO.txt');
    reset(archivo);
    rewrite(HORAS);

    // Copiar archivo
    read(archivo,registro.legajo);
    while registro.legajo<>CENTINELA do
    begin
        read(archivo,blanco,registro.fecha,registro.horas,blanco,registro.codPozo);
        readLn(archivo);
        write(HORAS,registro);
        read(archivo,registro.legajo);
    end;
    write(HORAS,registro);

    // Cerrar archivos
    close(archivo);
    close(HORAS);
end;

procedure cargarPozosPetroleros (var POZO: TAP);
var
    archivo: text;
    registro: TRP;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/Pozo-Petrolero.txt');
    reset(archivo);
    rewrite(POZO);

    // Copiar archivo
    while not eof(archivo) do
    begin
        with registro do
        begin
            readLn(archivo,codPozo,blanco,descripcion,valorHora);
        end;
        write(POZO,registro);    
    end;

    // Cerrar archivos
    close(archivo);
    close(POZO);
end;

procedure leerPozos (var POZO: TAP; var POZOS: TV; var N: byte);
var
    registro: TRP;
begin
    reset(POZO);
    N:=0;
    while not eof(POZO) do
    begin
        N:=N+1;
        read(POZO,registro);
        with POZOS[N] do
        begin
            codPozo:=registro.codPozo;
            descripcion:=registro.descripcion;
            valorHora:=registro.valorHora;
            horas:=0;
        end;
    end;
    close(POZO);
end;

// Dado un codigo de pozo, obtener su indice
function buscar (codPozo: str3; POZOS: TV; N: byte): byte;
begin
    if (N=1) or (POZOS[N].codPozo=codPozo) then
        buscar:=N
    else
        buscar:=buscar(codPozo,POZOS,N-1);
end;

// Dada una fecha, decidir si pertenece a la primera quincena
function primeraQuincena (fecha: str8): boolean;
var
    diaStr: string[2];
begin
    diaStr[1]:=fecha[7];
    diaStr[2]:=fecha[8];
    primeraQuincena:=diaStr<'15';
end;

procedure enfrentamiento (
    var EMPLEADOS: TAE; var HORAS: TAH;
    var POZOS: TV; N: byte;
    var noTrabajaron,errores: byte
);
var
    TEMP: TAE;
    regEmpleados: TRE;
    regHoras: TRH;
    VC: word;
    i: byte;
begin
    // Abrir archivos
    assign(TEMP,'./dat/TEMP.DAT');
    reset(EMPLEADOS);
    reset(HORAS);
    rewrite(TEMP);

    // Inicializar variables
    noTrabajaron:=0;
    errores:=0;
    VC:=CENTINELA;

    // Enfrentar archivos
    read(EMPLEADOS,regEmpleados);
    read(HORAS,regHoras);
    while not eof(EMPLEADOS) or not eof(HORAS) do
        if regEmpleados.legajo<regHoras.legajo then
        begin
            if regEmpleados.sueldo=0 then
                noTrabajaron:=noTrabajaron+1;
            write(TEMP,regEmpleados);
            read(EMPLEADOS,regEmpleados);
        end
        else
            if regEmpleados.legajo>regHoras.legajo then
            begin
                if regHoras.legajo<>VC then
                begin
                    errores:=errores+1;
                    VC:=regHoras.legajo;
                end;
                read(HORAS,regHoras);
            end
            else
            begin
                i:=buscar(regHoras.codPozo,POZOS,N);
                regEmpleados.sueldo:=regEmpleados.sueldo+regHoras.horas*POZOS[i].valorHora;
                if primeraQuincena(regHoras.fecha) then
                begin
                    with POZOS[i] do
                        horas:=horas+regHoras.horas;
                end;
                    
                read(HORAS,regHoras);
            end;
    regEmpleados.legajo:=CENTINELA;
    write(TEMP,regEmpleados);
    
    // Cerrar archivos
    close(EMPLEADOS);
    close(HORAS);
    close(TEMP);

    // Reemplazo de archivos
    erase(EMPLEADOS);
    rename(TEMP,'./dat/EMPLEADOS.DAT');
end;

procedure listado (POZOS: TV; N: byte);
var
    i: byte;
begin
    writeLn('Codigo Pozo     Descripcion             Cant de Horas 1eraQuincena    Monto Total 1eraQuincena');
    for i:=1 to N do
        with POZOS[i] do
            writeLn('    ',codPozo,'          ',descripcion,horas:8:0,'                      $',horas*valorHora:8:2);
end;

procedure mostrar (var EMPLEADOS: TAE);
var
    registro: TRE;
    archivo: text;
begin
    // Abrir archivos
    assign(archivo,'./txt/empleados_actualizados.txt');
    rewrite(archivo);
    reset(EMPLEADOS);

    // Copiar contenido
    read(EMPLEADOS,registro);
    while registro.legajo<>CENTINELA do
    begin
        with registro do
            writeLn(archivo,legajo,' ',nombre,sueldo:4:2);
        read(EMPLEADOS,registro);
    end;
    write(archivo,registro.legajo);

    close(archivo);
    close(EMPLEADOS);
end;

// Programa principal

var
    EMPLEADOS: TAE;
    HORAS: TAH;
    POZO: TAP;
    POZOS: TV;
    N,noTrabajaron,errores: byte;

begin
    // Archivos tipados
    assign(EMPLEADOS,'./dat/EMPLEADOS.dat');
    assign(HORAS,'./dat/HORAS-TRABAJO.dat');
    assign(POZO,'./dat/Pozo-Petrolero.dat');
    
    // Cargar archivos
    cargarEmpleados(EMPLEADOS);
    cargarHorasDeTrabajo(HORAS);
    cargarPozosPetroleros(POZO);

    // Leer archivo
    leerPozos (POZO, POZOS, N);
    
    // Inciso a
    enfrentamiento (EMPLEADOS,HORAS,POZOS,N,noTrabajaron,errores);
    mostrar(EMPLEADOS);

    // Inciso b
    writeLn('Empleados que no trabajaron en el mes: ',noTrabajaron);

    // Inciso c
    writeLn('Cantidad de legajos erroneos: ',errores);

    // Inciso d
    listado(POZOS,N);
end.