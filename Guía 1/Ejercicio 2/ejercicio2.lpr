program ejercicio2;

var
  k:word;
  an:integer;

begin
  // Preguntar K (entrada)
     writeLn('Ingrese un número K natural');
     readLn(k);

  // Proceso
     // Calcular an
        an:=1+3*(k-1);

  // Salida
     // Mostrar término k-ésimo (inciso a)
        writeLn('El término k-ésimo es ',an);
     // Mostrar diferencia entre los términos k y k+1 (inciso b)
        writeLn('La diferencia con el término que le sigue es de 3');
end.

