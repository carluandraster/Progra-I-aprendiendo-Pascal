{Dada una cantidad X de pesos y un tipo de moneda extranjera, ambos ingresados por teclado, se
desea determinar e informar cuánto se puede comprar dada la siguiente tabla de cotizaciones: 

     MONEDA      COMPRA
    D=Dólar     $ 120.80
    E=Euro      $ 150.10
    R=Real      $ 26.50 }

Program ejercicio13;

const
    dolar=120.80;
    euro=150.10;
    realBrasilero=26.50; {real es una palabra reservada}

var
    X,Y:real; {Donde X es la cantidad de pesos e Y, la cantidad de moneda extranjera}
    tipoDeCambio:char;

begin
    // Preguntar moneda extranjera
        writeLn('¿Que moneda desea omprar: dolar (D), euro (E) o real (R)');
        readLn(tipoDeCambio);
        tipoDeCambio:=upcase(tipoDeCambio);
    
    // Preguntar por la cantidad X de pesos
        writeLn('¿Con cuantos pesos cuenta para hacer la operacion?');
        readLn(X);
    
    // Calcular y devolver Y
        case tipoDeCambio of
            'D': 
                begin
                    Y:=X/dolar;
                    writeLn('Usted podra comprar ',Y:8:2,' dolares');
                end;
            'E':
                begin
                    Y:=X/euro;
                    writeLn('Usted podra comprar ',Y:8:2,' euros');
                end;
            'R':
                begin
                    Y:=X/realBrasilero;
                    writeLn('Usted podra comprar ',Y:8:2,' reales');
                end;
        end;
end.