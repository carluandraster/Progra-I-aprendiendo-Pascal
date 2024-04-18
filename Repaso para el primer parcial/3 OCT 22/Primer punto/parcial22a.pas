Program punto1;

var
    sumando1,sumando2,sumando3,sumaTotal:word;
    caracter,numStr:char;
    n1,n2,n3:byte;

begin
    // Ingresar datos por teclado

    writeLn('Ingrese un caracter: ');
    readLn(caracter);

    writeLn('Ingrese un digito');
    readLn(numStr);
    val(numStr,n1);

    writeLn('Ingrese un digito');
    readLn(numStr);
    val(numStr,n2);

    writeLn('Ingrese un digito');
    readLn(numStr);
    val(numStr,n3);

    // Primer sumando
    sumando1:=n1*100+n2*10+n3;

    // Segundo sumando
    if (n3>n2) and (n3>n1) then sumando2:=3*n3
    else
        if (n2>n1) and (n2>n3) then sumando2:=2*n2
        else sumando2:=n1;
    
    // Tercer sumando
    if caracter in ['a'..'z'] then
        if (caracter='a') or (caracter='e') or (caracter='i') or (caracter='o') or (caracter='u') then
            sumando3:=1000
        else
            sumando3:=2000
    else
        if caracter in ['A'..'Z'] then
            sumando3:=3000
        else
            sumando3:=4000;
    
    // Sumatoria total
    sumaTotal:=sumando1+sumando2+sumando3;

    if odd(sumaTotal) then
        writeLn('CODIGO INVALIDO!!!')
    else
        writeLn(sumaTotal);
end.