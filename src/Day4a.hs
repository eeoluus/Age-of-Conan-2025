import Util.Helper (io)
import Data.Array
import Data.List
import Control.Monad
import Data.Maybe

main :: IO ()
main = io "day4.txt" $ length . filter id . operable . gridify

type Forklift = Bool

type Position = [Int]
type Roll = Char
type Location = (Maybe Roll, Position)

parse :: Char -> Maybe Roll
parse '@' = Just '@'
parse _ = Nothing

empty :: Location -> Bool
empty (Nothing, _) = False
empty _ = True

operable :: [Location] -> [Forklift]
operable grid = map (available . map fst) ns
    where contexts = separate grid
          contexts' = filter (empty . fst) contexts
          ns = map neighbors contexts'

-- create a coordinate grid with all the content
gridify :: String -> [Location]
gridify diagram = flip zip coordinates . map parse $ filter (/= '\n') diagram
    where width = length . head $ lines diagram
          depth = length $ lines diagram
          coordinates = [[x, y] | x <- [1..width], y <- [1..depth]]

-- following the Haskell mailing list idea:
-- https://mail.haskell.org/pipermail/libraries/2008-February/009270.html
-- return e.g. [(1, [2, 3]), (2, [1, 3]), (3, [1, 2])]
separate :: [Location] -> [(Location, [Location])]
separate [] = []
separate (current:context) 
    = (current, context) : [ -- grab the current value 
        (next, current:context') | (next, context') <- separate context
    ] -- current:context' builds the rest of the elements
      -- including the current (or, previous, at the time of recursive call)

inside :: [Position] -> Location -> Bool
inside neighborhood location = snd location `elem` neighborhood

-- what qualifies as a neighbor
near :: Position -> Position -> Bool
near a b = all (< 2) $ map abs $ zipWith (-) a b

-- the "look around" function
neighbors :: (Location, [Location]) -> [Location]
neighbors (l, locations) = filter (inside neighborhood) locations
    where positions = map snd locations
          neighborhood = filter (near $ snd l) positions

available :: [Maybe Roll] -> Forklift
available ns = rolls < 4
    where rolls = length $ catMaybes ns
