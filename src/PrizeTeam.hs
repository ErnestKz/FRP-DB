module PrizeTeam where

import qualified Data.Map                    as Map
import qualified Data.Set                    as Set
import           Reactive.Banana.Combinators

import           StatsTeam                   (User, UserNthClick,
                                              nthClickBetweenRedAndBlue)

data PrizeWinner = PrizeWinner User PrizeSize
data PrizeSize = Big | Medium | Small
  deriving (Eq, Ord)

type PrizesTaken = Map.Map PrizeSize User

prizeSizeNumber :: Map.Map Integer PrizeSize
prizeSizeNumber = Map.fromList [(10, Small), (20, Medium), (30, Big)]

congratulateUser :: Event UserNthClick -> Behavior PrizesTaken -> Event PrizeWinner
congratulateUser nthCliks prizesTaken = undefined




  -- where
  --   takenPrizesB = Map.keysSet <$> prizesTaken
  --   availablePrizesB = Set.difference (Set.fromList [Big, Medium, Small]) <$> takenPrizesB

-- check if the new event is one of the elements in the prizeMap
-- And that the value in prizes taken is not a key in the prizestaken behaviour

prizesTaken :: Event PrizeWinner -> Behavior PrizeWinner
prizesTaken = undefined
