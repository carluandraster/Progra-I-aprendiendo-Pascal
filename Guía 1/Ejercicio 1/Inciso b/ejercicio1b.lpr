program ejercicio1b;

var
  M,pintura_blanca:real;

const
  conversion=45/95;

begin
  // Preguntar litros de pintura negra (entrada)
     writeLn('Ingrese los litros que tenga de pintura negra');
     readLn(M);

  // Calcular litros de pintura blanca (procesamiento)
     pintura_blanca:=M*conversion;

  // Mostrar en pantalla los litros de pintura blanca (salida)
     writeLn('Usted necesita ',pintura_blanca:4:2,' litros de pintura blanca para conseguir el color gris mara.');
end.

