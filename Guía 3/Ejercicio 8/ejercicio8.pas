Program Ejercicio8;
Var
    Arch: text;
    A, Sum, Cont : integer;
    promedio:real;
Begin
    // Asignar a la variable Arch el archivo txt
        Assign( Arch, 'datos.TXT' );

    // Preparar el archivo para la lectura
        Reset ( Arch );
    
    // Inicializar variables
        Sum:=0;
        Cont := 0;
    
    // Leer archivo
        While NOT eof ( Arch ) do
            Begin
                Readln( Arch, A );
                If A > 0 then
                    begin
                        Sum := Sum + A ; Cont := Cont + 1;
                    End;
            End;
    
    // Cerrar archivo
        Close ( Arch );
    
    // Se ingresaron números positivos?
    If Cont <> 0 then
        begin
            promedio:=Sum / Cont; {De ser así, sacar promedio}
            Writeln(promedio:5:2);
        end   
    Else
        Writeln ('no hay numeros positivos');
End. 

{Respuesta
Lo que hace el programa es tomar números de datos.TXT y sacar un promedio de los números 
positivos, que es lo que termina mostrando en pantalla al usuario}