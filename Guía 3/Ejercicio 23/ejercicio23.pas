{Un archivo contiene palabras (letras mayúsculas, minúsculas, dígitos, caracteres especiales)
separadas entre sí por uno o más blancos. Se debe verificar para cada una si se trata de una contraseña
válida, y en ese caso grabarla en un archivo de salida. Indicar al final del proceso el porcentaje de
palabras que no son contraseñas válidas y mostrar la contraseña inválida más larga (puede no existir).
Una contraseña válida debe:
    - estar conformada como mínimo por 8 caracteres,
    - incluir obligatoriamente, al menos una letra mayúscula y al menos una minúscula
    - incluir exactamente cuatro dígitos.
    - no contener caracteres diferentes de letras y digitos}

Program ejercicio23;

var
    // Palabras y caracteres
        contrasenia:string;
        caracter:char;
    
    // Condicion 2
        mayuscula,minuscula:boolean;
    
    // Condicion 3
        cuentaDigitos:byte;
    
    // Condicion 4
        especiales:boolean;
    
    // Contadores
        cuentaContra,cuentaInvalida:byte;
    
    // Archivos de texto
        archivoE,archivoS:text;

    // Otros
        porcentaje:real;
        ciml:string; {CIML: Contraseña Invalida Mas Larga}
begin
    // Inicializar variables
        cuentaContra:=0;
        cuentaInvalida:=0;
        contrasenia:='';
        mayuscula:=false;
        minuscula:=false;
        cuentaDigitos:=0;
        especiales:=false;
        ciml:='';
    
    // Archivos de texto
        assign(archivoE,'entrada.txt');
        assign(archivoS,'salida.txt');
        reset(archivoE);
        rewrite(archivoS);
    
    // Leer archivo de entrada
        while not eof(archivoE) do
            begin
                // Leer caracter
                    read(archivoE,caracter);
                
                // Si es blanco, analizar contraseña y seguir leyendo hasta que se encuentra la proxima palabra
                    if caracter=' ' then
                      begin
                        if contrasenia<>'' then
                          begin
                            cuentaContra:=cuentaContra+1;
                            if (length(contrasenia)>=8) and mayuscula and minuscula and (cuentaDigitos=4) and not especiales then
                                write(archivoS,contrasenia,' ')
                            else
                                begin
                                cuentaInvalida:=cuentaInvalida+1;
                                if length(contrasenia)>length(ciml) then
                                    ciml:=contrasenia;
                                end;
                            
                            // Reiniciar variables
                                contrasenia:='';
                                mayuscula:=false;
                                minuscula:=false;
                                cuentaDigitos:=0;
                                especiales:=false;
                          end;
                        
                        
                        // Buscar próxima palabra
                            repeat
                                read(archivoE,caracter);
                            until (caracter<>' ') or eof(archivoE);

                        if not eof(archivoE) then
                        begin
                            contrasenia:=caracter;
                            case caracter of
                                'A'..'Z':mayuscula:=true;
                                'a'..'z':minuscula:=true;
                                '0'..'9':cuentaDigitos:=cuentaDigitos+1;
                                else
                                    especiales:=true;
                        end;
                            
                        end;
                      end
                    else
                        contrasenia:=contrasenia+caracter;
                        case caracter of
                            'A'..'Z':mayuscula:=true;
                            'a'..'z':minuscula:=true;
                            '0'..'9':cuentaDigitos:=cuentaDigitos+1;
                            else
                                especiales:=true;
                        end;
            end;
    
    // Procesar ultima contraseña
        if caracter<>' ' then
            begin
              cuentaContra:=cuentaContra+1;
                if (length(contrasenia)>=8) and mayuscula and minuscula and (cuentaDigitos=4) and not especiales then
                    write(archivoS,contrasenia,' ')
                else
                    begin
                        cuentaInvalida:=cuentaInvalida+1;
                        if length(contrasenia)>length(ciml) then
                            ciml:=contrasenia;
                    end;
            end;
                
    
    // Cerrar archivos
        close(archivoE);
        close(archivoS);
    
    // Salida de datos
        porcentaje:=cuentaInvalida/cuentaContra*100;
        writeLn('El % de contraseñas invalidas es de ',porcentaje:5:2,'%');
        writeLn('La contraseña invalida mas larga es ',ciml);
end.