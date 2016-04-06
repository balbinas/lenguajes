-- ghci haskell.hs
-- :quit
module Haskell where
import Data.List

-- Programación básica y recursiva SIN LISTAS
-- 1. Función moda, obtiene el valor con mayor frecuencia de un grupo de 5 argumentos. En caso de empate regresa el primer valor.
-- moda 8 1 5 4 3 => 8
-- moda 4 2 3 2 1 => 2
-- moda 2 3 3 2 3 => 3
moda :: Int -> Int -> Int -> Int -> Int -> Int
moda a b c d e
-- repeated three times or more
  | (a == b) && (a == c) = a
  | (a == b) && (a == d) = a
  | (a == b) && (a == e) = a
  | (a == c) && (a == d) = a
  | (a == c) && (a == e) = a
  | (a == d) && (a == e) = a

  | (b == c) && (b == d) = b
  | (b == c) && (b == e) = b
  | (b == d) && (b == e) = b

  | (c == d) && (c == e) = c

-- repeated twice
  | (a == b) = a
  | (a == c) = a
  | (a == d) = a
  | (a == e) = a

  | (b == c) = b
  | (b == d) = b
  | (b == e) = b

  | (c == d) = c
  | (c == e) = c

  | otherwise = a


-- 2. Función recursiva tabla que recibe un entero positivo, y despliega su tabla de multiplicar.
-- tabla 4 =>	4 x 1 = 4
--				4 x 2 = 8
--				…
--				4 x 10 = 40
tabla :: Int -> IO ()
tabla x = tablaAux x 1 []

tablaAux :: Int -> Int -> [String] -> IO ()
tablaAux x y r =
  if (y > 10) then mapM_ print r
  else tablaAux x (y+1) (r ++ [(show(x) ++ " x " ++ show(y) ++ " = " ++ show(x*y))])


-- Programación recursiva con Listas
-- 3. Implementar la función recursiva menores en Haskell que reciba 2 listas de números enteros y regrese una lista de sublistas que contengan los enteros de la segunda lista que sean menores que los elementos de la primera; una sublista por cada elemento de la primera lista.
-- menores [1,2,3] [4,5,1] => [[],[1],[1]]
-- menores [2,4,0] [1,2,3,4,5] => [[1],[1,2,3],[]]
menores :: [Int] -> [Int] -> [[Int]]
menores l1 l2 = menoresAux l1 l2 []

menoresAux :: [Int] -> [Int] -> [[Int]] -> [[Int]]
menoresAux (x:xs) l2 r = menoresAux xs l2 (r ++ smaller x l2 [])
menoresAux [] _ r = r

smaller :: Int -> [Int] -> [Int] -> [[Int]]
smaller n (x:xs) r
  | x < n = smaller n xs (r ++ [x])
  | otherwise = smaller n xs r
smaller _ [] r = [r]


-- 4. Función recursiva saltos que recibe 4 enteros (n, i, s1, s2) y regresa una lista con n elementos, que inicien en i y donde los siguientes se obtengan saltando intercaladamente s1 pasos y s2 pasos.
-- saltos 0 1 1 2 => []
-- saltos 7 3 2 5 => [3,5,7,12,14,19,21]
saltos :: Int -> Int -> Int -> Int -> [Int]
saltos n i s1 s2 = salto1 n i s1 s2 []

salto1 :: Int -> Int -> Int -> Int -> [Int] -> [Int]
salto1 0 _ _ _ r = r
salto1 n i s1 s2 r = salto2 (n-1) (i+s1) s1 s2 (r ++ [i])

salto2 :: Int -> Int -> Int -> Int -> [Int] -> [Int]
salto2 0 _ _ _ r = r
salto2 n i s1 s2 r = salto1 (n-1) (i+s2) s1 s2 (r ++ [i])


-- 5. Función recursiva desplaza que recibe un entero y una lista de sublistas, y regresa una lista con la misma estructura que la original (misma cantidad de sublistas y sublistas del mismo tamaño), pero donde sus elementos estén desplazados N posiciones hacia la derecha. El desplazamiento hace que elementos de una sublista pasen a sublistas subsecuentes y debe trabajar de forma circular, de forma que los elementos de la última sublista pasarían a la primera (si no está vacía).
-- desplaza 1 [[1,2,3],[4,5,6]] => [[6,1,2],[3,4,5]]
-- desplaza 3 [[],[1],[2,3],[4,5,6]] => [[],[4],[5,6],[1,2,3]]




