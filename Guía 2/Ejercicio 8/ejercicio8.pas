{Un club cobra a sus socios una cuota básica por mes que incluye dos deportes, su costo depende de
la edad del socio:
 Si es mayor de 18: $1800
 Si está entre 13 y 18: $1200
 Si tiene entre 5 y 12 años: $750
 En otro caso no paga 
Además, se cobra $250 por cada deporte adicional que realiza, excepto pileta escuela que cuesta $800. Si
la cuota se abona después del día 15 tiene un recargo del 5%.
Determinar los datos a ingresar, para calcular e informar cuánto paga un socio. }

Program ejercicio8;

const
    // Extras
        extra=250;
        extraPiletaEscuela=800;

    // Precios base por edad
        mayorde18=1800;
        entre13y18=1200;
        entre5y12=750;
var
    // Variables de entrada
        edad,cantidadDeDeportes,diaDelMes:byte;

        // Respuesta a la pregunta de si hace pileta escuela
        respuesta:char;

    // Tarifa que se deberá abonar
    precio:real;

begin
    // Preguntar la edad
        writeLn('Ingrese su edad');
        readLn(edad);

    // Determinar el precio en función de la edad
        if edad>12 then {mayores de 12}
            if edad>18 then {Mayor de 18}
                precio:=mayorde18
            else {Entre 13 y 18}
                precio:=entre13y18
        else {menores de 12}
            if edad>=5 then {entre 5 y 12}  
                precio:=entre5y12
            else {menores de 5}
                precio:=0;  

    // Preguntar la cantidad de deportes que hará
        writeLn('Cuantos deportes hace?');
        readLn(cantidadDeDeportes);

    // Si la cantidad de deportes supera 2, cobrar un extra
        if cantidadDeDeportes>2 then
            Begin
                // Preguntar si hace pileta escuela
                    writeLn('Usted hace pileta escuela? (S o N)');
                    readLn(respuesta);
                    respuesta:=upcase(respuesta);

                if respuesta='S' then
                    precio:=precio+extra*(cantidadDeDeportes-3)+extraPiletaEscuela
                else
                    precio:=precio+extra*(cantidadDeDeportes-2)
            End;

    // Preguntar fecha de pago
        writeLn('Ingrese dia del mes en el que se realiza el pago');
        readLn(diaDelMes);

        // Si la cuota se abona después del día 15 tiene un recargo del 5%
        if diaDelMes>15 then
            precio:=precio*1.05;

    // Salida: comunicar la tarifa
        writeLn('El precio a abonar es de $',precio:8:2);
end.