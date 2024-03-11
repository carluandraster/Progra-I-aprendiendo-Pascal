// Dadas dos fechas (dia, mes y año) indicar cuál es la más antigua y a qué trimestre pertenece

program ejercicio4;

var
  // Información sobre día 1
     dia1,mes1:byte;
     anio1:word;

  // Información sobre día 2
     dia2,mes2:byte;
     anio2:word;

begin
  // Entrada fecha 1
     writeLn('Ingrese una fecha');
     readLn(dia1,mes1,anio1);

  // Entrada fecha 2
     writeLn('Ingrese otra fecha');
     readLn(dia2,mes2,anio2);

  // Calcular qué fecha es más antigua
     if(anio1<>anio2) then
         if(anio1>anio2) then
             writeLn('La fecha mas antigua es ',dia2,'/',mes2,'/',anio2)
         else
             writeLn('La fecha mas antigua es ',dia1,'/',mes1,'/',anio1)
end.