-- Estructuras de Datos
-- Un árbol Binario (AB) puede ser representado en Haskell, por medio de la siguiente declaración:
-- 6. Función lista-en-orden que dado un AB y un tipo de recorrido regresa una lista con el contenido del AB en el orden solicitado. Los órdenes posibles serán prefix, infix y postfix.
-- lista_en_orden tree "prefix" => [8,5,2,7,9,15,11]
-- lista_en_orden tree "infix" => [2,5,7,8,9,11,15]
-- lista_en_orden tree "postfix" => [2,7,5,11,15,9,8]
data Tree a = Node (Tree a) a (Tree a) | EmptyTree deriving Show
tree = Node (Node (Node EmptyTree 2 EmptyTree) 5 (Node EmptyTree 7 EmptyTree)) 8 (Node EmptyTree 9 (Node (Node EmptyTree 11 EmptyTree) 15 EmptyTree))

lista_en_orden :: Tree a -> String -> [a]
lista_en_orden t treeType
  | treeType == "prefix" = preOrder t
  | treeType == "infix" = inOrder t
  | treeType == "postfix" = postOrder t
  | otherwise = []


left :: Tree a -> Tree a
left (Node l _ _) = l

right :: Tree a -> Tree a
right (Node _ _ r) = r

root :: Tree a -> a
root (Node _ x _) = x

countNodes :: Tree a -> Int
countNodes EmptyTree = 0
countNodes (Node l _ r) = 1 + (countNodes l) + (countNodes r)

preOrder :: Tree a -> [a]
preOrder EmptyTree = []
preOrder (Node l x r) = [x]++(preOrder l)++(inOrder r)

inOrder :: Tree a -> [a]
inOrder EmptyTree = []
inOrder (Node l x r) = (inOrder l)++[x]++(inOrder r)

postOrder :: Tree a -> [a]
postOrder EmptyTree = []
postOrder (Node l x r) = (postOrder l)++(postOrder r)++[x]


-- 7. Un árbol binario de búsqueda (ABB) es un árbol binario donde la raíz del mismo y de cada subárbol que lo constituye es menor o igual que todos los valores de su subárbol izquierdo y mayor o igual que todos los valores de su subábol derecho. Implementar la funció́n agrega-abb en Scheme que dado un ABB y un valor, regrese un nuevo ABB con el valor insertado adecuadamente.
-- agrega_abb EmptyTree 5 => Node EmptyTree 5 EmptyTree
-- agrega_abb (Node EmptyTree 5 EmptyTree) 8 => Node EmptyTree 5 (Node EmptyTree 8 EmptyTree)
-- agrega_abb (Node EmptyTree 5 (Node EmptyTree 8 EmptyTree)) 2 => Node (Node EmptyTree 2 EmptyTree) 5 (Node EmptyTree 8 EmptyTree)
newNode :: Int -> Tree Int
newNode x = (Node EmptyTree x EmptyTree)

agrega_abb :: Tree Int -> Int -> Tree Int
agrega_abb EmptyTree x = newNode x
agrega_abb (Node l y r) x
  | x > y     = (Node l y (agrega_abb r x))
  | otherwise = (Node (agrega_abb l x) y r)


-- Funciones de Orden Superior y otras facilidades
-- 8. Función recursiva g_disjuntas que utilizando “guardias” implemente un predicado que verifica si dos listas planas pasadas como sus argumentos tienen elementos en común.
-- g_disjuntas [1,2,3] [4,5,1] => False > g_disjuntas [‘a’,‘b’,‘c’] [‘d’,‘e’,‘f’] => True
g_disjuntas :: [Int] -> [Int] -> Bool
g_disjuntas x y
  | (intersect x y == []) = (True)
  | otherwise = False



-- 9. Función no-recursiva c_pares2 que utilizando “comprensión de listas” obtenga una lista ordenada con el cuadrado de los números pares del 2 al n.
-- c_pares2 1 => []
-- c_pares2 10 => [4,16,36,64,100]
c_pares2 :: Int -> [Int]
c_pares2 n = [x * x | x <- [2, 4..(n)] ] 



-- 10. Función no-recursiva f_cuentasub que utilizando la FOS map, cuenta la cantidad de números impares de las sublistas de una lista.
-- f_cuentasub [[1,3,5],[1,2,3]] => [3,2]
-- f_cuentasub [[],[1],[1,2,3],[5,4,3,2,1]] => [0,1,2,3]
f_cuentasub :: [[Int]] -> [Int]
f_cuentasub lista = map (\i-> length (filter odd i)) lista


