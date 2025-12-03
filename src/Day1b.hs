import Control.Monad.Trans.State

main :: IO ()
main = do
    input <- readFile "day1.txt"

    let dial = drop 50 $ cycle [0..99]
    let instructions = lines input
    let mask = evalState (traverse rotate instructions) dial

    print $ sum mask

zeros :: Int -> Int -> Int
zeros current offset
    | result == 0                = 1
    | within 0 100 result        = 0
    | result < 0 && current == 0 = 0
    | otherwise                  = 1
    where result = current + offset

rotate :: String -> State [Int] Int
rotate instruction = state $ \dial ->
    let direction = head instruction
        clicks    = parse $ tail instruction
        current   = head dial

        {- full cycles -}
        cycles    = div clicks 100

        {- offset from current -}
        offset    = mod clicks 100

        {- crosses include hits -}
        crosses   = zeros current $ turn direction offset     

        {- update the dial -}
        rotation  = turn direction clicks
        result    = drop (mod rotation 100) dial
    in (crosses + cycles, result)

within :: Int -> Int -> Int -> Bool
within lower upper number 
    = lower < number && number < upper

parse :: String -> Int
parse = read

turn :: Num a => Char -> a -> a
turn direction = if direction == 'L' then negate else id
