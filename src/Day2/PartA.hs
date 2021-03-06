import System.IO
import Text.Regex.Posix

data ParsedComponents = ParsedComponents Int Int Char String

strToInt :: String -> Int
strToInt a = read a :: Int

validPassword :: ParsedComponents -> Bool
validPassword (ParsedComponents mi ma c s) = x >= mi && x <= ma
    where x  = length [z | z <- s, z == c]
              
matchLine :: String -> [String]
matchLine "" = [""]
matchLine a = (a =~ "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" :: [[String]]) !! 0

parsed :: [String] -> ParsedComponents
parsed xs = ParsedComponents (strToInt (xs!!1)) (strToInt (xs!!2)) (((xs!!3) !! 0)) (xs!!4)

conquerer :: [String] -> Int -> Int
conquerer [] v = v
conquerer (i:is) v
    | r == True  = conquerer is v+1
    | otherwise  = conquerer is v
        where r = validPassword (parsed (matchLine i))

main = do
    contents <- readFile "Input.txt"
    print ( conquerer ( lines ( contents ) ) 0)
