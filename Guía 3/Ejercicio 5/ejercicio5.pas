{Generar y mostrar los múltiplos de K menores que un valor Q. (K y Q se leen de teclado)}

Program ejercicio5;

var
    K,Q,i:byte;

begin
    // Inicializar variables
        i:=0;
    
    // Preguntar por Q
        writeLn('Ingrese un valor maximo');
        readLn(Q);
    
    // Preguntar por K
        writeLn('Ingrese un numero para saber sus multiplos menores a ',Q);
        readLn(K);
    
    // Mensaje previo al bucle
        writeLn('Los multiplos de ',K,' menores a ',Q,' son:');
    
    // Generar y mostrar los multiplos de K menores a Q
        while K*i<Q do
            begin
              writeLn(K*i);
              i:=i+1;
            end;
end.