module Main where

import qualified Data.Set as S

import System.Environment
import System.IO.Unsafe
import System.Random

-- TODO slur words, shout etc

main = do
  args <- getArgs
  let bob = S.fromList args
      vocabulary = selectVocabulary bob

  mapM putStrLn (nextWord bob vocabulary)

selectVocabulary :: S.Set String -> [String]
selectVocabulary bob =
  (compose (map ($ bob) [isChristmas, isSporty, isProgramming])) staples

staples = ["beer", "beard", "pie"]

isProgramming bob w = if hasFlag bob ["--programming", "-p", "--all", "-a"]
                      then w ++ ["chef", "perl", "CPAN"]
                      else w

isSporty bob w = if hasFlag bob ["--sport", "-s", "--all", "-a"]
                 then w ++ ["cricket", "rugby"]
                 else w

isChristmas bob w = if hasFlag bob ["--christmas", "-x", "--all", "-a"]
                    then w ++ ["mince pies", "reindeer"]
                    else w

isDrunk bob = hasFlag bob ["--drunk", "-d"]

isRandom bob = hasFlag bob ["--random", "-r"]

-- Returns a list of words given a bob in some sort of state, and a list of
-- possible words to pick from
nextWord :: S.Set String -> [String] -> [String]
nextWord bob w = (w !! i) : nextWord bob w
                 where i = unsafePerformIO (randomRIO (0, (length w) - 1))

-- Takes the current state and a list of flags to check for
-- Returns true if any of the flags is in the current state, otherwise false.
hasFlag :: S.Set String -> [String] -> Bool
hasFlag bob flags = S.size (S.intersection bob (S.fromList flags)) /= 0

-- Takes a list of functions and returns a single function that applies all of the functions.
compose :: [a -> a] -> a -> a
compose fs v = foldl (flip (.)) id fs $ v
