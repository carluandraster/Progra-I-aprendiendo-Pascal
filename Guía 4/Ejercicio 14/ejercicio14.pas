{Modificar el código del ejemplo 8, dado en la teoría, para que el procedimiento Evalua(), devuelva
además, la cantidad de palabras más largas y el programa muestre además, dicho resultado.
Considerar que cada palabra finaliza con punto y vienen en líneas diferentes }

Program ejercicio14;

Type
    St20=string[20];

// Procedimientos y funciones
procedure Evalua(var Todas: string; var Max, contador: byte);
    var
        Arch: Text;
        Car: char;
        Pal: string;
        i: byte;
    begin
        Assign(Arch, 'texto.txt');
        Reset(Arch);
        Max := 0;
        Todas := '';
        Pal := '';

    while not eof(Arch) do
    begin
        Read(Arch, Car);

        // Verificar si es un carácter válido para formar palabras
        if Car in ['A'..'Z', 'a'..'z'] then
        begin
            // Comienza una nueva palabra
            Pal := Car;
            i := 1;

            // Leer los siguientes caracteres hasta encontrar un espacio o punto
            repeat
                Read(Arch, Car);
                if Car in ['A'..'Z', 'a'..'z'] then
                begin
                Pal := Pal + Car;
                i := i + 1;
                end;
            until (Car = '.') or (Car = ' ');

            // Evaluar la longitud de la palabra
            if i > Max then
            begin
                Todas := Pal;
                Max := i;
                contador := 1;
            end
            else if i = Max then
            begin
                Todas := Todas + ' ' + Pal;
                contador := contador + 1;
            end;
        end;
  end;

  Close(Arch);
end;


// Programa principal
Var
    Todas: string;
    Max,contador : byte;

Begin
    Evalua(Todas, max,contador);
    Writeln ('estas son las ',contador,' palabras mas largas') ;
    writeln (Todas);
    Writeln ('Tienen ', Max, ' caracteres') ;
    Readln;
end. 
