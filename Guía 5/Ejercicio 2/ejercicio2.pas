{Dado un archivo de enteros, se pide almacenar en un vector V sólo los elementos impares y 
en otro vector W, los pares, ignorando si hubiese, los ceros.}

Program ejercicio2;

type
    TV=array [1..255] of integer;

var
    archivo:text;
    V,W:TV;
    numero:integer;
    i,j,k:byte;

begin
    // Inicializar variables
    i:=1;
    j:=1;
    
    // Archivo de texto
    assign(archivo,'enteros.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        readLn(archivo,numero);
        if numero<>0 then
        begin
          if odd(numero) then
            begin
                V[i]:=numero;
                i:=i+1;
            end
            else
            begin
                W[j]:=numero;
                j:=j+1;
            end;
        end;
    end;

    // Cerrar archivo
    close(archivo);

    // Mostrar arreglos

    writeLn('Los numeros impares son: ');
    for k:=1 to i-1 do
        writeLn(V[k]);
    
    writeLn('Los numeros pares son: ');
    for k:=1 to j-1 do
        writeLn(W[k]);
end.