#!/usr/bin/env nix-shell
#!nix-shell -i ghci -p "with import <nixpkgs> { }; haskellPackages.ghcWithPackages (pkgs: with pkgs; [ strict ])"

-- #!nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz

import qualified System.IO.Strict as Strict ( readFile )

main :: IO ()
main = do
    massListInput <- Strict.readFile "input.txt"
    let massList = read <$> lines massListInput :: [Int]
    putStrLn $ "Part 1: " ++ show (sum $ calculateFuel <$> massList)
    putStrLn $ "Part 2: " ++ show (sum $ calculateTotalFuel <$> massList)

calculateFuel :: Int -> Int
calculateFuel mass =
    (mass `div` 3) - 2

calculateTotalFuel :: Int -> Int
calculateTotalFuel mass
    | fuelAmount <= 0 = 0
    | otherwise = fuelAmount + calculateTotalFuel fuelAmount
      where
        fuelAmount = calculateFuel mass
