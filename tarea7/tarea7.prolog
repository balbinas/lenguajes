%%Matricula 1 A00812215
%%Matricula 2 A01192241
%%Matricula 3 A01280156

%%1. Determinar si dos enteros mayores que 1 son primos relativos. Dos enteros son primos relativos si su único divisor común es el 1. Un divisor de un entero es un entero positivo que lo divide exactamente.
primos_relativos(X, Y) :-
    gcd(X, Y) =:= 1.


%%2. Encontrar un inverso de un entero n módulo m. Un inverso es un entero en el rango 1 <= x < m, tal que
el residuo de dividir x veces n por m sea igual a 1. Puede que el inverso no exista o que haya varios.



%%3. Modifica una lista de enteros repitiendo cada entero su número de veces. 
repite(L, N, X) :-
    length(X, N),
    maplist(=(L), X)


%%4. Cuenta valores repetidos contiguos en una lista plana.



%%5. Decodificar la longitud de las corridas de una lista. Para esto, los términos codificados [N,E] se decodifican
como una secuencia de N copias del elemento E. 



%%6. Intercambiar 2 columnas de una matriz representada como lista de renglones. Asumir que las columnas
especificadas existen y son distintas. 



%%7. Obtener una lista con los elementos de la diagonal de una matriz cuadrada. 



%%8. Determinar si un término dado representa un árbol binario de búsqueda.
Representaremos un árbol binario de búsqueda vacío con el átomo nil y un árbol no vacío con el término
a(R,I,D), donde R denota al nodo raíz e I y D denotan los subárboles izquierdo y derecho, respectivamente.
De esa forma T1 = nil representa a un árbol binario vacío, T2 = a(r,nil,nil) representa un árbol que consiste
solo del nodo raíz que es un nodo hoja, y T3 = a(n1,a(n2,nil,nil),a(n3,nil,nil)) es un árbol que consiste de
3 nodos: n1 que es su raíz, n2 que es la raíz de su subárbol izquierdo y n3 que es la raíz de su subárbol
derecho (n2 y n3 son nodos hoja).
Un árbol binario de búsqueda es un árbol donde el valor de su raíz es mayor o igual que todos los valores
de los nodos de su subárbol izquierdo y menor que todos los valores de su subárbol derecho. Los
subárboles también son árboles binarios de búsqueda. 



%%9. Obtener una lista con el valor de los nodos de un árbol binario de búsqueda que caigan en un rango
correctamente especificado (el primer número define el límite inferior y el segundo el superior). 



%%10. Determinar si un árbol binario está completamente balanceado. Definimos un árbol binario
completamente balanceado como un árbol donde todas sus hojas están en su último nivel y donde su
subárbol izquierdo tiene uno nodo más o un nodo menos que su subárbol derecho. 
