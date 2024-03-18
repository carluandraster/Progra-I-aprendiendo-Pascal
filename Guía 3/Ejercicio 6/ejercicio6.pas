{Se conoce el saldo inicial de una cuenta bancaria y una serie de movimientos realizados,
por cada uno:
 - código de movimiento (D=depósito, R=retiro ó F= fin de datos).
 - monto
Escribir un programa que ingrese dichos datos y determine el saldo exacto de la cuenta
después de procesar las transacciones. Al final del proceso indique cuantas veces no pudo
retirar dinero por insuficiencia de fondos.}

Program ejercicio6;
    var
        // Variables de entrada
            codigo: char;
            monto,saldo:real;
        
        // Variables de salida
            contador:byte;
    
    begin
        // Inicializar variables
            contador:=0;
        
        // Preguntar y validar saldo
            repeat
              writeLn('Ingrese saldo');
              readLn(saldo);
            until saldo>=0;

        // Ciclo repetir hasta que
            repeat
                // Preguntar y validar codigo de movimiento
                    repeat
                  	    writeLn('Ingrese un codigo de movimiento (D=deposito, R=retiro, F= fin de datos)');
                        readLn(codigo);
                        codigo:=upcase(codigo);
                    until (codigo='D') or (codigo='R') or (codigo='F');
            
                // Es un deposito?
                    if codigo='D' then
                      begin
                        // Validar monto
                            repeat
                                writeLn('Ingrese el monto que quiera depositar');
                                readLn(monto);
                            until monto>0;

                        // Sumarle al saldo el monto
                            saldo:=saldo+monto;
                      end
                    else
                        if codigo='R' then {Es un retiro?}
                            begin
                            // Validar monto
                                repeat
                                    writeLn('Ingrese el monto que quiera retirar');
                                    readLn(monto);
                                until monto>0;

                            // Si es posible, restarle al saldo el monto
                                if monto<=saldo then
                                    saldo:=saldo-monto
                                else
                                    begin
                                        writeLn('Saldo insuficiente. Tu saldo es de apenas $',saldo:8:2);
                                        contador:=contador+1;
                                    end;
                            end;
            until codigo='F';

            // Salida de datos
                writeLn('Su saldo es de $',saldo:8:2);
                writeLn('No pudiste retirar dinero por insuficiencia de fondos ',contador,' veces');
    end.