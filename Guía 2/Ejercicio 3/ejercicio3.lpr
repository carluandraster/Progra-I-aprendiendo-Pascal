// Dado el siguiente fragmento de código reescribirlo en forma indentada eliminando redundancias y agregando carteles aclaratorios

{Readln(temp);
 If temp<0 then writeln(‘No salgo de casa….’)
 Else if (temp>=0)and(temp<20) then writeln(‘Hace frio’)
 Else if (temp>=20)and(temp<25)and(temp<29) then writeln(‘Barbaro’)
 Else if(temp>=29) then writeln(´Qué calor!!’);}

program ejercicio3;

var
   temp:real;
begin
   If temp<0 then writeln('No salgo de casa….')
   Else
     if temp<20 then  // Aca no hace falta aclarar que temp>=0 porque sino habria ejecutado la otra secuencia
        writeln('Hace frio')
     Else
       if temp<25 then // Aca tampoco hace falta aclarar que temp>=20 por la misma razón y tampoco hace falta aclarar que temp<29 porque si temp<25 entonces temp<29 porque 25<29
          writeln('Barbaro')
       Else
         if temp<29 then // Aca habría un bache vacio si en el anterior if sacamos temp<29
            writeln('Qué calor!!')
         else
            // Si entre 25 y 29 grados hace calor, imagináte si hiciera más de 29 grados
            writeln('¡¡¡QUÉ CALOOOOOORRR!!!');
end.

