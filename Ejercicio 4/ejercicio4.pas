
Program ejercicio4;


Const 
    LimInf =       10;
    LimSup =       255;

Var 
    X,Y:       real;
    N,M:       integer;
    Cadena:       string;
    Car:       char;
    Mayus, Cumple, Ok:       boolean;

Begin
    Cumple :=   True;
    N :=   20;
    M :=   1;
    X :=   5.8;
    Y :=   12.7;
    car :=   'B';
    N := trunc(X)+LimInf;
    Write(N);
End.
