module Day02 where

import           Data.Function ( (&) )

main :: IO ()
main = do
    boxIds <- readFile "data/day-02-box-ids.txt"
    print $ words boxIds
