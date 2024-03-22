{Reescribir ejercicio 6 usando archivo de texto para ingreso de datos.
Considerar en la primera línea del archivo el saldo inicial y en cada una de las líneas siguientes
un movimiento: Tipo, Monto (notar que no es necesario el tipo F}

Program ejercicio11a;
    var
        // Variables de entrada
            codigo: char;
            monto,saldo:real;
            montoStr:string;
        
        // Archivo de texto
            archivo:text;
        
        // Variable de control
            i:byte;
        
        // Variables de salida
            contador:byte;
    
    begin
        // Archivo txt
            assign(archivo,'saldo.txt');
            reset(archivo);

        // Inicializar variables
            contador:=0;
            i:=1;

        // Lectura de archivo
            while not eof(archivo) do
                begin
                    // ¿Es la primera línea?
                        if i=1 then
                          read(archivo,saldo) {Leer del arhivo el saldo}
                        else
                            begin
                                readLn(archivo, codigo, montoStr); // Leer el código y el monto como string
                                Val(montoStr, monto); // Convertir el monto de string a real
                                if codigo='D' then
                                    saldo:=saldo+monto
                                else
                                    if monto>saldo then
                                        contador:=contador+1
                                    else
                                        saldo:=saldo-monto;
                            end;
                    
                    // Actualizar variables
                        i:=i+1;
                end;

        // Salida de datos
            writeLn('Su saldo es de $',saldo:8:2);
            writeLn('No pudiste retirar dinero por insuficiencia de fondos ',contador,' veces');
        
        // Cerrar archivo
            close(archivo);
    end.