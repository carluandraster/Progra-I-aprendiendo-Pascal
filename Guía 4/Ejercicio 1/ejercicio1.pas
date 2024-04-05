{Desarrollar una función booleana que dado un caracter diga si es letra o no}

Program ejercicio1;

function esLetra (caracter:char):boolean;
    begin
      esLetra:=(caracter in ['A'..'Z']) or (caracter in ['a'..'z']);
    end;

var
    caracter:char;

begin
    // Ingresar caracter por teclado
        writeLn('Ingrese un caracter: ');
        read(caracter);
    
    // Comunicar si el caracter es una letra o no
        if esLetra(caracter) then
            writeLn('El caracter ingresado es una letra.')
        else
            writeLn('El caracter ingresado no es una letra.');
end.