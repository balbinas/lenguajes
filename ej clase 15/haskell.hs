-- to run:
-- ghci haskell.hs
----
-- to exit:
-- :quit
module Haskell where

-- 1: cuenta_signo
cuenta_signo :: [Int] -> (Int, Int)
cuenta_signo l = cuentaAux l (0, 0)

cuentaAux :: [Int] -> (Int, Int) -> (Int, Int)
cuentaAux [] r = r
cuentaAux (x:xs) (neg, pos)
  | x < 0 = cuentaAux xs (neg+1, pos)
  | x > 0 = cuentaAux xs (neg, pos+1)
  | otherwise = cuentaAux xs (neg, pos)


-- 2: separa
separa :: Int -> [Int] -> ([Int], [Int])
separa a list = ([x | x <- list, x < a], [x | x <- list, x >= a])


-- 3: mclaurin
-- mclmclaurin = x^0 + x^1 + x^2 + x^3 + …
mclaurin :: Float -> Int -> Float
mclaurin x n = sum (map sq (zip [x,x..] [0..(n-1)]))

sq :: (Float,Int) -> Float
sq (a,b) = a^b