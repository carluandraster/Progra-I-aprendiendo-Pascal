{Dados N números enteros, calcular e informar:
a) El máximo, qué lugar ocupa la primera aparición y cuántas ocurrencias tiene.
b) El mínimo de los impares (informar si no existe)}

Program ejercicio1;

var
    // Variables de entrada
        N:byte;
        num:integer;
    
    // Variable de control
        i:byte;

    // Inciso a
        maximo:integer;
        lugar,ocurrencias:byte;
    
    // Inciso b
        minimo:integer;

begin
    // Inicializar variables
        maximo:=-32768;
        minimo:=32767;

    // Preguntar por N
        writeLn('¿Cuantos numeros enteros va a ingresar?');
        readLn(N);
    
    // Ciclo for
        for i:=1 to N do
          begin
            // Preguntar número entero
                writeLn('Ingrese un numero entero');
                readLn(num);
            
            // ¿Es el número máximo?
                if num>maximo then
                    begin
                      maximo:=num;
                      lugar:=i;
                      ocurrencias:=1;
                    end
                else
                    if num=maximo then
                        ocurrencias:=ocurrencias+1;
            
            // ¿Es el mínimo de los impares?
                if (num<minimo) and odd(num) then
                    minimo:=num;
          end;
    
    // Salida de datos
        // Inciso a
            writeLn('El numero maximo fue ',maximo,', aparecio por primera vez en el lugar ',lugar,' y aparecio ',ocurrencias,' veces');
        
        // Inciso b
            if minimo=32767 then
                writeLn('El numero minimo de los impares no existe porque solo se ingresaron numeros pares')
            else
                writeLn('El numero minimo de los impares es ',minimo);
end.