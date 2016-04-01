-- ghci haskell.hs
-- :quit
module Haskell where


suma :: Integer -> Integer -> Integer
suma x y = x + y

sumaCuadrados :: Integer -> Integer -> Integer
sumaCuadrados x y = (x*x) + (y*y)

factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial(x-1)

posint :: Int -> [Int] -> Int
posint _ [] = error "no esta el elemento"
posint x (y:list) =
  if (x == y) then 1
  else 1 + posint x list

car :: [a] -> a
car xs = case xs of
  [] -> error "lista vacia"
  (x:_) -> x

data Punto a = Pt a a deriving Show

cuenta :: [Punto Int] -> Int
cuenta [] = 0
cuenta (_:lista) = 1 + (cuenta lista)


data Tree a = Node (Tree a) a (Tree a) | EmptyTree deriving Show

left :: Tree a -> Tree a
left (Node l _ _) = l

right :: Tree a -> Tree a
right (Node _ _ r) = r

root :: Tree a -> a
root (Node _ x _) = x

countNodes :: Tree a -> Int
countNodes EmptyTree = 0
countNodes (Node l _ r) = 1 + (countNodes l) + (countNodes r)

inOrder :: Tree a -> [a]
inOrder EmptyTree = []
inOrder (Node l x r) = (inOrder l)++[x]++(inOrder r)




-- Programación básica y recursiva SIN LISTAS
-- 1. Función moda, obtiene el valor con mayor frecuencia de un grupo de 5 argumentos. En caso de empate regresa el primer valor.
-- moda 8 1 5 4 3 => 8
-- moda 4 2 3 2 1 => 2
-- moda 2 3 3 2 3 => 3


-- 2. Función recursiva tabla que recibe un entero positivo, y despliega su tabla de multiplicar.
-- tabla 4 =>	4 x 1 = 4
--				4 x 2 = 8
--				…
--				4 x 10 = 40


-- Programación recursiva con Listas
-- 3. Implementar la función recursiva menores en Haskell que reciba 2 listas de números enteros y regrese una lista de sublistas que contengan los enteros de la segunda lista que sean menores que los elementos de la primera; una sublista por cada elemento de la primera lista.
-- menores [1,2,3] [4,5,1] => [[],[1],[1]]
-- menores [2,4,0] [1,2,3,4,5] => [[1],[1,2,3],[]]


-- 4. Función recursiva saltos que recibe 4 enteros (n, i, s1, s2) y regresa una lista con n elementos, que inicien en i y donde los siguientes se obtengan saltando intercaladamente s1 pasos y s2 pasos.
-- saltos 0 1 1 2 => []
-- saltos 7 3 2 5 => [3,5,7,12,14,19,21]


-- 5. Función recursiva desplaza que recibe un entero y una lista de sublistas, y regresa una lista con la misma estructura que la original (misma cantidad de sublistas y sublistas del mismo tamaño), pero donde sus elementos estén desplazados N posiciones hacia la derecha. El desplazamiento hace que elementos de una sublista pasen a sublistas subsecuentes y debe trabajar de forma circular, de forma que los elementos de la última sublista pasarían a la primera (si no está vacía).
-- desplaza 1 [[1,2,3],[4,5,6]] => [[6,1,2],[3,4,5]]
-- desplaza 3 [[],[1],[2,3],[4,5,6]] => [[],[4],[5,6],[1,2,3]]


-- Estructuras de Datos
-- Un Árbol Binario (AB) puede ser representado en Haskell, por medio de la siguiente declaración:
-- data AB t = A (AB t) t (AB t) | V deriving Show
-- 6. Función lista-en-orden que dado un AB y un tipo de recorrido regresa una lista con el contenido del AB en el orden solicitado. Los órdenes posibles serán prefix, infix y postfix.
-- AB = A (A (A V 2 V) 5 (A V 7 V)) 8 (A V 9 (A (A V 11 V) 15 V))
-- lista_en_orden AB "prefix" => [8,5,2,7,9,15,11]
-- lista_en_orden AB "infix" => [2,5,7,8,9,11,15]
-- lista_en_orden AB "postfix" => [2,7,5,11,15,9,8]


-- 7. Un árbol binario de búsqueda (ABB) es un árbol binario donde la raíz del mismo y de cada subárbol que lo constituye es menor o igual que todos los valores de su subárbol izquierdo y mayor o igual que todos los valores de su subábol derecho. Implementar la funció́n agrega-abb en Scheme que dado un ABB y un valor, regrese un nuevo ABB con el valor insertado adecuadamente.
-- agrega_abb V 5 => A V 5 V
-- agrega_abb (A V 5 V) 8 => A V 5 (A V 8 V)
-- agrega_abb (A V 5 (A V 8 V)) 2 => A (A V 2 V) 5 (A V 8 V)

-- Funciones de Orden Superior y otras facilidades
-- 8. Función recursiva g_disjuntas que utilizando “guardias” implemente un predicado que verifica si dos listas planas pasadas como sus argumentos tienen elementos en común.
-- g_disjuntas [1,2,3] [4,5,1] => False > g_disjuntas [‘a’,‘b’,‘c’] [‘d’,‘e’,‘f’] => True


-- 9. Función no-recursiva c_pares2 que utilizando “comprensión de listas” obtenga una lista ordenada con el cuadrado de los números pares del 2 al n.
-- c_pares2 1 => []
-- c_pares2 10 => [4,16,36,64,100]


-- 10. Función no-recursiva f_cuentasub que utilizando la FOS map, cuenta la cantidad de números impares de las sublistas de una lista.
-- f_cuentasub [[1,3,5],[1,2,3]] => [3,2]
-- f_cuentasub [[],[1],[1,2,3],[5,4,3,2,1]] => [0,1,2,3]

