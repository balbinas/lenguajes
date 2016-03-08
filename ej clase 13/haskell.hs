-- to run:
-- ghci haskell.hs
----
-- to exit:
-- :quit
module Haskell where

-- 1: minima
minima :: [(Int, (String), ([Int]))] -> [(String, Int)]
minima [] = []
minima ((_, s, c):rest) = [(s, minimum c)]++(minima rest)


-- 2: valores
data AB e = N (AB e) e (AB e) | AV deriving Show

valores :: AB a -> [a]
valores AV = []
valores (N l x r) = [x]++(valores l)++(valores r)


-- 3: cuenta
data LA e = E e | L [LA e] deriving Show

cuenta :: LA e -> Int
cuenta (L []) = 0
cuenta (E e) = 1
cuenta (L (x:rest)) = (cuenta x) + (cuenta (L rest))