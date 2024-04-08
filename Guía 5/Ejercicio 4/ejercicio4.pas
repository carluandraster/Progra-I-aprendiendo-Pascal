{Se pide compactar un arreglo (eliminar los ceros que contiene) generando otro arreglo.}

Program ejercicio4;

type
    TV=array [1..255] of byte;

var
    A,B:TV;
    i,N,j:byte;
    num:integer;

begin
    // Inicializar variables
    j:=0;
    i:=0;

    // Ingresar por teclado el arreglo A
    repeat
        i:=i+1;
        repeat
            writeLn('Ingrese un numero (-1 para cortar)');
            readLn(num);
        until (num>=-1) and (num<256);
        
        if num>=0 then
            A[i]:=num;
    until num<0;

    N:=i-1;

    // Compactar arreglo
    for i:=1 to N do
        if A[i]<>0 then
        begin
            j:=j+1;
            B[j]:=A[i];
        end;
    
    // Mostrar arreglo compactado
    writeLn('El arreglo compactado es: ');
    for i:=1 to j do
        writeLn(B[i]);
end.