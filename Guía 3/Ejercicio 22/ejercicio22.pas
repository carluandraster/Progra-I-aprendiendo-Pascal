{A partir de un archivo de texto que contiene palabras separadas entre sí por uno o más blancos
desarrollar un programa para:
a) Mostrar la palabra con más cantidad de vocales del texto.
b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
c) Contar cuántas son palíndromas (capicúas)}

Program ejercicio22;

var
    // Contadores
        contaVocales,contaCapicuas:byte;
    
    // Variables de control
        i:byte;
        hacerAlgo:boolean;

    // Maximos
        maxVocales:byte;

    // Archivos de texto
        archivoEntrada,archivoSalida:text;

    // Palabras y caracteres
        palabra,palabraMax,palabraInvertida:string;
        caracter:char;

begin
    // Inicializar variables
        contaCapicuas:=0;
        contaVocales:=0;
        maxVocales:=0;
        palabra:='';
        palabraInvertida:='';
        hacerAlgo:=true;
    
    // Archivos de texto
        assign(archivoEntrada,'texto_entrada.txt');
        assign(archivoSalida,'texto_salida.txt');
        reset(archivoEntrada);
        rewrite(archivoSalida);
    
    // Leer archivo de entrada
        while not eof(archivoEntrada) do
            begin
                read(archivoEntrada,caracter);
                if (caracter=' ') then
                 
                    if hacerAlgo then
                     begin
                        // ¿Es la palabra con más cantidad de vocales del texto? (inciso a)
                        if contaVocales>maxVocales then
                            begin
                                maxVocales:=contaVocales;
                                palabraMax:=palabra;
                            end;
                        
                        // Obtener la palabra invertida
                            for i:=length(palabra) downto 1 do
                                palabraInvertida:=palabraInvertida+palabra[i];

                        // b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
                        if length(palabra)>4 then
                            write(archivoSalida,palabraInvertida,' ');
                        
                        // Si la palabra es capicúa, contarla (inciso c)
                            if palabra=palabraInvertida then
                                contaCapicuas:=contaCapicuas+1;      
                        
                        // En caso de que el próximo caracter sea otro blanco, no hacemos nada
                            hacerAlgo:=false;
                        
                        // Reiniciar variables
                            contaVocales:=0;
                            palabra:='';
                            palabraInvertida:='';
                    end
                  else
                    begin
                      // No hacer nada
                            contaVocales:=0;
                            palabra:='';
                            palabraInvertida:='';
                    end
                else
                    begin
                      hacerAlgo:=true;
                      palabra:=palabra+caracter;
                      caracter:=upcase(caracter);
                      if (caracter='A') or (caracter='E') or (caracter='I') or (caracter='O') or (caracter='U') then
                        contaVocales:=contaVocales+1;
                    end;
            end;
    
    // Procesar ultima palabra
        if hacerAlgo then
                    
                    // ¿Es la palabra con más cantidad de vocales del texto? (inciso a)
                      if contaVocales>maxVocales then
                        begin
                          maxVocales:=contaVocales;
                          palabraMax:=palabra;
                        end;
                    
                    // Obtener la palabra invertida
                        for i:=length(palabra) downto 1 do
                            palabraInvertida:=palabraInvertida+palabra[i];

                    // b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
                      if length(palabra)>4 then
                          write(archivoSalida,palabraInvertida,' ');
                    
                    // Si la palabra es capicúa, contarla (inciso c)
                        if palabra=palabraInvertida then
                            contaCapicuas:=contaCapicuas+1;
    
    // Cerrar archivos
        close(archivoEntrada);
        close(archivoSalida);
    
    // Salida de datos
        // a) Mostrar la palabra con más cantidad de vocales del texto.
            writeLn('La palabra con mas cantidad de vocales del texto es ',palabraMax);

        // c) Mostrar cuántas son palíndromas (capicúas)
            writeLn(contaCapicuas,' palabras son capicuas.');
end.