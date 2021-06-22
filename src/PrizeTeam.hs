module PrizeTeam where

import qualified Data.Map                    as Map
import           Data.Maybe                  (isJust, isNothing)
import qualified Data.Set                    as Set
import           Reactive.Banana.Combinators

import           StatsTeam                   (User, UserNthClick, getUserName,
                                              getUserNth,
                                              nthClickBetweenRedAndBlue)

data PrizeWinner = PrizeWinner User PrizeSize
  deriving Show

data PrizeSize = Big | Medium | Small
  deriving (Eq, Ord, Show)

type PrizesTaken = Map.Map PrizeSize User

prizeSizeNumberMap :: Map.Map Integer PrizeSize
prizeSizeNumberMap = Map.fromList [(10, Small), (20, Medium), (30, Big)]

congratulateUser :: Event UserNthClick -> Behavior PrizesTaken -> Event PrizeWinner
congratulateUser nthCliks prizesTaken = filterApply (prizeAvailable <$> prizesTaken) possibleWinners
  where
    prizeAvailable :: PrizesTaken -> PrizeWinner -> Bool
    prizeAvailable prizesTaken (PrizeWinner _ prizeSize) = isNothing $ prizesTaken Map.!? prizeSize

    possibleWinners = createWinner <$> filterE reachThreshold nthCliks
    reachThreshold u = isJust $ prizeSizeNumberMap Map.!? getUserNth u
    createWinner userNthClick = PrizeWinner (getUserName userNthClick) (prizeSizeNumberMap Map.! getUserNth userNthClick)

prizesTaken :: MonadMoment m => Event PrizeWinner -> m (Behavior PrizesTaken)
prizesTaken prizeWinners = accumB Map.empty $ fmap updatePrizes prizeWinners
  where
    updatePrizes :: PrizeWinner -> PrizesTaken -> PrizesTaken
    updatePrizes (PrizeWinner user prizeSize) previousPrizeTakers = Map.insert prizeSize user previousPrizeTakers
