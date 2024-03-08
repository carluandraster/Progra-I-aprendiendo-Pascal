program ejercicio1a;

var
  N,pintura_negra:real;

const
  conversion=95/45;

begin
  // Preguntar litros de pintura blanca (entrada)
     writeLn('Ingrese los litros que tenga de pintura blanca');
     readLn(N);

  // Calcular litros de pintura negra (procesamiento)
     pintura_negra:=N*conversion;

  // Mostrar en pantalla los litros de pintura negra (salida)
     writeLn('Usted necesita ',pintura_negra:4:2,' litros de pintura negra para conseguir el color gris mara.');
end.

