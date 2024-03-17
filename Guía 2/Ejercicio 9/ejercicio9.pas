{A un vendedor le pagan un sueldo básico de $8000 por mes más una comisión del 5% de las ventas;
si superó en ventas un monto X (dato ingresado por teclado) se le agrega un 3%. Por presentismo cobra
$1000 más ó 2% de las ventas, lo que resulte mayor. Si faltó más de 2 días se le descuenta un 7% del
total.
Definir los datos a ingresar. Calcular e informar lo que debe cobrar el vendedor. }

Program ejercicio9;

const
    sueldoBasico=8000;

var
    // Variables de entrada
        ventas,X:real;
        faltas:byte;

    // Variables de proceso
        comision,extra,descuentoTotal:real;

    // Variables de salida
        sueldoNeto:real;

begin
    // Preguntar por el monto X
        writeln('A partir de que monto se otorga el beneficio?');
        readLn(X);

    // Preguntar por las ventas
        writeln('Ingrese el monto obtenido en ventas');
        readLn(ventas);

    // Preguntar por las faltas
        writeln('Ingrese cantidad de faltas');
        readLn(faltas);

    // Inicializar variables
        comision:=0.05;
        extra:=0;
        descuentoTotal:=1;

    // si superó en ventas un monto X se le agrega un 3%
        if ventas>X then
            comision:=comision+0.03;

    // Por presentismo cobra $1000 más ó 2% de las ventas, lo que resulte mayor
        if faltas=0 then
            if 2/100*ventas>1000 then
                comision:=comision+0.02
            else
                extra:=1000
        else
            // Si faltó más de 2 días se le descuenta un 7% del total
            if faltas>2 then
                descuentoTotal:=0.93;

    // Informar lo que debe cobrar el vendedor
        sueldoNeto:=descuentoTotal*(sueldoBasico+ventas*comision+extra);

        writeln('El vendedor debe cobrar $',sueldoNeto:8:2);
end.