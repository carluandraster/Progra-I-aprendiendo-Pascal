//  Informar si un caracter ingresado es letra minúscula, mayúscula u otro cualquiera.
program ejercicio1;
var
  caracter:char;
begin
  // Entrada
     writeLn('Ingrese un caracter');
     readLn(caracter);

  // Condicional
     If (caracter>='A') and (caracter<='Z') then // ¿Es el caracter una letra mayúscula?
        writeLn('El caracter ingresado es una letra mayuscula')
     Else
       if (caracter>='a') and (caracter<='z') then // ¿Es el caracter una letra minúscula?
          writeLn('El caracter ingresado es una letra minuscula')
       else
          writeLn('El caracter ingresado no es una letra');
end.

