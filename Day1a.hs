import Control.Monad.Trans.State

main :: IO ()
main = do
    input <- readFile "day1.txt"

    let dial = rotate 50 $ cycle [0..99]
    let rotations = map parse $ lines input
    let mask = evalState (traverse zeros rotations) dial

    print . length $ filter id mask 

{- point-free for fun  -}
rotate :: Int -> [Int] -> [Int]
rotate = drop 

parse :: String -> Int
parse instruction = dividend `mod` 100
    where amount   = read $ tail instruction :: Int
          dividend = if head instruction == 'R' then amount else negate amount

zeros :: Int -> State [Int] Bool
zeros clicks = state $ \dial -> let result = rotate clicks dial
                                in (head result == 0, result)