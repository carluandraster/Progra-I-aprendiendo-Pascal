{En un archivo de texto se registraron las compras de N titulares de tarjetas de crédito de la siguiente
forma:
- Código de Cliente y a continuación sus compras: no se sabe cuántas son, por cada una:
    • Tipo de compra: (C=combustible, S=supermercado, O=otros, F=fin de datos) 
    • Día (1..31)
    • Monto
El banco ofrece un descuento de:
- 5% los días 10, 20 y 30 para el tipo Otros si el monto supera los $300.
- 10% para Combustible en la 2º quincena.
- 15% para Supermercado en la 1º quincena.
Se pide:
a) Código del cliente y total abonado, por cada cliente que no se benefició con ningún descuento.
b) Cuántos clientes obtuvieron descuento en los tres rubros.
c) Informar cuánto ahorró cada cliente. }

Program ejercicio8;

{En la solución debe desarrollar la función Descuento, que a partir del tipo de compra, día y monto
devuelva el correspondiente descuento. }

Function Descuento(tipo:char;dia:byte;monto:real):   real;
Begin
    If (dia=10) Or (dia=20) Or (dia=30) And (tipo='O') And (monto>300) Then
        Descuento := 0.05
    Else
        If (tipo='C') And (dia>=15) Then
            Descuento := 0.1
    Else
        If (tipo='S') And (dia<15) Then
            Descuento := 0.15
    Else
        Descuento := 0;
End;

Procedure cortar(cadena:string;var tipo:char; var dia:byte; var monto:real);
    var
        i:byte;
        diaStr:string;
    begin
        // Extraer tipo de rubro
            tipo:=cadena[1];
            delete(cadena,1,2);
        
        if tipo<>'F' then
          begin
            // Extraer dia
                i:=1;
                diaStr:='';
                while cadena[i]<>' ' do
                    begin
                        diaStr:=diaStr+cadena[i];
                        i:=i+1;
                    end;
                delete(cadena,1,i);
                val(diaStr,dia);
            // Extraer monto
                val(cadena,monto);
          end;
        
    end;

Var 
    tipo:   char;
    dia:   byte;
    monto,totalAbonado,ahorro,desc:   real;
    archivo:   text;
    descuentoTresRubros,lectura,codigo:   string;
    cuentaClientes:   word;

Begin
    // Archivo de texto
    assign(archivo,'compras.txt');
    reset(archivo);

    // Inicializar variables
    totalAbonado := 0;
    ahorro := 0;
    descuentoTresRubros := '000';
    cuentaClientes := 0;

    // Leer archivo
    While Not eof(archivo) Do
        Begin
            // Leer codigo de cliente
            readLn(archivo,codigo);

            // Leer compras
            readLn(archivo,lectura);
            cortar(lectura,tipo,dia,monto);
            While tipo<>'F' Do
                Begin
                    // Procesar compra
                        totalAbonado := totalAbonado+monto;
                        desc:=Descuento(tipo,dia,monto);
                        ahorro := ahorro+monto*desc;
                        If desc<>0 Then
                            Case tipo Of 
                                'C':   descuentoTresRubros[1] := '1';
                                'S':   descuentoTresRubros[2] := '1';
                                'O':   descuentoTresRubros[3] := '1';
                            End;
                    
                    // Siguiente compra
                        read(archivo,lectura);
                        cortar(lectura,tipo,dia,monto);
                End;

            // a) Código del cliente y total abonado, por cada cliente que no se benefició con ningún descuento.
            If ahorro=0 Then
                Begin
                    writeLn(codigo);
                    writeLn('Total abonado: $',totalAbonado);
                End
            Else
                // Contar si el cliente obtuvo descuentos en todos los rubros
                If descuentoTresRubros='111' Then
                    cuentaClientes := cuentaClientes+1;

            // c) Informar cuánto ahorró cada cliente
            writeLn('Ahorro: $',ahorro);

            // Reiniciar variables para el próximo cliente
            totalAbonado := 0;
            ahorro := 0;
            descuentoTresRubros := '000';
        End;

    // b) Cuántos clientes obtuvieron descuento en los tres rubros
    writeLn(cuentaClientes,' obtuvieron descuento en los tres rubros');

    // Cerrar archivo
    close(archivo);
End.
