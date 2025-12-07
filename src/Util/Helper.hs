module Util.Helper
( split
, chunk
, equals
, io
) where

-- note: doesn't handle trailing whitespace
split :: Char -> String -> [String]
split _ [] = []
split delimiter s = word : split delimiter (drop 1 s') -- drop to discard the delimiter
    where (word, s') = break (== delimiter) s -- for example, on space: ("Hello,", " world!")

chunk :: String -> Int -> [String] 
chunk [] _ = []
chunk s size = fst partition : chunk (snd partition) size 
    where partition = splitAt size s

-- all equal to each other
equals :: Eq a => [a] -> Bool
equals (x:[]) = True
equals (x:xs) = if x == head xs then equals xs else False 

io :: Show a => FilePath -> (String -> a) -> IO ()
io path solve = do readFile path >>= \input -> print $ solve input 
