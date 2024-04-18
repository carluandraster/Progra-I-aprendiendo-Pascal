Program banco;

var
    caracter:char;
    nombre,red,maxNombre:string;
    i,num:byte;
    ip:string[15];
    tiempo,maxTiempo,acumulador,cantidad,tiempoPromedio:word; {Supongo que los clientes del banco no superan los 65535. En caso contrario, tendría que declararse como longint}
    archivo:text;

begin
    // Inicializar variables
    acumulador:=0;
    cantidad:=0;
    maxTiempo:=0;

    // Archivo de texto
    assign(archivo,'Bank.txt');
    reset(archivo);

    // Lectura de archivo
    while not eof(archivo) do
    begin
        // Leer nombre
        nombre:='';
        repeat
            read(archivo,caracter);
            if caracter in ['0'..'9'] then
            begin
                val(caracter,num);
                for i:=1 to num do
                begin
                    read(archivo,caracter);
                    nombre:=nombre+caracter;
                end;
            end;
        until caracter=' ';
        
        // Leer dirección IP
        read(archivo,ip);

        // Leer tiempo
        read(archivo,tiempo);

        // De donde es la direccion IP
        red:='';
        for i:=1 to 3 do
            red:=red+ip[i];
        
        case red of
            // c) Usuario con origen en la red interna del banco con mayor tiempo de conexión
            '192':
                if (tiempo>maxTiempo) then
                begin
                    maxTiempo:=tiempo;
                    maxNombre:=nombre;
                end;
            else
                // b) Tiempo promedio de accesos internacionales que se realizaron
                if (red<>'276') and (red<>'381') then
                begin
                    cantidad:=cantidad+1;
                    acumulador:=acumulador+tiempo;
                end;
        end;

        // Salto de página
        readLn(archivo);
    end;

    // Imprimir respuestas
    tiempoPromedio:=round(acumulador/cantidad);
    writeLn('Tiempo promedio en accesos internacionales: ',tiempoPromedio);
    writeLn('El usuario de la red interna del banco con mayor tiempo de conexion es ',maxNombre);
end.