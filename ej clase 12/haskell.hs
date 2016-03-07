-- to run:
-- ghci haskell.hs
----
-- to exit:
-- :quit


module Haskell where

-- 1: fibonacci
fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci n = fibonacciAux (n-1) 1 0

fibonacciAux :: Integer -> Integer -> Integer -> Integer
fibonacciAux 0 a _ = a
fibonacciAux n a b = fibonacciAux (n-1) (a+b) a


-- 2: mayor [regresa el mayor de una lista]
mayor :: [Integer] -> Integer
mayor (a:list) = mayorAux list a

mayorAux :: [Integer] -> Integer -> Integer
mayorAux [] x = x
mayorAux (a:list) x =
  if (a > x) then mayorAux list a
  else mayorAux list x


-- 3: mezcla [regresa la union de dos listas con los datos ordenados]
mezcla :: [Integer] -> [Integer] -> [Integer]
mezcla l1 l2 = mezclaAux l1 l2 []

mezclaAux :: [Integer] -> [Integer] -> [Integer] -> [Integer]
mezclaAux [] [] l3 = l3
mezclaAux l1 [] l3 = (l3++l1)
mezclaAux [] l2 l3 = (l3++l2)
mezclaAux (a:l1) (b:l2) l3 =
  if (a < b) then mezclaAux l1 (b:l2) (l3++[a])
  else mezclaAux (a:l1) l2 (l3++[b])


-- 4: repetidos [regresa una lista con los datos repetidos de la lista que recibe]
repetidos :: [Integer] -> [Integer]
repetidos l1 = repetidosAux l1 []

repetidosAux :: [Integer] -> [Integer] -> [Integer]
repetidosAux [] result = result
repetidosAux (a:list) result =
  if (find a list) then repetidosAux (del a list []) (result++[a])
  else repetidosAux list result


-- auxiliar, busca un numero en una lista
find :: Integer -> [Integer] -> Bool
find _ [] = False
find x (y:list) =
  if (x == y) then True
  else find x list

-- auxiliar, borra un numero de una lista
del :: Integer -> [Integer] -> [Integer] -> [Integer]
del _ [] result = result
del x (y:list) result =
  if (x == y) then del x list result
  else del x list (result++[y])