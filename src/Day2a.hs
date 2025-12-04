import Util.Helper

main :: IO ()
main = do
    input <- readFile "day2.txt"
    let solution =  sum . map read . filter invalid . candidates . expand 
    print $ solution input

invalid :: String -> Bool 
invalid digits = fst patterns == snd patterns
    where patterns = splitAt (length digits `div` 2) digits

expand :: String -> [Int]
expand input = concat $ map parse ranges
    where ranges = split ',' input

parse :: String -> [Int]
parse s = 
    let range = (split '-' s)
        start = read (head range) 
        end   = read (last range) 
    in [start..end]

candidates :: [Int] -> [String]
candidates = filter relevant . map show
    where relevant = even . length 




