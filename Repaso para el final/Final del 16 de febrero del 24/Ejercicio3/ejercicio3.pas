Program ejercicio3;

var
    N: byte;
begin
    ReadLn(N); // La sentencia repeat until se ejecuta al menos una vez. En cambio, una sentencia dentro de un while puede no ejecutarse nunca
    while (N>=0) and (10>N) or (N mod 3 <> 0) do // Por Ley de De Morgan
        ReadLn(N);
end.