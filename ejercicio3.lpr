program ejercicio3;

var
  x:byte;
  sueldo_bruto:integer;
  sueldo_neto:real;

const
  sueldo_por_hora=200;

begin
  // Preguntar horas trabajadas (entrada)
     writeLn('¿Cuántas horas trabajaste?');
     readLn(x);

  // Proceso

     // Calcular sueldo bruto (sin descuentos)
        sueldo_bruto:=sueldo_por_hora*x;

     // Calcular sueldo neto
        sueldo_neto:=sueldo_bruto*0.84;

  // Comunicar sueldo bruto y neto (salida)
     writeLn('Tu sueldo bruto es de $',sueldo_bruto);
     writeLn('Tu sueldo neto es de $', sueldo_neto:4:0);
end.

