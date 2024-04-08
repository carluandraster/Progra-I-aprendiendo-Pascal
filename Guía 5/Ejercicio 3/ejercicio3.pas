{Dado un arreglo V y un número K, cambiar todas las ocurrencias de K por 0. }

Program ejercicio3;

type
    TV=array[1..255] of byte;

var
    V:TV;
    K,i,j:byte;
    num:integer;

begin
    // Inicializar variables
    i:=0;

    // Ingreso de datos

    writeLn('Ingrese un numero');
    readLn(K);

    repeat
        i:=i+1;
        repeat
            writeLn('Ingrese un numero (-1 para cortar)');
            readLn(num);
        until (num>=-1) and (num<256);
        
        if num>=0 then
            V[i]:=num;
    until num<0;

    // Cambiar K por 0
    for j:=1 to i-1 do
      if V[j]=K then
        V[j]:=0;
    
    // Imprimir V
    for j:=1 to i-1 do
        writeLn(V[j]);
end.