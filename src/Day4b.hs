import Control.Monad.Trans.State
import Data.Array
import Data.Maybe

type Department = Array (Int, Int) Char

main :: IO ()
main = do 
    input <- readFile "day4.txt"
    let a = listArray ((1, 1), (139, 139)) $ concat $ lines input
    let b = converge a
    let bLen = length . filter (== '@') $ elems b
    let aLen =  length $ filter (== '@') $ concat $ lines input
    print $ aLen - bLen

converge :: Department -> Department
converge dept = if rolls dept' /= rolls dept then converge dept' else dept'
    where dept' = process dept
          rolls d = length $ filter (== '@') $ elems d

process :: Department -> Department
process dept =
    let ((minx, miny), (maxx, maxy)) = bounds dept

        replace :: ((Int, Int), Char) -> ((Int, Int), Char)
        replace (position, rollerino) = (position, check position rollerino)

        check :: (Int, Int) -> Char -> Char
        check (x, y) rollerino
            | rolls < 4  = '.'
            | otherwise  = rollerino
            where up        = if x > minx then Just (dept ! (x - 1, y)) else Nothing 
                  upright   = if x > minx && y < maxy then Just (dept ! (x - 1, y + 1)) else Nothing
                  right     = if y < maxy then Just (dept ! (x, y + 1)) else Nothing
                  downright = if x < maxx && y < maxy then Just (dept ! (x + 1, y + 1)) else Nothing
                  down      = if x < maxx then Just (dept ! (x + 1, y)) else Nothing
                  downleft  = if x < maxx && y > miny then Just (dept ! (x + 1, y - 1)) else Nothing
                  left      = if y > miny then Just (dept ! (x, y - 1)) else Nothing
                  upleft    = if x > minx && y > miny then Just (dept ! (x - 1, y - 1)) else Nothing
                  rolls     = length $ filter (== '@') $ catMaybes [up, upright, right, downright, down, downleft, left, upleft]

    in array ((minx, miny), (maxx, maxy)) $ map replace $ assocs dept
