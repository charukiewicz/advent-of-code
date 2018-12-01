module Day01 where

import           Data.Function ( (&) )

main :: IO ()
main = do
    frequencies <- readFile "frequencies.txt"
    let frequencyList = cleanFrequencyInput frequencies
        -- Bangs (!) are used so that the output is printed after evalulation
        !resultingFrequency = sum frequencyList
        !repeatedFrequency = findRepeatedFreq $ cycle frequencyList

    putStrLn $ "Part 1: The resulting frequency is " ++ show resultingFrequency
    putStrLn $ "Part 2: The first repeated frequency is " ++ show repeatedFrequency

-- | Takes an input string from file and removes 
-- the '+' character, then converts to an Int
cleanFrequencyInput :: String -> [Int]
cleanFrequencyInput freqInput =
    freqInput
        & words
        & fmap (dropWhile $ (==) '+')
        & fmap (read :: String -> Int)

-- | Finds the first repeated frequency by
-- scanning the input list and maintaining
-- a list of successive frequency values
-- used to check each new frequency value
findRepeatedFreq :: [Int] -> Int
findRepeatedFreq (firstFreq:remFreq) =
    go remFreq [] firstFreq
        where
            go (nextMod:xs) prevFList currFreq
              | currFreq `elem` prevFList = currFreq
              | otherwise =
                    go xs (currFreq:prevFList) (currFreq + nextMod)
