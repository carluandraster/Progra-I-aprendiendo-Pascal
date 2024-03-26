{ Leer desde un archivo números enteros, calcular y escribir el promedio de los elementos positivos y
distintos de cero que se encuentran entre dos negativos no consecutivos. }

Program ejercicio20;

var
    num:integer;
    archivo:text;
    acumulador:word;
    contador,i:byte;
    promedio:real;

begin
    // Inicializar variables
        acumulador:=0;
        contador:=0;
        i:=1;
    
    // Archivo de texto
        assign(archivo,'numeros.txt');
        reset(archivo);

    // Leer archivo
        while not eof(archivo) do
            begin
              read(archivo,num);
              if num>0 then
                begin
                  acumulador:=acumulador+num;
                  contador:=contador+1;
                end
              else
                if num<0 then
                    begin
                      if (i<>1) and (acumulador<>0) then
                        begin
                          promedio:=acumulador/contador;
                          writeLn(promedio:8:2);
                        end;
                      i:=i+1;
                      acumulador:=0;
                      contador:=0;
                    end;
            end;
end.