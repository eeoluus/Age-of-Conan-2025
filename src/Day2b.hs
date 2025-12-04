import Util.Helper

main :: IO ()
main = do
    input <- readFile "day2.txt"
    let solution = sum . map read . filter invalid . map show . expand 
    print $ solution input

invalid :: String -> Bool
invalid digits = any id checks
    where checks = map (equals . chunk digits) [1..length digits - 1]

expand :: String -> [Int]
expand input = concat $ map parse ranges
    where ranges = split ',' input

parse :: String -> [Int]
parse s = 
    let range = (split '-' s)
        start = read (head range) 
        end   = read (last range) 
    in [start..end]




