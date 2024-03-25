{Leer desde archivo un conjunto de números, con elementos negativos no consecutivos que
delimitan subconjuntos. Obtener e informar el valor máximo de cada subconjunto (el máximo
entre dos negativos). }

Program ejercicio19;

var
    max,num:integer;
    archivo:text;
    mostrarMaximo:boolean;

begin
    // Inicializar variables
        mostrarMaximo:=false;

    // Archivo txt
        assign(archivo,'numeros.txt');
        reset(archivo);
    
    // Leer archivo
        while not eof(archivo) do
            begin
                max:=-1;
                num:=0;
                
                read(archivo,num);
                if num<0 then
                    mostrarMaximo:=true;
                
                while num>=0 do
                    begin
                      read(archivo,num);
                      if num>max then
                        max:=num;
                    end;

                if not eof(archivo)
                    writeLn(max);
            end;
end.