{Un estudio contable registró la facturación de varios comercios en los últimos N meses, por cada uno
se tiene:
* Nombre
* Tipo (S/N) si es Responsable Inscripto o No, y luego por cada uno de los N meses:
    - Importe facturado mensual sin IVA
Se desea saber:
a) Listar Nombre, tipo y cuánto pagó de IVA en los N meses.
b) El nombre del comercio Responsable Inscripto que menos facturó en total. }

Program ejercicio7;

{Desarrollar la función Impuesto con los parámetros necesarios de modo tal que devuelva el monto de IVA
que debe pagar. Sabiendo que si es Responsable Inscripto, corresponde el 21% de la compra, si no lo es,
el 21%+10%.}
    function Impuesto(tipo:char;importe:real):real;
        begin
          if tipo='S' then
            Impuesto:=importe*0.21
          else
            Impuesto:=importe*0.31;
        end;

var
    nombre,nombreMin:string;
    tipo:char;
    facturacion,facturacionTotal,minFacturacion:real;
    i,N:byte;

begin
    // Inicializar variables
        minFacturacion:=99999999999999999;
        facturacionTotal:=0;
    
    // Ingresar N por teclado
        repeat
            write('Ingrese la cantidad de meses en los que lleva registro: ');
            readLn(N);
        until N>0;
    
    // Preguntar por los negocios
        write('Ingrese nombre de negocio: ');
        readLn(nombre);

        repeat
            // Preguntar y validar tipo fiscal
                repeat
                    writeLn('Es responsable inscripto? (S o N)');
                    readLn(tipo);
                    tipo:=upcase(tipo);
                until (tipo='S') or (tipo='N');
            
            // Preguntar por la facturacion en los ultimos N meses
                for i:=1 to N do
                  begin
                    repeat
                      write('Ingrese la recaudacion del mes ',i,': ');
                      readLn(facturacion);
                    until facturacion>0;
                    facturacionTotal:=facturacionTotal+facturacion;
                  end;
            
            // ¿Es el comercio Responsable Inscripto que menos facturó en total?
                if (tipo='S') and (facturacionTotal<minFacturacion) then
                    begin
                      minFacturacion:=facturacionTotal;
                      nombreMin:=nombre;
                    end;
            
            // a) Listar Nombre, tipo y cuánto pagó de IVA en los N meses.
                writeLn(nombre);
                if tipo='S' then
                    writeLn('Responsable inscripto')
                else
                    writeLn('Responsable no inscripto');
                writeLn('En los ultimos ',N,' meses pago $',Impuesto(tipo,facturacionTotal):8:2,' de IVA.');
            
            // Reiniciar variables
                facturacionTotal:=0;
            
            // Preguntar siguiente nombre
                write('Ingrese nombre de negocio: ');
                readLn(nombre);
        until nombre='0'; {La condicion de corte es si el usuario ingresa un 0}
    
    // b) El nombre del comercio Responsable Inscripto que menos facturó en total.
        if (nombreMin<>'') then
            writeLn('El comercio responsable inscripto que menos facturo es ',nombreMin);
end.