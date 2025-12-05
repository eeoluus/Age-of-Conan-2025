import Util.Helper
import Data.Char

main :: IO ()
main = do
    input <- readFile "day3.txt"
    print 
        $ sum 
        $ map read 
        $ map (map intToDigit) 
        $ map (zagzig 12) 
        $ map (map digitToInt) 
        $ lines input

zagzig :: Int -> [Int] -> [Int]
zagzig 0 _ = []
zagzig counter numbers =
    let counter' = counter - 1        
        -- in this case we always look left: there's nothing on the right
        go (left, right : []) = zagzig counter' left ++ [right]
        -- allocation based on how much is left on the right... (pun unintended)
        go (left, right : r ) 
            | allocation < 0 = zagzig counter'' left ++ [right] ++ zagzig counter''' r
            | otherwise      = [right] ++ zagzig counter' r -- plenty on the right
            where 
                allocation = length r - counter' 
                counter''  = abs allocation
                counter''' = length r
        go whatever = []

    in go $ break (== maximum numbers) numbers
