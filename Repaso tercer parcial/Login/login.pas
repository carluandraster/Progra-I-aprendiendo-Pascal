{En un archivo llamado USUARIOS.DAT se tiene los siguientes datos:
# NOMBRE DE USUARIO (campo de secuencia, clave primaria, cadena de 15 caracteres)
# CONTRASENIA
Por otro lado, se tiene otro archivo llamado LOGIN.DAT con los siguientes datos:
# FECHA (campo de secuencia, clave secundarias)
# NOMBRE DE USUARIO (campo de secuencia, clave secundaria)
# CONTRASENIA
# ACCION (caracter). Puede ser I de Iniciar sesion, R de Registrarse o C de Cerrar sesion
Se pide:
a) Listar los inicios de sesion fallidos (es decir, aquellos inicios de sesion en la que
no se haya encontrado el nombre de usuario o la contrasenia sea incorrecta) en un archivo
RECHAZADOS.DAT.
b) Actualizar la base de datos USUARIOS.DAT.
c) Elaborar el siguiente listado
  Fecha     Usuarios nuevos Inicios de sesion* Cierres de sesion
XX XX XXXX        999               999              999
...
Usuarios nuevos en total: 9999
* Inicios de sesion exitososs
d) Informar en que dia hubo mas usuarios que se registraron
Verificar los archivos binarios con archivos de texto.}

Program login;

type
    str15 = string[15];
    TRfecha = record
        dia,mes: byte;
        anio: word;
    end;
    TRusuarios = record
        username: str15;
        contrasenia: string;
    end;
    TAusuarios = file of TRusuarios;
    TRlog = record
        fecha: TRfecha;
        username: str15;
        contrasenia: string;
        accion: char;
    end;
    TAlog = file of TRlog;

// Subprogramas

procedure cargarUsuarios (var USUARIOS: TAusuarios);
var
    archivo: text;
    registro: TRusuarios;
begin
    // Abrir archivos
    rewrite(USUARIOS);
    assign(archivo,'./txt/USUARIOS.txt');
    reset(archivo);

    // Copiar contenido de un archivo a otro
    with registro do
        begin
            read(archivo,username);
            while username<>'zzzzzzzzzzzzzzz' do
                begin
                    read(archivo,contrasenia);
                    write(USUARIOS,registro);
                    readLn(archivo);
                    read(archivo,username);
                end;
        end;
    write(USUARIOS,registro); // Guardar el centinela

    // Cerrar archivos
    close(archivo);
    close(USUARIOS);
end;

procedure cargarLogs (var LOGIN: TAlog);
var
    archivo: text;
    registro: TRlog;
    fecha: TRfecha;
    blanco,caracter: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/LOGS.txt');
    reset(archivo);
    rewrite(LOGIN);

    // Copiar contenido de un archivo a otro
    with registro do
        with fecha do
            begin
                read(archivo,anio);
                while anio<>9999 do
                    begin
                        read(archivo,mes,dia,blanco,username);
                        contrasenia:='';
                        read(archivo,caracter);
                        while caracter<>' ' do
                            begin
                                contrasenia:=contrasenia+caracter;
                                read(archivo,caracter);
                            end;
                        read(archivo,accion);
                        readLn(archivo);
                        write(LOGIN,registro);
                        read(archivo,anio);
                    end;
            end;
    write(archivo,registro); // Guardar el centinela
    
    // Cerrar archivos
    close(archivo);
    close(LOGIN);
end;

procedure corte (var USUARIOS: TAusuarios; var LOGIN,RECHAZADOS: TAlog);
var
    TEMP: TAusuarios;
    usuario, regAux: TRusuarios;
    log: TRlog;
    VC: TRfecha;
    contaUsuarios,contaInicios,contaCierres: byte;
    totalUsuarios: word;
begin
    // Abrir archivos
    assign(TEMP,'./dat/TEMP.DAT');
    rewrite(USUARIOS);
    rewrite(TEMP);
    rewrite(LOGIN);
    rewrite(RECHAZADOS);

    totalUsuarios:=0;

    // Leer archivos y resolver lo pedido
    writeLn('  Fecha     Usuarios nuevos Inicios de sesion  Cierres de sesion');
    read(USUARIOS,usuario);
    read(LOGIN,log);
    VC:=log.fecha;
    
    while not eof(LOGS) do
        begin
            // Inicializar variables
            contaUsuarios:=0;
            contaInicios:=0;
            contaCierres:=0;

            while VC=log.fecha do
                if usuario.username<log.username then
                    begin
                        write(TEMP,usuario);
                        read(USUARIOS,usuario);
                    end
                else
                    begin
                        if usuario.username>log.username then {El usuario no esta en la BBDD}
                            if (log.accion = 'I') or (log.accion = 'C') then
                                write(RECHAZADOS,log)
                            else
                                begin
                                    with regAux do
                                        begin
                                            username:=log.username;
                                            contrasenia:=log.contrasenia;
                                        end;
                                    write(TEMP,regAux);
                                    contaUsuarios:=contaUsuarios+1;
                                end;
                            end;
                        else
                            begin
                                if log.accion = 'R' then
                                    write(RECHAZADOS,log)
                                else
                                    if log.accion = 'I' then
                                        contaInicios:=contaInicios+1
                                    else
                                        contaCierres:=contaCierres+1;
                        end;
                        read(LOGIN,log);
                    end;
                    
        with fecha do
            writeLn(dia,' ',mes,' ',anio,' ',contaUsuarios,' ',contaInicios,' ',contaCierres);
        totalUsuarios:=totalUsuarios+contaUsuarios;
        end;
end;