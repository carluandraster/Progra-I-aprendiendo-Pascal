{En un archivo de texto se ha grabado por cada línea, una cadena (es una clave encriptada que
puede contener letras, números y caracteres especiales (&, $, #, etc.), y que siempre termina en
letra), luego uno o más blancos y tres números separados por blancos, por último uno o más
blancos y una letra.
Ejemplo: mU&1#hT34*A 80 40 30 P
Se pide, a partir del archivo, cargar tres arreglos paralelos:
• VClave contendrá las claves sin los caracteres especiales, que registren en su encriptación
hasta tres caracteres especiales (las claves que tengan más de tres invalidan la información de
la línea, que no se almacena)
• VProm almacena el promedio de los tres números.
• VCar almacena el caracter que está al final de la línea, siempre que no coincida con la última
letra de la clave, en cuyo caso invalida la información de la línea, que no se almacena)
Mostrar los arreglos generados, y luego para una letra y una clave que se ingresan por teclado:
a) Para la letra ingresada, calcular e informar la clave de máximo promedio.
b) Para la clave ingresada, informar el promedio y la letra asociada (puede no existir) }

Program ejercicio12;

type