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
begin
    // Abrir archivos
    rewrite(USUARIOS);
    assign(archivo,'./txt/USUARIOS.txt');
    reset(archivo);

    // Copiar contenido de un archivo a otro
    
end;