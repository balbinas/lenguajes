-- to run:
-- ghci haskell.hs
----
-- to exit:
-- :quit
module Haskell where

-- 1: aplica_fns
-- Funcion sin recursion explicita que aplica los procedimientos binarios
-- a un par de valores
-- aplica_fns [(+),(-),(*)] 6 3 => [9,3,18]
aplica_fns :: [(Int -> Int -> Int)] -> Int -> Int -> [Int]
aplica_fns (x) a b = aplicaAux (x) a b []

aplicaAux :: [(Int -> Int -> Int)] -> Int -> Int -> [Int] -> [Int]
aplicaAux [] _ _ r = r
aplicaAux (x:xs) a b r = aplicaAux xs a b (r++[(x) a b])


-- 2: reduce
-- Funcion sin recursion explicita que regresa el resultado de aplicar un
-- procedimiento binario a los valores que cumplan con un predicado
-- reduce (*) even [1,2,3,4,5] => 8
-- reduce (+) odd [1,2,3,4,5] => 9
reduce :: (Int -> Int -> Int) -> (Int -> Bool) -> [Int] -> Int
reduce (op) (b) (x) = reduceAux (op) (filter (b) (x))

reduceAux :: (Int -> Int -> Int) -> [Int] -> Int
reduceAux (op) (x:xs) = foldl (op) x xs


-- 3: secuencia
-- Funcion sin recursion explicita que genera listas con los numeros 1 a N
-- usando la funcion until
-- secuencia 3 => [1,2,3]
secuencia :: Int -> [Int]
secuencia x = [1..x]

--until (> 5) (+ 2) 2 => 6