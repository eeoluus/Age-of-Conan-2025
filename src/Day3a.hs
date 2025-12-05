import Util.Helper
import Data.Char

main :: IO ()
main = do
    input <- readFile "day3.txt"
    print 
        $ sum 
        $ map read 
        $ map (map intToDigit) 
        $ map zigzag 
        $ map (map digitToInt) 
        $ lines input

zigzag :: [Int] -> [Int]
zigzag numbers =
    let go (left, right : []) = maximum left : [right]
        go (left, right : r ) = right : [maximum r] 
    in go $ break (== maximum numbers) numbers
